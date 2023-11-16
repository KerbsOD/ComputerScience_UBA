/* ** por compatibilidad se omiten tildes **
================================================================================
 TALLER System Programming - ORGANIZACION DE COMPUTADOR II - FCEN
================================================================================
  definicion de las rutinas de atencion de interrupciones
*/

#include "idt.h"
#include "defines.h"
#include "i386.h"
#include "isr.h"
#include "screen.h"

idt_entry_t idt[255] = {0};

idt_descriptor_t IDT_DESC = {sizeof(idt) - 1, (uint32_t)&idt};

/* Dada una expresion que resulta en un numero de 32 bits construye una que
 * solo incluye sus 16bits menos significativos */
#define LOW_16_BITS(v) ((uint32_t)(v) & 0xFFFF)
/* Dada una expresion que resulta en un numero de 32 bits construye una que
 * solo incluye sus 16bits mas significativos */
#define HIGH_16_BITS(v) ((uint32_t)(v) >> 16 & 0xFFFF)

/*
    La siguiente es una macro de EJEMPLO para ayudar a armar entradas de
    interrupciones. Para usar, completar CORRECTAMENTE los atributos
    (en defines.h) y el registro de segmento (ver defines.h). Invocarla
    desde idt_init() de la siguiene manera:

    void idt_init() {
        IDT_ENTRY0(0);
        ...
        IDT_ENTRY0(19);
        ...
    }
*/

/* COMPLETAR: Dado un numero de de interrupcion asigna a `idt` la entrada
 * correspondiente con nivel 0 */
