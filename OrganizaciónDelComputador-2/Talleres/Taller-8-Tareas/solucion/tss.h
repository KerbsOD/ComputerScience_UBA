/* ** por compatibilidad se omiten tildes **
================================================================================
 TALLER System Programming - ORGANIZACION DE COMPUTADOR II - FCEN
================================================================================

  Declaracion de estructuras para administrar tareas
*/

#ifndef __TSS_H__
#define __TSS_H__

#include "gdt.h"
#include "types.h"
#include "task_defines.h"

typedef struct str_tss {
  uint16_t ptl;
  uint16_t unused0;
  uint32_t esp0;
  uint16_t ss0;
  uint16_t unused1;
  uint32_t esp1;
  uint16_t ss1;
  uint16_t unused2;
  uint32_t esp2;
  uint16_t ss2;
  uint16_t unused3;
  uint32_t cr3;
  uint32_t eip;
  uint32_t eflags;
  uint32_t eax;
  uint32_t ecx;
  uint32_t edx;
  uint32_t ebx;
  uint32_t esp;
  uint32_t ebp;
  uint32_t esi;
  uint32_t edi;
  uint16_t es;
  uint16_t unused4;
  uint16_t cs;
  uint16_t unused5;
  uint16_t ss;
  uint16_t unused6;
  uint16_t ds;
  uint16_t unused7;
  uint16_t fs;
  uint16_t unused8;
  uint16_t gs;
  uint16_t unused9;
  uint16_t ldt;
  uint16_t unused10;
  uint16_t dtrap;
  uint16_t iomap;
} __attribute__((__packed__, aligned(8))) tss_t;

extern tss_t tss_initial;
extern tss_t tss_idle;

void tss_init(void);

extern tss_t tss_tasks[MAX_TASKS];
tss_t tss_create_user_task(uint32_t cr3);
gdt_entry_t tss_gdt_entry_for_task(tss_t* tss);

#endif //  __TSS_H__
