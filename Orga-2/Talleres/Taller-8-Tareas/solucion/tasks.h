/* ** por compatibilidad se omiten tildes **
================================================================================
 TALLER System Programming - ORGANIZACION DE COMPUTADOR II - FCEN
================================================================================

  Declaracion de las rutinas asociadas a las tareas
*/

#ifndef __TASK_H__
#define __TASK_H__
#include "types.h"
#include "defines.h"
#include "task_defines.h"
#include "screen.h"

void tasks_init(void);

void tasks_syscall_draw(ca viewport[TASK_VIEWPORT_HEIGHT][TASK_VIEWPORT_WIDTH]);
void tasks_screen_update(void);
void tasks_screen_draw(void);
void tasks_input_process(uint8_t scancode);
void tasks_tick(void);

#endif //  __TASK_H__
