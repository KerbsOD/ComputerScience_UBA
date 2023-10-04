CC=cc
CFLAGS= -std=c11 -Wall -Wextra -pedantic -O0 -g -lm -Wno-unused-variable -Wno-unused-parameter
NASM=nasm
NASMFLAGS=-f elf64 -g -F DWARF

all: main tester

OBJS := checkpoint2_c.o checkpoint2_asm.o checkpoint3_c.o checkpoint3_asm.o checkpoint4_c.o checkpoint4_asm.o snooper.o snooper_asm.o

tester: tester.c $(OBJS)
	$(CC) $(CFLAGS) $^ -o $@

main: main.c $(OBJS)
	$(CC) $(CFLAGS) $^ -o $@

tester.o: tester.c checkpoints.h test-utils.h
	$(CC) $(CFLAGS) -c $< -o $@

checkpoint2_c.o: checkpoint2.c checkpoints.h
	$(CC) $(CFLAGS) -c $< -o $@

checkpoint3_c.o: checkpoint3.c checkpoints.h
	$(CC) $(CFLAGS) -c $< -o $@

checkpoint4_c.o: checkpoint4.c checkpoints.h
	$(CC) $(CFLAGS) -c $< -o $@

checkpoint2_asm.o: checkpoint2.asm
	$(NASM) $(NASMFLAGS) $< -o $@

checkpoint3_asm.o: checkpoint3.asm
	$(NASM) $(NASMFLAGS) $< -o $@

checkpoint4_asm.o: checkpoint4.asm
	$(NASM) $(NASMFLAGS) $< -o $@

snooper.o: snooper.c checkpoints.h
	$(CC) $(CFLAGS) -c $< -o $@

snooper_asm.o: snooper.asm
	$(NASM) $(NASMFLAGS) $< -o $@

clean:
	rm -f *.o
	rm -f main tester
	rm -f salida.propios.*

