# ** por compatibilidad se omiten tildes **
# ==============================================================================
# TALLER System Programming - ORGANIZACION DE COMPUTADOR II - FCEN
# ==============================================================================

MCOPY=mcopy

KERNEL_SRC=kernel.asm
KERNEL_OBJ=kernel.o
KERNEL_BIN=kernel.bin

OBJ=$(KERNEL_OBJ) gdt.o screen.o idt.o isr.o pic.o keyboard_input.o

# Dependencias, generado por el flag -MMD de gcc, util para recompilar cuando actualizamos headers.
DEP=$(OBJ:%.o=%.d)
DISK_IMG=diskette.img
DISK_IMG_BZ=diskette.img.bz2

CFLAGS=-Wall -Wextra -pedantic -std=c99 -Werror -Og -ggdb \
  -m32 -march=i386 -ffreestanding -fno-pie -fno-zero-initialized-in-bss -fno-stack-protector


CODESIZE=$$((0x18000 - 0x1200))
TASKSSIZE=$$((2 * (0x1000) * 2 + 0x1000)) # Dos tareas de 2 paginas + 1 pagina idle.
KERNELSIZE=$$(($(CODESIZE)+$(TASKSSIZE)))


CC=gcc
NASM=nasm
NASMFLAGS=-felf32 -g -F DWARF
OBJCOPY=objcopy
NM=nm
LD=ld
LDFLAGS=-static -m elf_i386 -b elf32-i386 -e start -Ttext 0x1200

QUIET = @

.PHONY=clean all image

all:  clean image

format:
	clang-format -i *.h *.c

%.o: %.c
	$(CC) $(CFLAGS) -MMD -c $< -o $@

%.o: %.asm
	$(NASM) $(NASMFLAGS) $< -MD $(basename $@).d -o $@

seed:
	RNG=$$(head -c 32 /dev/urandom | shasum -a 256 | cut -c1-16);\
	sed -i "s/seed.*/seed=0x$${RNG}ull;/" seed.c;\

-include $(DEP)

kernel.bin: $(OBJ)
	@echo 'Linkeando kernel...'
	$(LD) $(LDFLAGS) -o $@.elf $(OBJ)
	@echo 'Extrayendo tabla de simbolos...'
	$(NM) $@.elf | grep -v " U " | awk '{print "0x" $$1 " " $$3}' > kernel.sym
	@echo 'Generando binario sin informacion elf...'
	$(OBJCOPY) -S -O binary $@.elf $@
	@echo ''
	@echo 'Generando imagen del kernel...'
	mv kernel.bin kernel.bin.tmp
	dd if=/dev/zero of=kernel.bin bs=1 count=$(KERNELSIZE) conv=notrunc status=noxfer > /dev/null
	dd if=kernel.bin.tmp of=kernel.bin bs=1 count=$(CODESIZE) conv=notrunc status=noxfer > /dev/null
	rm kernel.bin.tmp
	@echo ''

image: kernel.bin $(DISK_IMG)
	@echo 'Copiando el $(KERNEL_BIN) a la imagen de diskette'
	$(MCOPY) -o -i $(DISK_IMG) $(KERNEL_BIN) ::/
	@echo ''

$(DISK_IMG):
	@echo 'aca esta'
	bzip2 -dk $(DISK_IMG_BZ)
	@echo ''

clean:
	@echo 'Limpiando todo...'
	rm -f *.o
	rm -f *.bin
	rm -f *.tmp
	rm -f kernel.sym
	rm -f *.d
	rm -f $(DISK_IMG)
	rm -rf *~
	rm -f *.elf
	@echo ''

qemu: clean image
	qemu-system-i386 -s -S -drive format=raw,if=floppy,file=$(DISK_IMG) -daemonize

attach:
	gdb $(KERNEL_BIN).elf -ex "source orga2.py" -ex "target remote localhost:1234" -ex "set disassembly-flavor intel"

gdb: qemu attach
