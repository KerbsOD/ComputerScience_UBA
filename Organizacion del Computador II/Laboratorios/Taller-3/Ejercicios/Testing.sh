#!/bin/bash
echo nasm -f elf64 checkpoint2.asm -o checkpoint2_ASM.o
nasm -f elf64 checkpoint2.asm -o checkpoint2ASM.o

echo gcc -c -m64 main.c -o main.o 
gcc -c -m64 main.c -o main.o

echo gcc -o ejec -m64 main.o checkpoint2ASM.o
gcc -o ejec -m64 main.o checkpoint2ASM.o

echo
./ejec