#define IDT_ENTRY0(numero)                                                     \
  idt[numero] = (idt_entry_t) {                                                \
    .offset_31_16 = HIGH_16_BITS(&_isr##numero),                               \
    .offset_15_0 = LOW_16_BITS(&_isr##numero),                                 \
    .segsel = GDT_CODE_0_SEL,                                                  \
    .type = 14,                                                              \
    .dpl = 0x0,                                                                 \
    .present = 1                                                              \
  }

/* COMPLETAR: Dado un numero de de interrupcion asigna a `idt` la entrada
 * correspondiente con nivel 3 */
#define IDT_ENTRY3(numero)                                                     \
  idt[numero] = (idt_entry_t) {                                                \
    .offset_31_16 = HIGH_16_BITS(&_isr##numero),                               \
    .offset_15_0 = LOW_16_BITS(&_isr##numero),                                 \
    .segsel = GDT_CODE_0_SEL,                                                  \
    .type = 14,                                                               \
    .dpl = 0x3,                                                                  \
    .present = 1                                                               \
  }

void idt_init() {
  // Excepciones
  IDT_ENTRY0(0);
  IDT_ENTRY0(1);
  IDT_ENTRY0(2);
  IDT_ENTRY0(3);
  IDT_ENTRY0(4);
  IDT_ENTRY0(5);
  IDT_ENTRY0(6);
  IDT_ENTRY0(7);
  IDT_ENTRY0(8);
  IDT_ENTRY0(9);
  IDT_ENTRY0(10);
  IDT_ENTRY0(11);
  IDT_ENTRY0(12);
  IDT_ENTRY0(13);
  IDT_ENTRY0(14);
  IDT_ENTRY0(15);
  IDT_ENTRY0(16);
  IDT_ENTRY0(17);
  IDT_ENTRY0(18);
  IDT_ENTRY0(19);
  IDT_ENTRY0(20);

  // COMPLETAR: Interrupciones de reloj y teclado
  IDT_ENTRY0(32);
  IDT_ENTRY0(33);

  // COMPLETAR: Syscalls
  IDT_ENTRY3(88);
  IDT_ENTRY3(98);

}

const char* code2exception[] = {"Divide Error #DE [0]",
                                "Debug #DB [1]",
                                "NMI Interrupt [2]",
                                "Breakpoint #BP [3]",
                                "Overflow #OF [4]",
                                "BOUND Range Exceeded #BR [5]",
                                "Invalid Opcode #UD [6]",
                                "Device Not Available #NM [7]",
                                "Double Fault (#DF) [8]",
                                "Coprocessor Segment Overrun [9]",
                                "Invalid TSS (#TS) [10]",
                                "Segment Not Present (#NP) [11]",
                                "Stack Fault (#SS) [12]",
                                "General Protection (#GP) [13]",
                                "Page-Fault (#PF) [14]",
                                "RESERVED [15]",
                                "Floating-Point Error (#MF) [16]",
                                "Alignment Check (#AC) [17]",
                                "Machine-Check (#MC) [18]",
                                "SIMD Floating-Point (#XM) [19]",
                                "Virtualization (#VE) [20]",
                                "Control Protection (#CP) [21]"};

typedef struct error_frame_t {
  uint32_t exception_number;
  uint32_t error_code;
  uint32_t eip;
  uint32_t cs;
  uint32_t eflags;
  uint32_t esp;
  uint32_t ss;
} error_frame;

typedef struct kernel_error_frame_t {
  uint32_t exception_number;
  uint32_t error_code;
  uint32_t eip;
  uint32_t cs;
  uint32_t eflags;
} kernel_error_frame;

typedef struct general_regs_t {
  uint32_t edi;
  uint32_t esi;
  uint32_t ebp;
  uint32_t esp;
  uint32_t ebx;
  uint32_t edx;
  uint32_t ecx;
  uint32_t eax;
} general_regs;

typedef struct segment_regs_t {
  uint32_t cs;
  uint32_t ds;
  uint32_t es;
  uint32_t fs;
  uint32_t gs;
  uint32_t ss;
} segment_regs;

typedef struct control_regs_t {
  uint32_t cr0;
  uint32_t cr2;
  uint32_t cr3;
  uint32_t cr4;
} control_regs;

#define GREGS_NAMES_START_COL 21
#define EFLAGS_NAME_START_COL 21
#define CREGS_NAMES_START_COL 46
#define GREGS_START_COL       25
#define EFLAGS_START_COL      28
#define CREGS_START_COL       50
#define STACK_START_COL       40

static void print_exception_template(void) {
  screen_draw_box(1, 19, 40, 40, 0x0, 0x0);
  print("eax", GREGS_NAMES_START_COL, 6, 0x0F);
  print("ebx", GREGS_NAMES_START_COL, 8, 0x0F);
  print("ecx", GREGS_NAMES_START_COL, 10, 0x0F);
  print("edx", GREGS_NAMES_START_COL, 12, 0x0F);
  print("esi", GREGS_NAMES_START_COL, 14, 0x0F);
  print("edi", GREGS_NAMES_START_COL, 16, 0x0F);
  print("ebp", GREGS_NAMES_START_COL, 18, 0x0F);
  print("esp", GREGS_NAMES_START_COL, 20, 0x0F);
  print("eip", GREGS_NAMES_START_COL, 22, 0x0F);
  print(" cs", GREGS_NAMES_START_COL, 24, 0x0F);
  print(" ds", GREGS_NAMES_START_COL, 26, 0x0F);
  print(" es", GREGS_NAMES_START_COL, 28, 0x0F);
  print(" fs", GREGS_NAMES_START_COL, 30, 0x0F);
  print(" gs", GREGS_NAMES_START_COL, 32, 0x0F);
  print(" ss", GREGS_NAMES_START_COL, 34, 0x0F);
  print("eflags", EFLAGS_NAME_START_COL, 37, 0x0F);

  print("cr0", CREGS_NAMES_START_COL, 7, 0x0F);
  print("cr2", CREGS_NAMES_START_COL, 9, 0x0F);
  print("cr3", CREGS_NAMES_START_COL, 11, 0x0F);
  print("cr4", CREGS_NAMES_START_COL, 13, 0x0F);
  print("err", CREGS_NAMES_START_COL, 15, 0x0F);

  print("stack", STACK_START_COL, 19, 0x0F);

  print_hex(0, 8, GREGS_START_COL, 6, 0x0A);
  print_hex(0, 8, GREGS_START_COL, 8, 0x0A);
  print_hex(0, 8, GREGS_START_COL, 10, 0x0A);
  print_hex(0, 8, GREGS_START_COL, 12, 0x0A);
  print_hex(0, 8, GREGS_START_COL, 14, 0x0A);
  print_hex(0, 8, GREGS_START_COL, 16, 0x0A);
  print_hex(0, 8, GREGS_START_COL, 18, 0x0A);
  print_hex(0, 8, GREGS_START_COL, 20, 0x0A);
  print_hex(0, 8, GREGS_START_COL, 22, 0x0A);
  print_hex(0, 8, GREGS_START_COL, 24, 0x0A);
  print_hex(0, 8, GREGS_START_COL, 26, 0x0A);
  print_hex(0, 8, GREGS_START_COL, 28, 0x0A);
  print_hex(0, 8, GREGS_START_COL, 30, 0x0A);
  print_hex(0, 8, GREGS_START_COL, 32, 0x0A);
  print_hex(0, 8, GREGS_START_COL, 34, 0x0A);
  print_hex(0, 8, EFLAGS_START_COL, 37, 0x0A);

  print_hex(0, 8, CREGS_START_COL, 7, 0x0A);
  print_hex(0, 8, CREGS_START_COL, 9, 0x0A);
  print_hex(0, 8, CREGS_START_COL, 11, 0x0A);
  print_hex(0, 8, CREGS_START_COL, 13, 0x0A);
  print_hex(0, 8, CREGS_START_COL, 15, 0x0A);
}

static void print_regs(general_regs* gregs, segment_regs* sregs,
                       control_regs* cregs, uint32_t eip, uint32_t eflags,
                       uint32_t error_code) {
  print_hex(gregs->eax, 8, GREGS_START_COL, 6, 0x0A);
  print_hex(gregs->ebx, 8, GREGS_START_COL, 8, 0x0A);
  print_hex(gregs->ecx, 8, GREGS_START_COL, 10, 0x0A);
  print_hex(gregs->edx, 8, GREGS_START_COL, 12, 0x0A);
  print_hex(gregs->esi, 8, GREGS_START_COL, 14, 0x0A);
  print_hex(gregs->edi, 8, GREGS_START_COL, 16, 0x0A);
  print_hex(gregs->ebp, 8, GREGS_START_COL, 18, 0x0A);
  print_hex(gregs->esp, 8, GREGS_START_COL, 20, 0x0A);
  print_hex(eip, 8, GREGS_START_COL, 22, 0x0A);
  print_hex(sregs->cs, 8, GREGS_START_COL, 24, 0x0A);
  print_hex(sregs->ds, 8, GREGS_START_COL, 26, 0x0A);
  print_hex(sregs->es, 8, GREGS_START_COL, 28, 0x0A);
  print_hex(sregs->fs, 8, GREGS_START_COL, 30, 0x0A);
  print_hex(sregs->gs, 8, GREGS_START_COL, 32, 0x0A);
  print_hex(sregs->ss, 8, GREGS_START_COL, 34, 0x0A);
  print_hex(eflags, 8, EFLAGS_START_COL, 37, 0x0A);
  print_hex(cregs->cr0, 8, CREGS_START_COL, 7, 0x0A);
  print_hex(cregs->cr2, 8, CREGS_START_COL, 9, 0x0A);
  print_hex(cregs->cr3, 8, CREGS_START_COL, 11, 0x0A);
  print_hex(cregs->cr4, 8, CREGS_START_COL, 13, 0x0A);
  print_hex(error_code, 8, CREGS_START_COL, 15, 0x0A);
}

void kernel_exception(control_regs cregs,
                       segment_regs sregs, general_regs gregs,
                       kernel_error_frame frame) {
  //breakpoint();

  print_exception_template();
  print(code2exception[frame.exception_number], 20, 2, 0x0A);

  sregs.cs = frame.cs;
  print_regs(&gregs, &sregs, &cregs, frame.eip, frame.eflags, frame.error_code);

  print_hex( *((uint32_t*)gregs.esp), 8, STACK_START_COL, 21, C_BG_BLACK | C_FG_LIGHT_GREEN);
  print_hex(*((uint32_t*)gregs.esp + 1), 8, STACK_START_COL, 23, C_BG_BLACK | C_FG_LIGHT_GREEN);
  print_hex(*((uint32_t*)gregs.esp + 2), 8, STACK_START_COL, 25, C_BG_BLACK | C_FG_LIGHT_GREEN);
}

