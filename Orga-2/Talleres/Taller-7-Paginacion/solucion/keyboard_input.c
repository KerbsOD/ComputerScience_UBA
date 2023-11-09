/* ** por compatibilidad se omiten tildes **
================================================================================
 TALLER System Programming - ORGANIZACION DE COMPUTADOR II - FCEN
================================================================================

  Controlador de teclado minimal
*/

#include "keyboard_input.h"
#include "screen.h"

static void unrecognized_scancode(uint8_t scancode);
#define TOGGLE_SHIFT_IDX 1
static void toggle_shift(uint8_t);
#define MOVE_DOWN_IDX 2
static void move_down(uint8_t);
#define MOVE_UP_IDX 3
static void move_up(uint8_t);
#define MOVE_LEFT_IDX 4
static void move_left(uint8_t);
#define MOVE_RIGHT_IDX 5
static void move_right(uint8_t);
#define NEW_LINE_IDX 6
static void new_line(uint8_t);

// Este es un array de punteros a funciones
typedef void (*scancode_handler) (uint8_t scancode);
static const scancode_handler special_scancodes[] = {
	unrecognized_scancode,
	toggle_shift,
	move_down,
	move_up,
	move_left,
	move_right,
	new_line
};

struct scancode_info {
	// Si es distinto de '\0' su valor es la letra a imprimir de no estar
	// shift activado.
	uint8_t main_value;
	// Si `main_value` es distinto de '\0' su valor es la letra a imprimir
	// de estar shift activado.
	//
	// Sino su valor es un índice en la tabla `special_scancodes` que
	// determina el código a ejecutar para esta tecla.
	uint8_t special_value;
};

// Lista sacada de https://www.win.tue.nl/~aeb/linux/kbd/scancodes-1.html
static const struct scancode_info scancode_defs[256] = {
	[0x01] = { '\0', '\0' }, // Esc

	[0x02] = { '1', '!' },
	[0x03] = { '2', '@' },
	[0x04] = { '3', '#' },
	[0x05] = { '4', '$' },
	[0x06] = { '5', '%' },
	[0x07] = { '6', '^' },
	[0x08] = { '7', '&' },
	[0x09] = { '8', '*' },
	[0x0a] = { '9', '(' },
	[0x0b] = { '0', ')' },
	[0x0c] = { '-', '_' },
	[0x0d] = { '=', '+' },
	[0x0e] = { '\0', MOVE_LEFT_IDX }, // Backspace

	[0x0f] = { '\0', '\0' }, // Tab
	[0x10] = { 'q', 'Q' },
	[0x11] = { 'w', 'W' },
	[0x12] = { 'e', 'E' },
	[0x13] = { 'r', 'R' },
	[0x14] = { 't', 'T' },
	[0x15] = { 'y', 'Y' },
	[0x16] = { 'u', 'U' },
	[0x17] = { 'i', 'I' },
	[0x18] = { 'o', 'O' },
	[0x19] = { 'p', 'P' },
	[0x1a] = { '[', '{' },
	[0x1b] = { ']', '}' },

	[0x1c] = { '\0', NEW_LINE_IDX }, // Enter

	[0x1d] = { '\0', '\0' }, // LCtrl

	[0x1e] = { 'a', 'A' },
	[0x1f] = { 's', 'S' },
	[0x20] = { 'd', 'D' },
	[0x21] = { 'f', 'F' },
	[0x22] = { 'g', 'G' },
	[0x23] = { 'h', 'H' },
	[0x24] = { 'j', 'J' },
	[0x25] = { 'k', 'K' },
	[0x26] = { 'l', 'L' },
	[0x27] = { ';', ':' },
	[0x28] = { '\'', '"' },

	[0x29] = { '`', '~' },

	[0x2a] = { '\0', TOGGLE_SHIFT_IDX }, // LShift
	[0x80 | 0x2a] = { '\0', TOGGLE_SHIFT_IDX }, // LShift (UP)

	[0x2b] = { '\\', '|' }, // on a 102-key keyboard

	[0x2c] = { 'z', 'Z' },
	[0x2d] = { 'x', 'X' },
	[0x2e] = { 'c', 'C' },
	[0x2f] = { 'v', 'V' },
	[0x30] = { 'b', 'B' },
	[0x31] = { 'n', 'N' },
	[0x32] = { 'm', 'M' },
	[0x33] = { ',', '<' },
	[0x34] = { '.', '>' },
	[0x35] = { '/', '?' },
	[0x36] = { '\0', '\0' }, // RShift

	[0x37] = { '\0', '\0' }, // Keypad-* or */PrtScn on a 83/84-key keyboard

	[0x38] = { '\0', '\0' }, // LAlt
	[0x39] = { ' ', ' ' }, // Space bar

	[0x3a] = { '\0', TOGGLE_SHIFT_IDX }, // CapsLock

	// IDEA: ¿Como usarian los Fx para poder cambiar de color?
	[0x3b] = { '\0', '\0' }, // F1
	[0x3c] = { '\0', '\0' }, // F2
	[0x3d] = { '\0', '\0' }, // F3
	[0x3e] = { '\0', '\0' }, // F4
	[0x3f] = { '\0', '\0' }, // F5
	[0x40] = { '\0', '\0' }, // F6
	[0x41] = { '\0', '\0' }, // F7
	[0x42] = { '\0', '\0' }, // F8
	[0x43] = { '\0', '\0' }, // F9
	[0x44] = { '\0', '\0' }, // F10

	[0x45] = { '\0', '\0' }, // NumLock

	[0x46] = { '\0', '\0' }, // ScrollLock

	[0x47] = { '\0', '\0' }, // Keypad-7/Home
	[0x48] = { '\0', MOVE_UP_IDX }, // Keypad-8/Up
	[0x49] = { '\0', '\0' }, // Keypad-9/PgUp

	[0x4a] = { '\0', '\0' }, // Keypad--

	[0x4b] = { '\0', MOVE_LEFT_IDX }, // Keypad-4/Left
	[0x4c] = { '\0', '\0' }, // Keypad-5
	[0x4d] = { '\0', MOVE_RIGHT_IDX }, // Keypad-6/Right
	[0x4e] = { '\0', '\0' }, // Keypad-+

	[0x4f] = { '\0', '\0' }, // Keypad-1/End
	[0x50] = { '\0', MOVE_DOWN_IDX }, // Keypad-2/Down
	[0x51] = { '\0', '\0' }, // Keypad-3/PgDn

	[0x52] = { '\0', '\0' }, // Keypad-0/Ins
	[0x53] = { '\0', '\0' }, // Keypad-./Del

	[0x54] = { '\0', '\0' }, // Alt-SysRq on a 84+ key keyboard

	[0x57] = { '\0', '\0' }, // F11 on a 101+ key keyboard
	[0x58] = { '\0', '\0' } // F12 on a 101+ key keyboard
};

