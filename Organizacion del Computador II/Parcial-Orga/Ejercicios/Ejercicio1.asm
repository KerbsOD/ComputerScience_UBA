section .data
vector:   dd  1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16

section .text
    global Ejercicio1
    
Ejercicio1:
    push rbp
    mov rbp, rsp
    ; ALINEADO

    mov rdi, vector
    mov rcx, 16                 ; Son 16 elementos. De 32 bits.
    xor eax, eax                ; Limpio eax. Quiero los numeros de 32 bits.

    .iterar:
        add eax, [rdi]          ; Sumo el valor en la iesima posicion al acumulador.
        
        add rdi, 4              ; Avanzo 4 bytes (32 bits).
        dec rcx                 ; Decremento en 1 el contador.
        
        cmp rcx, 0              ; Si rcx es diferente de 0. Terminar.
        jne .iterar
    
fin:
    pop rbp
    ret




; int main(void) {
;     int32_t* vector = malloc(sizeof(int32_t) * 16);
;     for (int32_t i = 0; i < 16; i++) {
;         vector[i] = i;
;     }

;     int64_t suma = Ejercicio1();
;     printf("Suma: %d", suma);
; }