/* 
  ** por compatibilidad se omiten tildes **
  ================================================================================
  TRABAJO PRACTICO 3 - System Programming - ORGANIZACION DE COMPUTADOR II - FCEN
  ================================================================================

  Definicion de funciones del manejador de memoria
*/
      
#include "mmu.h"
#include "i386.h"

#include "kassert.h"

static pd_entry_t* kpd = (pd_entry_t*)KERNEL_PAGE_DIR;
static pt_entry_t* kpt = (pt_entry_t*)KERNEL_PAGE_TABLE_0;

static const uint32_t identity_mapping_end = 0x003FFFFF;
static const uint32_t user_memory_pool_end = 0x02FFFFFF;

static paddr_t next_free_kernel_page = 0x100000;
static paddr_t next_free_user_page = 0x400000;

/**
 * kmemset asigna el valor c a un rango de memoria interpretado
 * como un rango de bytes de largo n que comienza en s
 * @param s es el puntero al comienzo del rango de memoria
 * @param c es el valor a asignar en cada byte de s[0..n-1]
 * @param n es el tamaño en bytes a asignar
 * @return devuelve el puntero al rango modificado (alias de s)
*/
static inline void* kmemset(void* s, int c, size_t n) {
  uint8_t* dst = (uint8_t*)s;
  for (size_t i = 0; i < n; i++) {
    dst[i] = c;
  }
  return dst;
}

/**
 * zero_page limpia el contenido de una página que comienza en addr
 * @param addr es la dirección del comienzo de la página a limpiar
*/
static inline void zero_page(paddr_t addr) {
  kmemset((void*)addr, 0x00, PAGE_SIZE);
}


void mmu_init(void) {}


/**
 * mmu_next_free_kernel_page devuelve la dirección física de la próxima página de kernel disponible. 
 * Las páginas se obtienen en forma incremental, siendo la primera: next_free_kernel_page
 * @return devuelve la dirección de memoria de comienzo de la próxima página libre de kernel
 */
paddr_t mmu_next_free_kernel_page(void) {
  paddr_t freePage = next_free_kernel_page;
  next_free_kernel_page += PAGE_SIZE;
  return freePage;
}

/**
 * mmu_next_free_user_page devuelve la dirección de la próxima página de usuarix disponible
 * @return devuelve la dirección de memoria de comienzo de la próxima página libre de usuarix
 */
paddr_t mmu_next_free_user_page(void) {
  paddr_t freePage = next_free_user_page;
  next_free_user_page += PAGE_SIZE;
  return freePage;
}

/**
 * mmu_init_kernel_dir inicializa las estructuras de paginación vinculadas al kernel y
 * realiza el identity mapping
 * @return devuelve la dirección de memoria de la página donde se encuentra el directorio
 * de páginas usado por el kernel
 */
paddr_t mmu_init_kernel_dir(void) {
  /* Limpiamos los 4kbytes de directory */
  zero_page(kpd);                             

  /* Limpiamos los 4kbytes de la primera table*/
  zero_page(kpt);                             

  /* Le ponemos al primer directory sus atributos predefinidos */
  kpd[0].attrs = MMU_W + MMU_P;               

  /* Le ponemos al primer directory la direccion donde comienza  la table*/
  kpd[0].pt = (KERNEL_PAGE_TABLE_0 >> 12); 

  /* A cada pagina de la tabla 0 le ponemos los atributos predefinidos y un numero de pagina */
  for (int i = 0; i < 1024; i++) {            
    kpt[i].attrs = MMU_W + MMU_P;            
    kpt[i].page  = i;                         
  }

  /* Limpiamos el buffer */
  tlbflush();                                 

  return kpd;
}

/**
 * mmu_map_page agrega las entradas necesarias a las estructuras de paginación de modo de que
 * la dirección virtual virt se traduzca en la dirección física phy con los atributos definidos en attrs
 * @param cr3 el contenido que se ha de cargar en un registro CR3 al realizar la traducción
 * @param virt la dirección virtual que se ha de traducir en phy
 * @param phy la dirección física que debe ser accedida (dirección de destino)
 * @param attrs los atributos a asignar en la entrada de la tabla de páginas
 */
void mmu_map_page(uint32_t cr3, vaddr_t virt, paddr_t phy, uint32_t attrs) {

  /* Guardamos los indices de la direccion virtual en variables */
  uint32_t DirectoryIndex = VIRT_PAGE_DIR(virt);
  uint32_t TableIndex     = VIRT_PAGE_TABLE(virt);

  /* Obtenemos la direccion del page directory */
  pd_entry_t* PageDirectory = CR3_TO_PAGE_DIR(cr3);

  /* Si el directorio que buscamos no esta presente en la memoria, lo creamos */
  if ((PageDirectory[DirectoryIndex].attrs & MMU_P) == 0) {
    paddr_t newPage = mmu_next_free_kernel_page();
    zero_page(newPage);
    PageDirectory[DirectoryIndex] = (pd_entry_t){MMU_P | MMU_U | MMU_W, newPage >> 12};
  }

  /* Obtenemos la direccion del page table */
  pt_entry_t* PageTable = MMU_ENTRY_PADDR(PageDirectory[DirectoryIndex].pt);
  
  /* Accedemos a la tabla y en el descriptor de pagina le guardamos la direccion fisica */
  PageTable[TableIndex] = (pt_entry_t){MMU_P, phy >> 12};
  
  /* Limpiamos el buffer */
  tlbflush();
}

