section .data
    vector:   dd  10, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16

section .text
    global Ejercicio2
    
Ejercicio2:
    push rbp
    mov rbp, rsp
    ; ALINEADO

    mov rdi, vector
    mov rcx, 16                 ; Son 16 elementos. De 32 bits.
    xor rax, rax                ; Limpio eax. Quiero los numeros de 32 bits.
    xorpd xmm0, xmm0

    .iterar:
        mov r8, rax             ; Guardo un backup de rax.
        mov esi, [rdi]          ; Mueve los primeros 32 bits y pone todo el resto en 0.
        add rax, rsi            ; Sumo el valor en la iesima posicion al acumulador.
    
        add rdi, 4              ; Avanzo 4 bytes (32 bits).
        dec rcx                 ; Decremento en 1 el contador.

        jo .huboOverflow

        cmp rcx, 0              ; Si rcx es diferente de 0. Terminar.
        jne .iterar

        jmp .fin
    
    .huboOverflow:
        cvtsi2sd xmm1, r8       ; Guardo el valor previo de rax.
        addpd xmm0, xmm1        ; Lo sumo a xmm0.
        xor rax, rax            ; Limpio rax.
        add rax, rsi            ; Sumo el valor.

        cmp rcx, 0              ; Si rcx es diferente de 0. Terminar.
        jne .iterar

    .fin:
        cvtsi2sd xmm1, rax
        addpd xmm0, xmm1

        pop rbp
        ret


; int main(void) {
;     double suma = Ejercicio2();
;     printf("Suma: %lf", suma);
; }