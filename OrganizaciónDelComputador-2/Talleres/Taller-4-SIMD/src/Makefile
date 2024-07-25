# **************************************************************** #
#   Organizacion del Computador II - Taller SIMD                   #
# **************************************************************** #

CFLAGS64 = -ggdb -Wall -Wno-unused-parameter -Wextra -z noexecstack -std=c99 -no-pie -pedantic -m64 -O0 -march=native
CFLAGS=$(CFLAGS64)

BUILD_DIR = build
BIN = simd

FILTROS = temperature Pintar

FILTROS_OBJ = $(addsuffix .o, $(FILTROS)) $(addsuffix _asm.o, $(FILTROS)) $(addsuffix _c.o, $(FILTROS))
LIBS_OBJS   = libbmp.o imagenes.o utils.o
MAIN_OBJS   = simd.o cli.o
MAIN_OBJS_CON_PATH = $(addprefix $(BUILD_DIR)/, $(MAIN_OBJS))

OBJS = $(MAIN_OBJS) $(LIBS_OBJS) $(FILTROS_OBJ)
OBJS_CON_PATH = $(addprefix $(BUILD_DIR)/, $(OBJS))

.PHONY: all clean FORCE

all: $(BUILD_DIR)/$(BIN)

$(BUILD_DIR)/$(BIN): FORCE $(MAIN_OBJS_CON_PATH)
	$(CC) $(CFLAGS) $(OBJS_CON_PATH) -o $@ -lm

export CFLAGS64
FORCE:
	make -C helper
	make -C filters

$(BUILD_DIR)/%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $< -lm

clean:
	rm -fr $(BUILD_DIR)/*



