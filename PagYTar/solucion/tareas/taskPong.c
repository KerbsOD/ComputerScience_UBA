#include "task_lib.h"

#define WIDTH TASK_VIEWPORT_WIDTH
#define HEIGHT TASK_VIEWPORT_HEIGHT

#define PLAYER_WIDTH 5

#define SHARED_SCORE_BASE_VADDR (PAGE_ON_DEMAND_BASE_VADDR + 0xF00)

/**
 * Un jugador está dado por su posición vertical en la pantalla y su puntaje
 */
typedef struct {
	int32_t y;
	uint32_t score;
} player;

/**
 * Una pelota tiene una posición en la pantalla y una velocidad (con
 * dirección!)
 */
typedef struct {
	int32_t x, y;
	int32_t dx, dy;
} ball;

/**
 * Una partida de pong consiste de un par de jugadores, una pelota y un estado
 * del juego.
 *
 * El estado del juego puede ser que saque uno de los dos jugadores o que la partida esté en juego
 */
typedef struct pong {
	ball ball;
	player player1, player2;
	player* saca;
} pong;

/**
 * Dibuja en la pantalla el estado de la partida
 */
void pong_draw(struct pong* pong, screen pantalla) {
	// Pintamos todo de negro
	task_draw_box(pantalla, 0, 0, WIDTH, HEIGHT, ' ', C_BG_BLACK);
	// El jugador al que le toca sacar parpadea para ser más visible
	uint8_t player1_blinks = pong->saca == &pong->player1 ? C_BLINK : 0;
	uint8_t player2_blinks = pong->saca == &pong->player2 ? C_BLINK : 0;
	// Pintamos el puntaje de cada jugador
	task_print_dec(pantalla, pong->player1.score, 2, WIDTH / 2 - 3, 0, C_FG_CYAN);
	task_print_dec(pantalla, pong->player2.score, 2, WIDTH / 2 + 3, 0, C_FG_MAGENTA);
	// Pintamos el "personaje" de cada jugador
	task_draw_box(pantalla, 0,         pong->player1.y, 1, PLAYER_WIDTH, 0xDE, C_FG_CYAN    | player1_blinks);
	task_draw_box(pantalla, WIDTH - 1, pong->player2.y, 1, PLAYER_WIDTH, 0xDD, C_FG_MAGENTA | player2_blinks);
	// Ponemos la pelota en la pantalla
	pantalla[pong->ball.y][pong->ball.x] = (ca) { .c = 0x9, .a = C_FG_WHITE };
	// Le pedimos al sistema operativo que muestre nuesta pantalla
	syscall_draw(pantalla);
}

/**
 * Mueve un jugador hacia arriba. Si una pelota no-nula se pasa como
 * parámetro ésta se mueve acompañando al jugador.
 *
 * Si el jugador está en la posición más superior permitida la función
 * no realiza ningún cambio.
 */
void player_up(player* player, ball* ball) {
	if (player->y > 0) {
		player->y--;
		if (ball != NULL) {
			ball->y--;
		}
	}
}

/**
 * Mueve un jugador hacia abajo. Si una pelota no-nula se pasa como
 * parámetro ésta se mueve acompañando al jugador.
 *
 * Si el jugador está en la posición más inferior permitida la función
 * no realiza ningún cambio.
 */
void player_down(player* player, ball* ball) {
	if (player->y < HEIGHT - PLAYER_WIDTH) {
		player->y++;
		if (ball != NULL) ball->y++;
	}
}

/**
 * Dada una pelota y un jugador determina si éste sería capaz de "atajarla".
 * La función sólo chequea el eje Y de la pelota y asume que el jugador
 * está en la misma posición X que la pelota.
 */
bool should_score_against(ball* ball, player* player) {
	return ball->y < player->y || player->y + PLAYER_WIDTH <= ball->y;
}

/**
 * Actualiza el score en la pagina compartida.
 */
void update_shared_record_score(pong* pong) {
	uint8_t task_id = ENVIRONMENT->task_id;
	uint32_t* current_task_record = (uint32_t*) SHARED_SCORE_BASE_VADDR + ((uint32_t) task_id * sizeof(uint32_t)*2);
	current_task_record[0] = pong->player1.score;
	current_task_record[1] = pong->player2.score;
}

