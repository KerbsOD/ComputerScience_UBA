/* ** por compatibilidad se omiten tildes **
================================================================================
 TALLER System Programming - ORGANIZACION DE COMPUTADOR II - FCEN
================================================================================

  Descripcion de la estructura de la memoria compartida de las tareas.
*/

#ifndef __SHARED_H__
#define __SHARED_H__

#include "types.h"

struct keyboard_state {
	bool _unused0;
	bool escape;
	bool top_row_one, top_row_two, top_row_three, top_row_four,
	     top_row_five, top_row_six, top_row_seven, top_row_eight,
	     top_row_nine, top_row_zero, top_row_dash, top_row_equals;
	bool backspace;
	bool tab;
	bool q, w, e, r, t, y, u, i, o, p;
	bool left_square_bracket, right_square_bracket;
	bool enter;
	bool left_control;
	bool a, s, d, f, g, h, j, k, l;
	bool semicolon;
	bool single_quote;
	bool backtick;
	bool left_shift;
	bool reverse_slash;
	bool z, x, c, v, b, n, m;
	bool comma, dot, forward_slash;
	bool right_shift;
	bool keypad_mul;
	bool left_alt;
	bool spacebar;
	bool capslock;
	bool f1, f2, f3, f4, f5, f6, f7, f8, f9, f10;
	bool numlock;
	bool scrolllock;
	bool home, up, page_up, keypad_minus,
	     left, keypad_5, right, keypad_plus,
	     end, down, page_down,
	     insert, delete;
	bool sysrq;
	bool _unused1;
	bool _unused2;
	bool f11, f12;
};

struct environment {
	uint32_t tick_count;
	int8_t task_id;
	struct keyboard_state keyboard;
};

#ifdef ORGA2__TAREA__
	/**
	 * Para las tareas de usuario la direccion de memoria es esta
	 */
	#define SHARED_MEM_PTR 0x08003000
	/**
	 * Para las tareas de usuario la pagina compartida es de solo lectura
	 */
	#define CONSTNESS const
#else
	/**
	 * Para el kernel la direccion fisica es esta
	 */
	#define SHARED_MEM_PTR 0x1D000
	/**
	 * Para el kernel la pagina compartida admite escrituras
	 */
	#define CONSTNESS
#endif

/**
 * `volatile` es una forma de decirle al compilador "esto puede cambiar por
 * razones fuera del control del programa".
 *
 * Esto significa que si el compilador ve esto:
 * ```c
 *     uint32_t count               = ENVIRONMENT->tick_count;
 *     uint32_t count_2_la_revancha = ENVIRONMENT->tick_count;
 * ```
 * no puede asumir "hay dos reads seguidos sin ningun write en el medio
 * entonces ambos reads siempre dan lo mismo".
 *
 * ¡Eso es exactamente lo que queremos!
 *
 * Si en el medio de esos dos reads ocurre una interrupción nos interesa
 * poder ver que dan distinto :)
 *
 * Por ejemplo, imaginemonos que queremos esperar a que el clock cambie,
 * haciendo que el entorno sea `volatile` podemos escribir esto:
 * ```c
 * // Leemos el reloj
 * uint32_t clock_now = ENVIRONMENT->tick_count;
 * // No hacemos nada mientras sea exactamente igual
 * while (clock_now == ENVIRONMENT->tick_count);
 * // Ahora cambió el reloj! Eso significa que "avanzamos en el tiempo"
 * ```
 */
#define ENVIRONMENT ((volatile CONSTNESS struct environment*)(SHARED_MEM_PTR))

#endif
