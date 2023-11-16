#include "task_lib.h"
#include "../i386.h"

#define WIDTH TASK_VIEWPORT_WIDTH
#define HEIGHT TASK_VIEWPORT_HEIGHT

/**
 * Celda deuna partida de snake, tiene el siguiente formato:
 *
 *     01234567
 *     ^   ^ ^-- Dirección (UP=0, DOWN=2, LEFT=2, RIGHT=3)
 *     |    `--- Tipo      (HEAD=0, BODY=1, TAIL=2, APPLE=3)
 *      `------- Vacío     (FULL=0, EMPTY=1)
 *
 * Nota: Una celda está vacía sólo si tiene el valor 0x80
 */
typedef uint8_t cell_state_t;

/**
 * Direcciones de la serpiente
 */
typedef enum { UP, DOWN, LEFT, RIGHT } cell_direction_t;

/**
 * Celdas no vacías en el juego
 */
typedef enum { HEAD, BODY, TAIL, APPLE } cell_type_t;

/**
 * Celdas vacías en el juego
 */
#define EMPTY_CELL 0x80

/**
 *  Obtiene la dirección de una celda no vacía del juego
 */
cell_direction_t cell_direction(cell_state_t cell) {
	return cell & 0x3;
}

/**
 * Obtiene el tipo de una celda no vacía del juego
 */
cell_type_t cell_type(cell_state_t cell) {
	return (cell >> 2) & 0x3;
}

/**
 * Construye una celda no-vacía con la dirección y el tipo dados
 */
cell_state_t cell(cell_type_t type, cell_direction_t direction) {
	return type << 2 | direction;
}

/**
 * Estado principal del juego
 */
typedef struct {
	uint32_t score;
	uint32_t remaining_growth;
	uint32_t body_size;
	cell_state_t map[HEIGHT][WIDTH];
} snake_t;

/**
 * Dibuja en la pantalla el estado de la partida
 */
void snake_draw(snake_t* snake, screen pantalla) {
	const char direction_char[] = {'^', 'v', '<', '>'};

	for (uint32_t y = 0; y < HEIGHT; y++) {
		for (uint32_t x = 0; x < WIDTH; x++) {
			ca* pixel = &pantalla[y][x];
			cell_state_t state = snake->map[y][x];
			cell_type_t type = cell_type(state);
			cell_direction_t direction = cell_direction(state);

			if (state == EMPTY_CELL) {
				*pixel = (ca) { .c = ' ', .a = C_BG_BLACK };
			} else if (type == APPLE) {
				*pixel = (ca) { .c = 0x9, .a = C_FG_LIGHT_RED };
			} else if (type == HEAD) {
				*pixel = (ca) { .c = direction_char[direction], .a = C_FG_LIGHT_BROWN | C_BG_BROWN };
			} else if (type == BODY) {
				*pixel = (ca) { .c = direction_char[direction], .a = C_FG_LIGHT_GREEN | C_BG_GREEN };
			} else if (type == TAIL) {
				*pixel = (ca) { .c = direction_char[direction], .a = C_FG_LIGHT_RED | C_BG_RED };
			}
		}
	}
	task_print_dec(pantalla, snake->score, 2, WIDTH / 2 - 1, 0, C_FG_WHITE);
	// Le pedimos al sistema operativo que muestre nuestra pantalla
	syscall_draw(pantalla);
}

/**
 * Spawnea una nueva manzanita y acomoda el estado de la partida para que
 * reaccione acorde.
 */
void spawn_apple(snake_t* snake) {
	uint32_t random_state = ENVIRONMENT->tick_count;
	uint32_t y, x;
	// Buscamos un punto x,y en un casillero vacío
	do {
		y = task_random(&random_state) % HEIGHT;
		x = task_random(&random_state) % WIDTH;
	} while(snake->map[y][x] != EMPTY_CELL);
	// Ponemos la manzanita
	snake->map[y][x] = cell(APPLE, UP);
}

/**
 * Procesa un "turno" del snake
 */