/**
 * Emite un punto en favor de `scorer`.
 *
 * Esto significa que la pelota se mueve al límite superior del jugador al
 * que le hicieron un punto y el jugador damnificado procede a sacar.
 */
void score(player* scorer, player* opponent, pong* pong) {
	pong->saca = opponent;
	pong->ball = (ball){
		.x = pong->ball.x - pong->ball.dx, .y = opponent->y,
		.dx = 0, .dy = 0
	};
	scorer->score++;
	update_shared_record_score(pong);
}

/**
 * Juega una partida de pong
 */
void partida(screen pantalla) {
	// Estado inicial de la partida
	struct pong pong = {
		.ball = { .x = 1, .y = 0, .dx = 0, .dy = 0 },
		.player1 = { .y = 0,                     .score = 0 },
		.player2 = { .y = HEIGHT - PLAYER_WIDTH, .score = 0 },
		.saca = &pong.player1
	};

	// Si se aprieta escape se termina la partida
	while (!ENVIRONMENT->keyboard.escape) {
		// Me fijo si algún jugador tiene control de la pelota
		ball* player1_ball = NULL;
		ball* player2_ball = NULL;
		if (pong.saca == &pong.player1) player1_ball = &pong.ball;
		if (pong.saca == &pong.player2) player2_ball = &pong.ball;

		// Reviso el teclado y muevo a los jugadores de acuerdo a eso
		if (ENVIRONMENT->keyboard.w)      player_up(&pong.player1, player1_ball);
		if (ENVIRONMENT->keyboard.s)    player_down(&pong.player1, player1_ball);
		if (ENVIRONMENT->keyboard.up)     player_up(&pong.player2, player2_ball);
		if (ENVIRONMENT->keyboard.down) player_down(&pong.player2, player2_ball);

		// Si a alguien le toca sacar proceso el saque
		if (ENVIRONMENT->keyboard.spacebar) {
			if (pong.saca == &pong.player1) {
				pong.ball.dx =  1;
				pong.ball.dy = -1;
				pong.saca = NULL;
			}
			if (pong.saca == &pong.player2) {
				pong.ball.dx = -1;
				pong.ball.dy =  1;
				pong.saca = NULL;
			}
		}

		// Muevo la pelota
		pong.ball.x += pong.ball.dx;
		pong.ball.y += pong.ball.dy;

		// La pelota tocó la pared de la izquierda.
		// Si el player 1 la ataja rebota, sino punto para el player 2.
		if (pong.ball.x == 0) {
			if (should_score_against(&pong.ball, &pong.player1)) {
				score(&pong.player2, &pong.player1, &pong);
			} else {
				pong.ball.dx *= -1;
				pong.ball.x += pong.ball.dx;
			}
		}

		// La pelota tocó la pared de la derecha.
		// Si el player 2 la ataja rebota, sino punto para el player 1.
		if (pong.ball.x == WIDTH - 1) {
			if (should_score_against(&pong.ball, &pong.player2)) {
				score(&pong.player1, &pong.player2, &pong);
			} else {
				pong.ball.dx *= -1;
				pong.ball.x += pong.ball.dx;
			}
		}

		// Reboto en la pared superior o superior
		if (pong.ball.y == -1 || pong.ball.y == HEIGHT) {
			pong.ball.dy *= -1;
			pong.ball.y += pong.ball.dy;
		}

		// Dibujo el estado del juego
		pong_draw(&pong, pantalla);

		// Espero un ratito para que el juego no sea súper rápido
		task_sleep(50);
	}
}

void task(void) {
	while (true) {
		screen pantalla;

		// Imprimimos las instrucciones
		task_print(pantalla, "Player 1", 1, 5, C_FG_CYAN);
		task_print(pantalla, "W: \x18",  4, 8, C_FG_CYAN);
		task_print(pantalla, "S: \x19",  4, 9, C_FG_CYAN);
		task_print(pantalla, "Player 2", 29, 5, C_FG_MAGENTA);
		task_print(pantalla, "  Up: \x18", 29, 8, C_FG_MAGENTA);
		task_print(pantalla, "Down: \x19", 29, 9, C_FG_MAGENTA);
		task_print(pantalla, "Espacio: Lanzar pelota", 8, 10, C_FG_LIGHT_GREY);
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
