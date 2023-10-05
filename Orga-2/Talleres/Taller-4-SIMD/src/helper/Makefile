# ****************************************************************** #
#   Organizacion del Computador II - Taller SIMD                     #
# ****************************************************************** #

CFLAGS64 = -ggdb -Wall -Wno-unused-parameter -Wextra -std=c99 -no-pie -pedantic -m64 -O0 -march=native
CFLAGS=$(CFLAGS64)

BUILD_DIR = ../build
BIN = simd

OBJS          = libbmp.o imagenes.o utils.o
OBJS_CON_PATH = $(addprefix $(BUILD_DIR)/, $(OBJS))
BMPDIFF       = $(BUILD_DIR)/bmpdiff

# .PHONY: all clean libbmp bmpdiff

all: $(OBJS_CON_PATH) bmpdiff

lib: all

$(BUILD_DIR)/%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

bmpdiff: bmpdiff.c $(OBJS_CON_PATH)
	$(CC) $(CFLAGS) bmpdiff.c $(OBJS_CON_PATH) -o $(BMPDIFF)


clean:
	rm -f $(OBJS_CON_PATH) $(BMPDIFF)