/**
 * mmu_unmap_page elimina la entrada vinculada a la dirección virt en la tabla de páginas correspondiente
 * @param virt la dirección virtual que se ha de desvincular
 * @return la dirección física de la página desvinculada
 */
paddr_t mmu_unmap_page(uint32_t cr3, vaddr_t virt) {

  /* Guardamos los indices de la direccion virtual en variables */
  uint32_t DirectoryIndex = VIRT_PAGE_DIR(virt);
  uint32_t PageIndex      = VIRT_PAGE_TABLE(virt);

  /* Obtenemos la direccion del page directory */
  pd_entry_t* PageDirectory = CR3_TO_PAGE_DIR(cr3);

  /* Obtenemos la direccion del page table */
  pt_entry_t* PageTable = MMU_ENTRY_PADDR(PageDirectory[DirectoryIndex].pt);
  
  /* Obtenemos la pagina */
  pt_entry_t page = PageTable[PageIndex];
  page.attrs = 0;

  /* Limpiamos el buffer */
  tlbflush();

  return MMU_ENTRY_PADDR(page.page);
}

#define DST_VIRT_PAGE 0xA00000
#define SRC_VIRT_PAGE 0xB00000

/**
 * copy_page copia el contenido de la página física localizada en la dirección src_addr a la página física ubicada en dst_addr
 * @param dst_addr la dirección a cuya página queremos copiar el contenido
 * @param src_addr la dirección de la página cuyo contenido queremos copiar
 *
 * Esta función mapea ambas páginas a las direcciones SRC_VIRT_PAGE y DST_VIRT_PAGE, respectivamente, realiza
 * la copia y luego desmapea las páginas. Usar la función rcr3 definida en i386.h para obtener el cr3 actual
 */
void copy_page(paddr_t dst_addr, paddr_t src_addr) {
  /* Obtengo cr3 */
  uint32_t cr3 = rcr3();
  
  /* En SRC_VIRT pongo la direccion fisica src */
  mmu_map_page(cr3, SRC_VIRT_PAGE, src_addr, MMU_W | MMU_P);
  
  /* En DST_VIRT pongo la direccion fisica dst */
  mmu_map_page(cr3, DST_VIRT_PAGE, dst_addr, MMU_W | MMU_P);

  /* Creamos las variables con las direcciones virtuales */
  uint32_t* src = SRC_VIRT_PAGE;
  uint32_t* dst = DST_VIRT_PAGE;

  for (int i = 0; i < 1024; i++) {
    dst[i] = src[i];
  }

  mmu_unmap_page(cr3, SRC_VIRT_PAGE);
  mmu_unmap_page(cr3, DST_VIRT_PAGE);
}

 /**
 * mmu_init_task_dir inicializa las estructuras de paginación vinculadas a una tarea cuyo código se encuentra en la dirección phy_start
 * @param phy_start es la dirección donde comienzan las dos páginas de código de la tarea asociada a esta llamada
 * @return el contenido que se ha de cargar en un registro CR3 para la tarea asociada a esta llamada
 */
paddr_t mmu_init_task_dir(paddr_t phy_start) {  
  
  /* Obtenemos la siguiente pagina libre del area libre kernel. Direccion Fisica */
  paddr_t kernel = mmu_next_free_kernel_page();
  
  /* Limpiamos la pagina por las dudas */
  zero_page(kernel);

  /* Identity mapping de todo el kernel desde el 0 al limite 0x3FFFFF */
  for (int i = 0; i < identity_mapping_end; i+=PAGE_SIZE) {
    mmu_map_page(kernel, i, i, MMU_W | MMU_P);
  }

  /* Mapeamos el codigo a ejecutarse en la direccion virtual correspondiente */
  for (int i = 0; i < TASK_CODE_PAGES; i++) {
    mmu_map_page(kernel, TASK_CODE_VIRTUAL+i*PAGE_SIZE, phy_start+i*PAGE_SIZE, MMU_W | MMU_P);
  }

  /* Pedimos pagina libre para el stack */
  paddr_t stack = mmu_next_free_user_page();
  
  /* Mapeamos la direccion fisica del stack a la virtual */
  mmu_map_page(kernel, TASK_STACK_BASE-PAGE_SIZE, stack, MMU_U | MMU_W | MMU_P);

  /* Memoria Compartida */
  mmu_map_page(kernel, TASK_SHARED_PAGE, SHARED, MMU_U | MMU_P);

  return kernel;
}

// COMPLETAR: devuelve true si se atendió el page fault y puede continuar la ejecución 
// y false si no se pudo atender
bool page_fault_handler(vaddr_t virt) {
  print("Atendiendo page fault...", 0, 0, C_FG_WHITE | C_BG_BLACK);
  // Chequeemos si el acceso fue dentro del area on-demand
  // En caso de que si, mapear la pagina
  paddr_t cr3 = rcr3();

  if (virt >= ON_DEMAND_MEM_START_VIRTUAL && virt <= ON_DEMAND_MEM_END_VIRTUAL) {
    mmu_map_page(cr3, virt, ON_DEMAND_MEM_START_PHYSICAL, MMU_P | MMU_W | MMU_U);
    return true;
  } else {
    return false;
  }

}