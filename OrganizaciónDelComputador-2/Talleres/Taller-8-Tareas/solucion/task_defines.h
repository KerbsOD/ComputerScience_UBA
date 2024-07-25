#ifndef __TASK_DEFINES_H__
#define __TASK_DEFINES_H__

/* GDT */
#define GDT_IDX_TASK_INITIAL         11
#define GDT_IDX_TASK_IDLE            12

#define GDT_TASK_A_SEL (GDT_IDX_TASK_A_START << 3)
#define GDT_TASK_B_SEL (GDT_IDX_TASK_B_START << 3)

/* Direcciones fisicas de codigos */
/* -------------------------------------------------------------------------- */
/* En estas direcciones estan los códigos de todas las tareas. De aqui se
 * copiaran al destino indicado por TASK_<X>_CODE_START.
 */
#define USER_TASK_SIZE (PAGE_SIZE * 2)

#define TASK_A_CODE_START (0x00018000)
#define TASK_B_CODE_START (0x0001A000)
#define TASK_IDLE_CODE_START   (0x0001C000)

/* EFLAGS */

#define EFLAGS_IF (1 << 9)

/* Constantes Generales */

#define MAX_TASKS     (2 * 2)
#define GDT_TSS_START 13

/* Interfaz gráfica del sistema */
/* -------------------------------------------------------------------------- */
#define TASK_VIEWPORT_WIDTH 38
#define TASK_VIEWPORT_HEIGHT 23

#endif //  __TASK_DEFINES_H__