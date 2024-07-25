/* ** por compatibilidad se omiten tildes **
================================================================================
 TALLER System Programming - ORGANIZACION DE COMPUTADOR II - FCEN
================================================================================

  Macros para asserts. Solo usables desde nivel 0.
*/

#ifndef __ASSERT_H__
#define __ASSERT_H__

#include "screen.h"

// kassert es una macro util para declarar invariantes en el kernel.
// la macro toma dos parametros, una expresion booleana y un mensaje.
// si la expresion booleana evalua a false, se para el sistema y se
// muestra un mensaje por pantalla.
//
// Por ejemplo:
// kassert(next_free_kernel_page < identity_mapping_end,
//         "Out of kernel memory");
//
// En mmu_next_free_kernel_page, chequearia que el kernel no se quede
// sin memoria en su area libre.
#define kassert(X, MSG)                                                        \
  if (!(X)) {                                                                  \
    screen_draw_box(0, 0, 50, 80, 0x00, C_FG_LIGHT_GREEN | C_BG_BLACK);        \
    print("ASSERTION FAILED", 0, 0, C_FG_LIGHT_GREEN | C_BG_BLACK);            \
    print(MSG, 0, 2, C_FG_LIGHT_GREEN | C_BG_BLACK);                           \
    while (1) {                                                                \
      __asm volatile("nop");                                                   \
    }                                                                          \
  }

#endif //  __ASSERT_H__
