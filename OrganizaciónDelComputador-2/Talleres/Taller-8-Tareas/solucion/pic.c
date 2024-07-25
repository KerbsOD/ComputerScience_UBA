/* ** por compatibilidad se omiten tildes **
================================================================================
 TALLER System Programming - ORGANIZACION DE COMPUTADOR II - FCEN
================================================================================

  Rutinas del controlador de interrupciones.
*/
#include "pic.h"

#define PIC1_PORT 0x20
#define PIC2_PORT 0xA0

static __inline __attribute__((always_inline)) void outb(uint32_t port,
                                                         uint8_t data) {
  __asm __volatile("outb %0,%w1" : : "a"(data), "d"(port));
}
void pic_finish1(void) { outb(PIC1_PORT, 0x20); }
void pic_finish2(void) {
  outb(PIC1_PORT, 0x20);
  outb(PIC2_PORT, 0x20);
}

// COMPLETAR: implementar pic_reset()
void pic_reset() {
  /* Reseteo del PIC1 (Puertos 20h y 21h)*/
  outb(PIC1_PORT,   0x11);  // ICW1 - (0-00010001) -> Comando de inicializacion. 
  outb(PIC1_PORT+1, 0x20);  // ICW2 - (1-00100000) -> PIC1 empieza en 0x20. 
  outb(PIC1_PORT+1, 0x04);  // ICW3 - (1-00000100) -> Slave.
  outb(PIC1_PORT+1, 0x01);  // ICW4 - (1-00000001) -> Modo 8086 
  outb(PIC1_PORT+1, 0xFF);  // OCW1 - (1-11111111) -> Mascara PIC Deshabilitado.

  /* Reseteo del PIC2 (Puertos A0h y A1h)*/
  outb(PIC2_PORT,   0x11);  // ICW1 - (0-00010001) -> Comando de inicializacio
  outb(PIC2_PORT+1, 0x28);  // ICW2 - (1-00101000) -> PIC2 empieza en 0x28. 
  outb(PIC2_PORT+1, 0x02);  // ICW3 - (1-00000010) -> Slave.
  outb(PIC2_PORT+1, 0x01);  // ICW4 - (1-00000001) -> Modo 8086 
  outb(PIC2_PORT+1, 0xFF);  // OCW1 - (1-11111111) -> Mascara PIC Deshabilitado.
}

void pic_enable() {
  outb(PIC1_PORT + 1, 0x00);
  outb(PIC2_PORT + 1, 0x00);
}

void pic_disable() {
  outb(PIC1_PORT + 1, 0xFF);
  outb(PIC2_PORT + 1, 0xFF);
}
