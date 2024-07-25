/* ** por compatibilidad se omiten tildes **
================================================================================
 TALLER System Programming - ORGANIZACION DE COMPUTADOR II - FCEN
================================================================================

  Declaracion de las rutinas de atencion de interrupciones
*/

#ifndef __IDT_H__
#define __IDT_H__

#include "types.h"

// COMPLETAR: Definir INTERRUPT_GATE_TYPE con el valor correspondiente
#define INTERRUPT_GATE_TYPE ???

/* Struct de descriptor de IDT */
typedef struct str_idt_descriptor {
  uint16_t idt_length;
  uint32_t idt_addr;
} __attribute__((__packed__)) idt_descriptor_t;

/* Struct de una entrada de la IDT */
typedef struct {
    uint16_t offset_15_0;
    uint16_t segsel;
    uint8_t reserved : 5;
    uint8_t should_be_zero : 3;
    uint8_t type : 5;
    uint8_t dpl : 2;
    uint8_t present : 1;
    uint16_t offset_31_16;
} __attribute__((__packed__, aligned (8))) idt_entry_t;


extern idt_entry_t idt[];
extern idt_descriptor_t IDT_DESC;

extern void idt_init(void);

#endif //  __IDT_H__