void snake_tick(snake_t* snake) {
	// Mientras procesamos el estado buscamos la cabeza y cola de paso
	cell_state_t* head = NULL;
	cell_state_t* tail = NULL;

	for (uint32_t y = 0; y < HEIGHT; y++) {
		for (uint32_t x = 0; x < WIDTH; x++) {
			cell_state_t state = snake->map[y][x];
			cell_type_t type = cell_type(state);
			cell_direction_t direction = cell_direction(state);

			// No nos importan las celdas vacías
			if (state == EMPTY_CELL) continue;

			// Si vemos una cabeza (y no la habíamos visto antes) la procesamos
			if (head == NULL && type == HEAD) {
				// La cabeza se mueve y pasa a ser cuerpo
				snake->map[y][x] = cell(BODY, direction);
				// Apuntamos a la nueva cabeza si queda en rango
				if (direction == UP && 0 < y) {
					head = &snake->map[y-1][x];
				} else if (direction == DOWN && y < HEIGHT - 1) {
					head = &snake->map[y+1][x];
				} else if (direction == LEFT && 0 < x) {
					head = &snake->map[y][x-1];
				} else if (direction == RIGHT && x < WIDTH - 1) {
					head = &snake->map[y][x+1];
				}

				if (head != NULL) {
					// Nos podemos mover a un espacio vacío o a una manzanita
					if (*head == EMPTY_CELL) {
						*head = cell(HEAD, direction);
					} else if (cell_type(*head) == APPLE) {
						*head = cell(HEAD, direction);
						// Ponemos una manzanita nueva
						spawn_apple(snake);
						// Le damos un punto al jugador
						snake->score++;
						// La serpiente tiene que crecer un poco
						snake->remaining_growth += 4;
					} else {
						// Caso contrario la serpiente se queda sin cabeza X_X
						head = NULL;
					}
				}
			}
			// Si vemos una cola (y no la habíamos visto antes) la procesamos
			if (tail == NULL && type == TAIL) {
				// Apuntamos a la nueva cola si queda en rango
				if (direction == UP && 0 < y) {
					tail = &snake->map[y-1][x];
				} else if (direction == DOWN && y < HEIGHT - 1) {
					tail = &snake->map[y+1][x];
				} else if (direction == LEFT && 0 < x) {
					tail = &snake->map[y][x-1];
				} else if (direction == RIGHT && x < WIDTH - 1) {
					tail = &snake->map[y][x+1];
				}

				// Si se puede mover la cola (y la serpiente no tiene que crecer) lo hacemos
				if (tail != NULL && snake->remaining_growth == 0) {
					snake->map[y][x] = EMPTY_CELL;
					*tail = cell(TAIL, cell_direction(*tail));
				}
			}
		}
	}

	// Si encontramos la cabeza entonces procesemos la dirección deseada por el jugador
	if (head != NULL) {
		cell_direction_t direction = cell_direction(*head);
		if (ENVIRONMENT->keyboard.up && direction != DOWN) {
			*head = cell(HEAD, UP);
		} else if (ENVIRONMENT->keyboard.down && direction != UP) {
			*head = cell(HEAD, DOWN);
		} else if (ENVIRONMENT->keyboard.left && direction != RIGHT) {
			*head = cell(HEAD, LEFT);
		} else if (ENVIRONMENT->keyboard.right && direction != LEFT) {
			*head = cell(HEAD, RIGHT);
		}
	}

	// Si la seripente fué decapitada entonces se va achicando su cuerpo
	if (head == NULL) {
		snake->body_size--;
	}

	// Si la serpiente tenía que crecer acomodamos los contadores
	if (snake->remaining_growth > 0) {
		snake->remaining_growth--;
		snake->body_size++;
	}
}

/**
 * Juega una partida de snake
 */
void partida(screen pantalla) {
	// Estado inicial de la partida
	snake_t snake = { .score = 0, .remaining_growth = 0, .body_size = 1 };
	for (uint32_t y = 0; y < HEIGHT; y++) {
		for (uint32_t x = 0; x < WIDTH; x++) {
			snake.map[y][x] = EMPTY_CELL;
		}
	}
	snake.map[HEIGHT/2-1][WIDTH/2] = cell(HEAD, UP);
	snake.map[HEIGHT/2  ][WIDTH/2] = cell(BODY, UP);
	snake.map[HEIGHT/2+1][WIDTH/2] = cell(TAIL, UP);
	spawn_apple(&snake);

	// Si se aprieta escape se termina la partida
	// Si sólo le queda la cola a la serpiente se termina la partida
	while (!ENVIRONMENT->keyboard.escape && snake.body_size != 0) {
		snake_tick(&snake);
		snake_draw(&snake, pantalla);

		// Espero un ratito para que el juego no sea súper rápido
		task_sleep(50);
	}
}

void task(void) {
	while (true) {
		screen pantalla;

		// Imprimimos las instrucciones
		task_print(pantalla, "ESC: Terminar partida", 8, 11, C_FG_LIGHT_GREY);
		task_print(pantalla, "Presione enter para jugar", 6, 12, C_FG_WHITE);

		// Dibujamos las instrucciones en la pantalla
		syscall_draw(pantalla);

		// Espero a que se apriete enter
		while (!ENVIRONMENT->keyboard.enter);

		// Arranco una partida
		partida(pantalla);
	}
}
