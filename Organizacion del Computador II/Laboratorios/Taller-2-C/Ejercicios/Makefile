CFLAGS += -Wall -Wextra -O0 -ggdb -lm -Wno-unused-variable -Wno-unused-parameter -no-pie

TARGETS:= tests_lista_enlazada tests_classify_chars tests_vector tests_contar_espacios

all: $(TARGETS)

RUN := $(patsubst %,run_%, $(TARGETS))

clean:
	rm -f *.o $(TARGETS)

$(RUN): run_%: % 
	valgrind --show-reachable=yes --leak-check=full --error-exitcode=1 ./$* \
	&& echo "No se detectaron errores de memoria" 


tests_lista_enlazada: tests_lista_enlazada.o lista_enlazada.o
	$(CC) $(CFLAGS) $^ -o $@

tests_classify_chars: tests_classify_chars.o classify_chars.o
	$(CC) $(CFLAGS) $^ -o $@

tests_vector: tests_vector.o vector.o
	$(CC) $(CFLAGS) $^ -o $@

tests_contar_espacios: tests_contar_espacios.o contar_espacios.o
	$(CC) $(CFLAGS) $^ -o $@

lista_simple.o: lista_enlazada.c

classify_chars.o: classify_chars.c

vector.o: vector.c

.PHONY: all clean 