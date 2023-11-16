#ifndef __TASK_LIB_H__
#define __TASK_LIB_H__

#include "../colors.h"
#include "../shared.h"
#include "syscall.h"
#include "../task_defines.h"

#define PAGE_ON_DEMAND_BASE_VADDR 0x07000000 

/**
 * Suspende el proceso por una cantidad de ticks del reloj.
 *
 * Dado que el scheduler puede ir cambiando de tareas el parámetro debe
 * interpretarse cómo una cantidad mínima de ticks a suspenderse.
 *
 * @param ticks Cantidad de ticks a esperar antes de resumir la ejecución
 */
static void task_sleep(int ticks) {
	uint32_t clock_time = ENVIRONMENT->tick_count;
	while(ENVIRONMENT->tick_count < clock_time + ticks) {
		/* No hacemos nada*/
	}
}

static void task_print(screen output, const char* text, uint32_t x, uint32_t y,
                       uint8_t attr) {
	for (int32_t i = 0; text[i] != 0; i++) {
		output[y][x] = (ca) {
		        .c = (uint8_t)text[i],
		        .a = (uint8_t)attr
		};
		x++;
		if (x == TASK_VIEWPORT_WIDTH) {
			x = 0;
			y++;
		}
	}
}

static void task_print_dec(screen output, uint32_t numero, uint32_t size,
                           uint32_t x, uint32_t y, uint8_t attr) {
	uint8_t letras[10] = "0123456789";

	for (uint32_t i = 0; i < size; i++) {
		uint32_t resto = numero % 10;
		numero = numero / 10;
		output[y][x + size - i - 1] = (ca) {
			.c = letras[resto],
			.a = attr
		};
	}
}

static void task_print_hex(screen out, uint32_t num, uint32_t x, uint32_t y,
                           uint8_t attr) {
	uint8_t letras[16] = "0123456789ABCDEF";
	out[y][x + 0] = (ca) { .c = letras[(num & 0x0000000F) >>  0], .a = attr };
	out[y][x + 1] = (ca) { .c = letras[(num & 0x000000F0) >>  4], .a = attr };
	out[y][x + 2] = (ca) { .c = letras[(num & 0x00000F00) >>  8], .a = attr };
	out[y][x + 3] = (ca) { .c = letras[(num & 0x0000F000) >> 12], .a = attr };
	out[y][x + 4] = (ca) { .c = letras[(num & 0x000F0000) >> 16], .a = attr };
	out[y][x + 5] = (ca) { .c = letras[(num & 0x00F00000) >> 20], .a = attr };
	out[y][x + 6] = (ca) { .c = letras[(num & 0x0F000000) >> 24], .a = attr };
	out[y][x + 7] = (ca) { .c = letras[(num & 0xF0000000) >> 28], .a = attr };
}

static void task_draw_box(screen out, uint32_t x_start, uint32_t y_start,
                          uint32_t width, uint32_t height, uint8_t character,
			  uint8_t attr) {
	for (uint32_t y = 0; y < height; y++) {
		for (uint32_t x = 0; x < width; x++) {
			out[y_start + y][x_start + x] = (ca) {
				.c = character,
				.a = attr
			};
		}
	}
}


/**
 * The state word must be initialized to non-zero
 *
 * Tomado de https://en.wikipedia.org/wiki/Xorshift
 */
static uint32_t task_random(uint32_t *seed_state) {
	/* Algorithm "xor" from p. 4 of Marsaglia, "Xorshift RNGs" */
	uint32_t x = *seed_state;
	x ^= x << 13;
	x ^= x >> 17;
	x ^= x << 5;
	return *seed_state = x;
}

#endif
