#include "task_lib.h"

/**
 * Dado un texto con sus atributos lo escribe letra a letra en la pantalla
 * pausando `pausa` ticks entre cada letra.
 */
void tipear(screen pantalla, const char* texto, uint8_t attrs, uint32_t x, uint32_t y, uint32_t pausa) {
	for (uint32_t i = 0; texto[i] != '\0'; i++) {
		pantalla[y][x + i] = (ca) { .c = texto[i], .a = attrs };
		syscall_draw(pantalla);
		task_sleep(pausa);
	}
}

void task(void) {
	const char* all_star =
		"Somebody once told me the world is gonna roll me "
		"I ain't the sharpest tool in the shed "
		"She was looking kind of dumb with her finger and her thumb "
		"In the shape of an \"L\" on her forehead "
		"Well, the years start comin' and they don't stop comin' "
		"Fed to the rules and I hit the ground runnin' "
		"Didn't make sense not to live for fun "
		"Your brain gets smart but your head gets dumb "
		"So much to do, so much to see "
		"So what's wrong with taking the backstreets? "
		"You'll never know if you don't go (W-w-wacko) "
		"You'll never shine if you don't glow";
	const char* bee_movie =
		"According to all known laws of aviation, there is no way a bee should be able to "
		"fly. Its wings are too small to get its fat little body off the ground. The bee, "
		"of course, flies anyway because bees don't care what humans think is impossible. ";
	screen pantalla;
	tipear(
		pantalla,
		ENVIRONMENT->task_id % 2 == 0
			? all_star
			: bee_movie,
		C_FG_CYAN,
		0, 0,
		10
	);
}
