#!/usr/bin/env bash
nasm -f elf64 -g -F DWARF Ejercicio6.asm 
gcc Res/main.c Ejercicio6.o -o Res/programa -z noexecstack -no-pie
rm -f *.o
echo 
./Res/programa

echo