# ** por compatibilidad se omiten tildes **
# ==============================================================================
# TALLER System Programming - ORGANIZACION DE COMPUTADOR II - FCEN
# ==============================================================================

MCOPY=mcopy

KERNEL_SRC=kernel.asm
KERNEL_OBJ=kernel.o
KERNEL_BIN=kernel.bin

OBJ=$(KERNEL_OBJ) gdt.o screen.o idt.o isr.o pic.o keyboard_input.o mmu.o tss.o sched.o tasks.o

# Dependencias, generado por el flag -MMD de gcc, util para recompilar cuando actualizamos headers.
DEP=$(OBJ:%.o=%.d)
DISK_IMG=diskette.img
DISK_IMG_BZ=diskette.img.bz2


CFLAGS=-Wall -Wextra -pedantic -std=c99 -Og -ggdb \
  -m32 -march=i386 -ffreestanding -fno-pie -fno-zero-initialized-in-bss -fno-stack-protector


TASKSCFLAGS=$(CFLAGS) -DORGA2__TAREA__

TASKIDLE=idle.tsk
TASKA=taskPong.tsk
TASKB=taskSnake.tsk

TASKS=tareas.tsk

TASKSBINS=$(TASKIDLE) $(TASKA) $(TASKB)

CODESIZE=$$((0x18000 - 0x1200))
TASKSSIZE=$$((2 * (0x1000) * 2 + 0x1000)) # Dos tareas de 2 paginas + 1 pagina idle.
KERNELSIZE=$$(($(CODESIZE)+$(TASKSSIZE)))

# Direccion virtual donde empieza el codigo de las tareas.
TASKSTARTADDR=0x08000000

CC=gcc
NASM=nasm
NASMFLAGS=-felf32 -g -F DWARF
OBJCOPY=objcopy
NM=nm
LD=ld
LDTASKFLAGS=-s -static -m elf_i386 --oformat binary -b elf32-i386 -e _start -Ttext $(TASKSTARTADDR)
LDFLAGS=-static -m elf_i386 -b elf32-i386 -e start -Ttext 0x1200

QUIET = @

.PHONY=clean all image tasks

all:  clean tasks image

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

kernel.bin: $(OBJ) tasks
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
	dd if=$(TASKS) of=kernel.bin bs=1 count=$(TASKSSIZE) seek=$(CODESIZE) conv=notrunc status=noxfer > /dev/null
	rm kernel.bin.tmp
	@echo ''

image: kernel.bin $(DISK_IMG)
	@echo 'Copiando el $(KERNEL_BIN) a la imagen de diskette'
	$(MCOPY) -o -i $(DISK_IMG) $(KERNEL_BIN) ::/
	@echo ''

$(DISK_IMG):
	bzip2 -dk $(DISK_IMG_BZ)

idle.tsk: idle.asm
	@echo 'Compilando tarea idle...'
	$(NASM) -fbin -o $@ $^
	@echo ''
	@echo 'Generando imagen de la tarea idle...'
	mv idle.tsk idle.tsk.tmp
	dd if=/dev/zero bs=1 count=4K of=$@ status=noxfer > /dev/null 2>&1
	dd if=$@.tmp bs=1 count=4K seek=0 conv=notrunc of=$@ status=noxfer > /dev/null 2>&1
	rm $@.tmp
	@echo ''

task%.tsko: tareas/task%.c
	$(CC) $(TASKSCFLAGS) -MMD -c -o $@ $^

%.tsk: tareas/task_prelude.o %.tsko
	@echo 'Linkeando tarea...'
	$(LD) $(LDTASKFLAGS) -o $@.tmp $^
	@echo ''
	mv $@.tmp $@

tasks: $(TASKSBINS)
	@echo 'Generando imagen de las tareas...'
	$(QUIET) dd if=/dev/zero   bs=1 count=$(TASKSSIZE) of=$(TASKS) status=noxfer > /dev/null 2>&1
	$(QUIET) dd if=$(TASKA)   bs=1 count=8K of=$(TASKS) seek=0K   status=noxfer > /dev/null 2>&1
	$(QUIET) dd if=$(TASKB)   bs=1 count=8K of=$(TASKS) seek=8K  status=noxfer > /dev/null 2>&1
	$(QUIET) dd if=$(TASKIDLE) bs=1 count=4K of=$(TASKS) seek=16K  status=noxfer > /dev/null 2>&1
	@echo ''

clean:
	@echo 'Limpiando todo...'
	rm -f *.o
	rm -f *.bin
	rm -f *.tmp
	rm -f kernel.sym
	rm -f *.tsko
	rm -f *.tsk
	rm -f *.d
	rm -f tareas/*.d
	rm -f $(DISK_IMG)
	rm -rf *~
	rm -f *.elf
	@echo ''


qemu: clean image
	qemu-system-i386 -s -S -drive format=raw,if=floppy,file=$(DISK_IMG) -daemonize

attach:
	gdb $(KERNEL_BIN).elf -ex "source orga2.py" -ex "target remote localhost:1234" -ex "set disassembly-flavor intel"

gdb: qemu attach