static int curr_row = 0;
static int curr_column = 0;
static int is_shift_pressed = 0;
static uint8_t curr_attr = C_FG_BLACK | C_BG_RED;
static ca under_marker = { .c = ' ', C_FG_BLACK | C_BG_BLUE };

static void fix_rowcol() {
	int old_column = curr_column;
	curr_column = ((curr_column % VIDEO_COLS) + VIDEO_COLS) % VIDEO_COLS;

	curr_row += (old_column - curr_column) / VIDEO_COLS;
	curr_row = ((curr_row % VIDEO_FILS) + VIDEO_FILS) % VIDEO_FILS;
}

static void put(char to_print) {
        ca(*screen)[VIDEO_COLS] = (ca(*)[VIDEO_COLS])VIDEO;
	screen[curr_row][curr_column].c = to_print;
	screen[curr_row][curr_column].a = curr_attr;
}

static void put_marker() {
        ca(*screen)[VIDEO_COLS] = (ca(*)[VIDEO_COLS])VIDEO;
	under_marker = screen[curr_row][curr_column];
	screen[curr_row][curr_column].c = 0xDB;
	screen[curr_row][curr_column].a = curr_attr | C_BLINK;
}

static void restore_marker() {
        ca(*screen)[VIDEO_COLS] = (ca(*)[VIDEO_COLS])VIDEO;
	screen[curr_row][curr_column] = under_marker;
}

static void unrecognized_scancode(uint8_t scancode) {
	if(!(scancode & 0x80))
		print_hex(scancode,2,80/2-1,50/2,C_FG_CYAN | C_FG_BLUE);
}

// GCC se queja de que no usamos el scancode si no le aseguramos que esa es
// nuestra intención.
#define unused __attribute__((unused))

static void toggle_shift(unused uint8_t scancode) {
	is_shift_pressed = !is_shift_pressed;
}

static void move_down(unused uint8_t scancode) {
	restore_marker();
	curr_row++;
	fix_rowcol();
	put_marker();
}
static void move_up(unused uint8_t scancode) {
	restore_marker();
	curr_row--;
	fix_rowcol();
	put_marker();
}
static void move_left(unused uint8_t scancode) {
	restore_marker();
	curr_column--;
	fix_rowcol();
	put_marker();
}
static void move_right(unused uint8_t scancode) {
	restore_marker();
	curr_column++;
	fix_rowcol();
	put_marker();
}
static void new_line(unused uint8_t scancode) {
	restore_marker();
	curr_column = 0;
	curr_row++;
	fix_rowcol();
	put_marker();
}

void process_scancode(uint8_t scancode) {
	struct scancode_info info = scancode_defs[scancode];

	if (info.main_value == '\0') {
		special_scancodes[info.special_value](scancode);
		return;
	}

	put(is_shift_pressed ? info.special_value : info.main_value);

	curr_column++;
	fix_rowcol();
	put_marker();
}
