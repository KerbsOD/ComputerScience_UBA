CC=cc
CFLAGS= -std=c11 -Wall -Wextra -pedantic -O0 -g -lm -z noexecstack -Wno-unused-variable -Wno-unused-parameter 
NASM=nasm
NASMFLAGS=-f elf64 -g -F DWARF 

all: main tester

OBJS := checkpoint1_c.o checkpoint1_asm.o checkpoint2_c.o checkpoint2_asm.o

tester: tester.c $(OBJS)
	$(CC) $(CFLAGS) $^ -o $@

main: main.c $(OBJS)
	$(CC) $(CFLAGS) $^ -o $@

tester.o: tester.c checkpoints.h test-utils.h
	$(CC) $(CFLAGS) -c $< -o $@

checkpoint1_c.o: checkpoint1.c checkpoints.h
	$(CC) $(CFLAGS) -c $< -o $@

checkpoint2_c.o: checkpoint2.c checkpoints.h
	$(CC) $(CFLAGS) -c $< -o $@

checkpoint1_asm.o: checkpoint1.asm
	$(NASM) $(NASMFLAGS) $< -o $@

checkpoint2_asm.o: checkpoint2.asm
	$(NASM) $(NASMFLAGS) $< -o $@

clean:
	rm -f *.o
	rm -f main tester
	rm -f salida.propios.*

