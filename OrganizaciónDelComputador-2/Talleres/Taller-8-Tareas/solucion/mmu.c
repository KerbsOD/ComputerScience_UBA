/* ** por compatibilidad se omiten tildes **
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
  paddr_t PaginaLibre = next_free_kernel_page;
  next_free_kernel_page += PAGE_SIZE;
  return PaginaLibre;
}

/**
 * mmu_next_free_user_page devuelve la dirección de la próxima página de usuarix disponible
 * @return devuelve la dirección de memoria de comienzo de la próxima página libre de usuarix
 */
paddr_t mmu_next_free_user_page(void) {
  paddr_t PaginaLibre = next_free_user_page;
  next_free_user_page += PAGE_SIZE;
  return PaginaLibre;
}

/**
 * mmu_init_kernel_dir inicializa las estructuras de paginación vinculadas al kernel y
 * realiza el identity mapping
 * @return devuelve la dirección de memoria de la página donde se encuentra el directorio
 * de páginas usado por el kernel
 */
paddr_t mmu_init_kernel_dir(void) {
  pd_entry_t* KernelDir   = (pd_entry_t*)0x25000;   // Kernel Page Directory. 
  pt_entry_t* KernelTable = (pt_entry_t*)0x26000;   // Kernel Page Table.     

  zero_page(KernelDir);                             // Limpiamos la page directory.
  zero_page(KernelTable);                           // Limpiamos la page table.

  KernelDir[0].attrs = MMU_P | MMU_W;               // Agregamos los privilegios de kernel. P=1. W=1. Privilege = 0.
  KernelDir[0].pt    = (KERNEL_PAGE_TABLE_0 >> 12); // Direccion de la page table.

  for (int i = 0; i < 1024; i++) {                  // Son 1024 paginas en la tabla
    KernelTable[i].attrs = MMU_P | MMU_W;           // Agregamos los privilegios de kernel. P=1. W=1. Privilege = 0.
    KernelTable[i].page  = i;                       // El kernel esta en las primeras 1024 direcciones xd.
  }

  tlbflush();                                       // Limpiamos el buffer 

  return KernelDir;                                                  
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
  pd_entry_t* Directory     = CR3_TO_PAGE_DIR(cr3);                         // Obtenemos la direccion del directorio dado un CR3
  uint32_t IndexInDirectory = VIRT_PAGE_DIR(virt);                          // Obtenemos el indice de la memoria virtual en el directorio.

  if ((Directory[IndexInDirectory].attrs & MMU_P) == 0) {                   // Si no esta presente la tabla, la creamos.
    uint32_t FreePage = mmu_next_free_kernel_page();                        // Buscamos una pagina libre.
    zero_page(FreePage);                                                    // La limpiamos.
    Directory[IndexInDirectory].attrs = attrs | MMU_P | MMU_U | MMU_W;      // Agregamos los privilegios de kernel. P=1. W=1. Privilege = 0.
    Directory[IndexInDirectory].pt    = FreePage >> 12;                     // Le damos la direccion fisica a la tabla.
  }

  pt_entry_t* Table     = MMU_ENTRY_PADDR(Directory[IndexInDirectory].pt);  // .pt me da la direccion fisica de la tabla, tengo que shiftearlo para la izquierda para obtener la direccion de 32 bits. Recordar que los ultimos 12 bits son 0.
  uint32_t IndexInTable = VIRT_PAGE_TABLE(virt);                            // Obtenemos el index en la tabla.

  Table[IndexInTable].attrs = attrs | MMU_P;                                // Accedemos a la pagina en la tabla y le ponemos los atributos
  Table[IndexInTable].page  = phy>>12;                                      // Le ponemos la direccion, sin offset.

  tlbflush();                                                               // Limpiamos el buffer
}

/**
 * mmu_unmap_page elimina la entrada vinculada a la dirección virt en la tabla de páginas correspondiente
 * @param virt la dirección virtual que se ha de desvincular
 * @return la dirección física de la página desvinculada
 */
paddr_t mmu_unmap_page(uint32_t cr3, vaddr_t virt) {
  pd_entry_t* Directory    = CR3_TO_PAGE_DIR(cr3);                        // Obtenemos la direccion fisica del directorio.
  paddr_t IndexInDirectory = VIRT_PAGE_DIR(virt);                         // Obtenemos el indice en el directorio.

  pt_entry_t* Table    = MMU_ENTRY_PADDR(Directory[IndexInDirectory].pt); // Obtenemos la direccion fisica de la tabla.
  paddr_t IndexInTable = VIRT_PAGE_TABLE(virt);                           // Obtenemos el inidce en la tabla.

  Table[IndexInTable].attrs = 0;                                          // Seteamos el present (todos) en 0.
  paddr_t phy = MMU_ENTRY_PADDR(Table[IndexInTable].page);                // Obtenemos la direccion fisica pasada a 32 bits.

  tlbflush();                                                             // Limpiamos el buffer.

  return phy;
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
  uint32_t CR3 = rcr3();                                      // Obtenemos el CR3 actual.

  mmu_map_page(CR3, SRC_VIRT_PAGE, src_addr, MMU_P | MMU_W);  // Mapeamos la direccion fisica a la virtual.
  mmu_map_page(CR3, DST_VIRT_PAGE, dst_addr, MMU_P | MMU_W);  // Mapeamos la direccion fisica a la virtual.

  vaddr_t* SRC = SRC_VIRT_PAGE;                               // Creamos un puntero al inicio del page frame.
  vaddr_t* DST = DST_VIRT_PAGE;                               // Creamos un puntero al inicio del page frame.

  for (int i = 0; i < 1024; i++) {
    DST[i] = SRC[i];                                          // Copiamos SRC a DST desde el offset 0 a 1024 del page frame.
  }

  mmu_unmap_page(CR3, SRC_VIRT_PAGE);                         // Desmapeamos la direccion fisica a la virtual.
  mmu_unmap_page(CR3, DST_VIRT_PAGE);                         // Desmapeamos la direccion fisica a la virtual.
}

 /**
 * mmu_init_task_dir inicializa las estructuras de paginación vinculadas a una tarea cuyo código se encuentra en la dirección phy_start
 * @pararm phy_start es la dirección donde comienzan las dos páginas de código de la tarea asociada a esta llamada
 * @return el contenido que se ha de cargar en un registro CR3 para la tarea asociada a esta llamada
 */
