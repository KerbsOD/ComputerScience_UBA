NASM:=nasm
NASMFLAGS:=-Wall -f elf64 -g -F DWARF -Wall

SRCS:= sumador.asm \
       print_uint64.asm

TARGET:=sumador

OBJS=$(SRCS:.asm=.o)

all: $(TARGET)

%.o: %.asm 
	$(NASM) $(NASMFLAGS) $< -o $@

$(TARGET): $(OBJS)
	ld -o $@ $^

clean:
	rm -f *.o
	rm -f sumador