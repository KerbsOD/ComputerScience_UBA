/* ** por compatibilidad se omiten tildes **
================================================================================
 TALLER System Programming - ORGANIZACION DE COMPUTADOR II - FCEN
================================================================================
  Definicion de llamadas a sistema, para usar desde las tareas.
*/

#ifndef __SYSCALL_H__
#define __SYSCALL_H__

#include "../screen.h"
#include "../task_defines.h"
typedef ca screen[TASK_VIEWPORT_HEIGHT][TASK_VIEWPORT_WIDTH];

#define LS_INLINE static __inline __attribute__((always_inline))

/**
 * Llamada al sistema que dibuja la pantalla pasada por parámetro.
 */
LS_INLINE void syscall_draw(screen text) {
  __asm__ volatile("int $88" /* int. de soft. 88 */
                   :
                   : "a"(text)
                   : "memory",
                     "cc"); /* announce to the compiler that the memory and
                               condition codes have been modified */
}

#endif //  __SYSCALL_H__