paddr_t mmu_init_task_dir(paddr_t phy_start) {
  
  /* Segun la figura 1 donde comienza cada direccion fisica */
  paddr_t Code1_PHY = phy_start;                              // La primer pagina tiene desde "phy-start" hasta "phy_start" + 4096bytes - 1
  paddr_t Code2_PHY = phy_start+PAGE_SIZE;                    // La segunda pagina tiene desde "phy_start" + 4096bytes hasta "phy_start" + 8192bytes 
  paddr_t Stack_PHY = mmu_next_free_user_page();              // La tarea no tiene una posicion del stack predefinida.
  paddr_t Share_PHY = SHARED;                                 // Lugar fisico donde comienza "memoria compartida".

  /* Segun la figura 2 donde comienza cada direccion virtual */
  vaddr_t Code1_VIR = TASK_CODE_VIRTUAL;                      // La primer pagina de codigo esta en 0x08000000
  vaddr_t Code2_VIR = TASK_CODE_VIRTUAL+PAGE_SIZE;            // La segunda pagina de codigo esta en 0x08000000 + 4096
  vaddr_t Stack_VIR = TASK_STACK_BASE-PAGE_SIZE;              // La base del stack esta en 0x08003000. Debemos empezar arriba de la base.
  vaddr_t Share_VIR = TASK_SHARED_PAGE;                       // Lugar virtual donde comienza "memoria compartida".           

  /* Inicializamos el CR3 de la tarea */
  pd_entry_t* Task_CR3  = (pd_entry_t*)mmu_next_free_kernel_page(); // Pedimos pagina del kernel para el CR3 (Directorios)
  pd_entry_t* KernelDir = (pd_entry_t*)KERNEL_PAGE_DIR;             // Obtenemos la direccion del directory.

  Task_CR3[0] = KernelDir[0];                                 // Copio los atributos del directorio del kernel.

  /* Linkeamos todo */
  mmu_map_page(Task_CR3, Code1_VIR, Code1_PHY, MMU_P | MMU_U);
  mmu_map_page(Task_CR3, Code2_VIR, Code2_PHY, MMU_P | MMU_U);
  mmu_map_page(Task_CR3, Stack_VIR, Stack_PHY, MMU_P | MMU_U | MMU_W);
  mmu_map_page(Task_CR3, Share_VIR, Share_PHY, MMU_P | MMU_U);

  return Task_CR3;
}

// COMPLETAR: devuelve true si se atendió el page fault y puede continuar la ejecución 
// y false si no se pudo atender
bool page_fault_handler(vaddr_t virt) {
  print("Atendiendo page fault...", 0, 0, C_FG_WHITE | C_BG_BLACK);
  // Chequeemos si el acceso fue dentro del area on-demand
  // En caso de que si, mapear la pagina

  if (ON_DEMAND_MEM_START_VIRTUAL <= virt && virt <= ON_DEMAND_MEM_END_VIRTUAL) {
    uint32_t Task_CR3 = rcr3();
    mmu_map_page(Task_CR3, virt, ON_DEMAND_MEM_START_PHYSICAL, MMU_U | MMU_P | MMU_W);
    return true;
  }

  return false;  
}


void copiar(uint8_t otra_ID, uint32_t virt) {
  tss_t* actual_tss = &tss_tasks[current_task];
  tss_t* otra_tss   = &tss_tasks[otra_ID];

  pd_entry_t* actual_dir = CR3_TO_PAGE_DIR(actual_tss->cr3);
  pd_entry_t* otra_dir   = CR3_TO_PAGE_DIR(otra_tss->cr3);

  uint32_t actual_dir_index = VIRT_PAGE_DIR(virt);
  uint32_t otra_dir_index   = VIRT_PAGE_DIR(virt);

  if (((actual_dir[actual_dir_index].attrs & MMU_P) == 1) && 
      ((otra_dir[otra_dir_index].attrs & MMU_P)     == 1)) 
  {
    pt_entry_t* actual_table = actual_dir[actual_dir_index].pt << 12;
    pt_entry_t* otra_table = otra_dir[otra_dir_index].pt << 12;
    
    uint32_t actual_table_index = VIRT_PAGE_TABLE(virt);
    uint32_t otra_table_index   = VIRT_PAGE_TABLE(virt);

    if ( ( (actual_table[actual_table_index].attrs & MMU_P) == 1 ) && 
         ( (otra_table[otra_table_index].attrs & MMU_P)     == 1 )) 
    {
      paddr_t actual_page = actual_table[actual_table_index].page << 12;
      paddr_t otra_page   = otra_table[otra_table_index].page << 12;

      copy_page(actual_page, otra_page);
      // Pero ambas direcciones en virt.
      // copy_page(actual_page, otra_page, virt);
    }

  }
}

