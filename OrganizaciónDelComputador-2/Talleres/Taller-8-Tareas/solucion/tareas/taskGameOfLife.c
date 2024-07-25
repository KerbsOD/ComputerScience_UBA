#include "task_lib.h"

#define WIDTH TASK_VIEWPORT_WIDTH
#define HEIGHT TASK_VIEWPORT_HEIGHT

typedef bool gol_grid[HEIGHT][WIDTH];

/**
 * Avanzo la simulación un paso
 */
void step(gol_grid gol) {
	gol_grid next_gol;

	for (int i = 0; i < HEIGHT; i++) {
		for (int j = 0; j < WIDTH; j++) {
			int izquierda = (j + HEIGHT - 1) % HEIGHT;
			int derecha   = (j + 1) % HEIGHT;
			int arriba    = (i + WIDTH - 1) % WIDTH;
			int abajo     = (i + 1) % WIDTH;
			int vecinos_vivos = gol[     i][        j]
			                  + gol[     i][  derecha]
			                  + gol[     i][izquierda]
			                  + gol[arriba][        j]
			                  + gol[arriba][  derecha]
			                  + gol[arriba][izquierda]
			                  + gol[ abajo][        j]
			                  + gol[ abajo][  derecha]
			                  + gol[ abajo][izquierda];
			next_gol[i][j] = vecinos_vivos == 4
			              || (gol[i][j] && vecinos_vivos == 3);
		}
	}

	for (int i = 0; i < HEIGHT; i++) {
		for (int j = 0; j < WIDTH; j++) {
			gol[i][j] = next_gol[i][j];
		}
	}
}

/**
 * Armo un nuevo estado inicial
 */
void randomize(gol_grid gol) {
	int random_state = ENVIRONMENT->tick_count + ENVIRONMENT->task_id * 7;
	for (int i = 0; i < HEIGHT; i++) {
		for (int j = 0; j < WIDTH; j++) {
			gol[i][j] = task_random(&random_state) % 2;
		}
	}
}

/**
 * Implementación a simplista del juego de la vida de Conway
 */
void task() {
	screen pantalla;
	gol_grid gol;

	randomize(gol);
	int sleep_time = 50;

	while (!ENVIRONMENT->keyboard.escape) {
		for (int i = 0; i < HEIGHT; i++) {
			for (int j = 0; j < WIDTH; j++) {
				pantalla[i][j] = (ca){
					.c = ' ',
					.a = gol[i][j]
					   ? C_BG_LIGHT_GREY
					   : C_BG_BLACK
				};
			}
		}
		step(gol);
		syscall_draw(pantalla);
		task_sleep(sleep_time);

		if (ENVIRONMENT->keyboard.up) {
			randomize(gol);
		} else if (ENVIRONMENT->keyboard.left && 50 <= sleep_time) {
			sleep_time++;
		} else if (ENVIRONMENT->keyboard.right && sleep_time > 50) {
			sleep_time--;
		}
	}
}
