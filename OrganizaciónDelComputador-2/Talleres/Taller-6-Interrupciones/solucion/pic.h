/* ** por compatibilidad se omiten tildes **
================================================================================
 TALLER System Programming - ORGANIZACION DE COMPUTADOR II - FCEN
================================================================================

  Declaracion de rutinas del controlador de interrupciones
*/

#ifndef __PIC_H__
#define __PIC_H__

#include "stdint.h"

extern void pic_reset(void);
extern void pic_enable();
extern void pic_disable();

void pic_finish1(void);
void pic_finish2(void);

#endif //  __PIC_H__
