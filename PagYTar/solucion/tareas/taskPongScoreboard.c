#include "task_lib.h"

#define WIDTH TASK_VIEWPORT_WIDTH
#define HEIGHT TASK_VIEWPORT_HEIGHT

#define SHARED_SCORE_BASE_VADDR (PAGE_ON_DEMAND_BASE_VADDR + 0xF00)
#define CANT_PONGS 3


void task(void) {
	screen pantalla;
	// ¿Una tarea debe terminar en nuestro sistema?
	while (true)
	{
	// Completar:
	// - Pueden definir funciones auxiliares para imprimir en pantalla
	// - Pueden usar `task_print`, `task_print_dec`, etc. 
		syscall_draw(pantalla);
	}
}
