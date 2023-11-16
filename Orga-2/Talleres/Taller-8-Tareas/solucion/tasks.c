/* ** por compatibilidad se omiten tildes **
================================================================================
 TALLER System Programming - ORGANIZACION DE COMPUTADOR II - FCEN
================================================================================
*/

#include "tasks.h"

#include "defines.h"
#include "i386.h"
#include "kassert.h"
#include "sched.h"
#include "screen.h"
#include "tss.h"
#include "shared.h"
#include "kassert.h"
#include "types.h"

void tasks_screen_draw();

/**
 * Tipos de tareas soportados por el sistema
 */
typedef enum {
  TASK_A = 0,
  TASK_B = 1,
} tipo_e;

/**
 * Array que nos permite mapear un tipo de tarea a la dirección física de su
 * código.
 */
static paddr_t task_code_start[2] = {
    [TASK_A] = TASK_A_CODE_START,
    [TASK_B] = TASK_B_CODE_START,
};

/**
 * Crea una tarea en base a su tipo e indice número de tarea en la GDT
 */
static int8_t create_task(tipo_e tipo) {
  size_t gdt_id;
  for (gdt_id = GDT_TSS_START; gdt_id < GDT_COUNT; gdt_id++) {
    if (gdt[gdt_id].p == 0) {
      break;
    }
  }
  kassert(gdt_id < GDT_COUNT, "No hay entradas disponibles en la GDT");

  int8_t task_id = sched_add_task(gdt_id << 3);
  tss_tasks[task_id] = tss_create_user_task(task_code_start[tipo]);
  gdt[gdt_id] = tss_gdt_entry_for_task(&tss_tasks[task_id]);
  return task_id;
}

/**
 * Inicializa el sistema de manejo de tareas
 */
void tasks_init(void) {
  int8_t task_id;
  // Dibujamos la interfaz principal
  tasks_screen_draw();

  // Creamos las tareas de tipo A
  task_id = create_task(TASK_A);
  sched_enable_task(task_id);
  task_id = create_task(TASK_A);
  sched_enable_task(task_id);
  task_id = create_task(TASK_A);
  sched_enable_task(task_id);

  // Creamos las tareas de tipo B
  task_id = create_task(TASK_B);
  sched_enable_task(task_id);
}

/**
 * Dibuja la pantalla de la tarea actual en su rectángulo correspondiente.
 */
void tasks_syscall_draw(ca viewport[TASK_VIEWPORT_HEIGHT][TASK_VIEWPORT_WIDTH]) {
  // La tarea nos dió un puntero para mostrar en su ventanita, antes de hacer
  // algo estaría bueno chequear que ese puntero es efectivamente de la tarea
  uintptr_t viewport_addr = (uintptr_t) viewport;
  // Si el viewport empieza antes de la memoria de la tarea ignoramos la syscall
  if (viewport_addr < TASK_CODE_VIRTUAL) return;
  // Si el viewport termina después de la memoria de la tarea ignoramos la syscall
  // NOTA: `sizeof(*viewport)` nos da el tamaño del array :)
  if (TASK_SHARED_PAGE <= viewport_addr + sizeof(*viewport)) return;
  int8_t task_id = current_task;
  kassert(task_id <= 3, "task_id fuera del rango valido!");

  // Calculamos la posición dónde arranca la pantallita de la tarea
  uint32_t x_start, y_start;
  if (task_id == 0) {
    x_start = 1;
    y_start = 1;
  }
  if (task_id == 1) {
    x_start = 41;
    y_start = 1;
  }
  if (task_id == 2) {
    x_start = 1;
    y_start = 26;
  }
  if (task_id == 3) {
    x_start = 41;
    y_start = 26;
  }

  // Copiamos el viewport al lugar destino
  ca(*p)[VIDEO_COLS] = (ca(*)[VIDEO_COLS])VIDEO;
  for (uint32_t y = 0; y < TASK_VIEWPORT_HEIGHT; y++) {
    for (uint32_t x = 0; x < TASK_VIEWPORT_WIDTH; x++) {
      p[y_start + y][x_start + x] = viewport[y][x];
    }
  }
}

/**
 * Actualiza la "interfaz" del sistema.
 */
void tasks_screen_update(void) {
  // Clock
  uint32_t ticks = ENVIRONMENT->tick_count;
  print("Ticks:", 0, 49, C_FG_WHITE | C_BG_RED);
  print_dec(ticks, 10, 8, 49, C_FG_WHITE | C_BG_RED);

  print("Corriendo", 30,  0, C_FG_BLUE | C_BG_BLUE);
  print("Corriendo", 70,  0, C_FG_BLUE | C_BG_BLUE);
  print("Corriendo", 30, 25, C_FG_RED  | C_BG_RED);
  print("Corriendo", 70, 25, C_FG_RED  | C_BG_RED);
  switch (current_task) {
  case 0: /* Tarea 1A */
    print("Corriendo", 30,  0, C_FG_WHITE | C_BG_BLUE);
    break;
  case 1: /* Tarea 1B */
    print("Corriendo", 70,  0, C_FG_WHITE | C_BG_BLUE);
    break;
  case 2: /* Tarea 2A */
    print("Corriendo", 30, 25, C_FG_WHITE | C_BG_RED);
    break;
  case 3: /* Tarea 2B */
    print("Corriendo", 70, 25, C_FG_WHITE | C_BG_RED);
    break;
  }
}

/**
 * Dibuja los marcos y títulos iniciales de la "interfaz" del sistema.
 */
void tasks_screen_draw(void) {
  // Marcos
  screen_draw_box( 0,  0, 25, 40, ' ', C_BG_BLUE);
  screen_draw_box( 0, 40, 25, 40, ' ', C_BG_BLUE);
  screen_draw_box(25,  0, 25, 40, ' ', C_BG_RED);
  screen_draw_box(25, 40, 25, 40, ' ', C_BG_RED);
  // Contenidos
  screen_draw_box( 1,  1, 23, 38, ' ', C_BG_BLACK);
  screen_draw_box( 1, 41, 23, 38, ' ', C_BG_BLACK);
  screen_draw_box(26,  1, 23, 38, ' ', C_BG_BLACK);
  screen_draw_box(26, 41, 23, 38, ' ', C_BG_BLACK);
  // Texto
  print("Tarea 1 - A",  3,  0, C_FG_WHITE | C_BG_BLUE);
  print("Tarea 2 - A", 43,  0, C_FG_WHITE | C_BG_BLUE);
  print("Tarea 3 - A",  3, 25, C_FG_WHITE | C_BG_RED);
  print("Tarea 2 - B", 43, 25, C_FG_WHITE | C_BG_RED);
  // Tamanio
  print("38x23", 17, 12, C_FG_WHITE | C_BG_BLUE);
  print("38x23", 57, 12, C_FG_WHITE | C_BG_BLUE);
  print("38x23", 17, 37, C_FG_WHITE | C_BG_RED);
  print("38x23", 57, 37, C_FG_WHITE | C_BG_RED);
  tasks_screen_update();
}

/**
 * Actualiza las estructuras compartidas a las tareas al ocurrir una
 * interripción del teclado.
 */
void tasks_input_process(uint8_t scancode) {
  uint8_t* keyboard_state = (uint8_t*) &ENVIRONMENT->keyboard;
  keyboard_state[scancode & 0x7F] = (scancode & 0x80) == 0;
}

/**
 * Actualiza las estructuras compartidas a las tareas al ocurrir un tick del
 * reloj.
 */
void tasks_tick(void) {
  ENVIRONMENT->tick_count++;
  ENVIRONMENT->task_id = current_task;
}
