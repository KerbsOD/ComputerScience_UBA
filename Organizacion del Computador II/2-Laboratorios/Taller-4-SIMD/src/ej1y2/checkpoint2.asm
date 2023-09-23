
section .text

global checksum_asm

; uint8_t checksum_asm(void* array [rdi], uint32_t n [rsi])

checksum_asm:
    push rbp
    mov rbp, rsp

.ciclo:
    pmovzxwd xmm0, [rdi]	; copio los primeros 4 valores word de a, a doblewords entendidos con ceros
    add 	 rdi, 8			; avanzo el puntero
    pmovzxwd xmm1, [rdi]	; copio los siguientes 4 valores word de a, a doblewords entendidos con ceros
    add 	 rdi, 8			; avanzo el puntero

    pmovzxwd xmm2, [rdi]	; copio los primeros 4 valores word de b, a doblewords entendidos con ceros
    add 	 rdi, 8			; avanzo el puntero
    pmovzxwd xmm3, [rdi]	; copio los siguientes 4 valores word de b, a doblewords entendidos con ceros
    add 	 rdi, 8			; avanzo el puntero

    movdqu xmm4, [rdi]		; copio los primeros 4 valores doubleword de c
    add    rdi, 16			; avanzo el puntero
    movdqu xmm5, [rdi]		; copio los siguientes 4 valores doubleword de c,
    add    rdi, 16			; avanzo el puntero

    paddd xmm0, xmm2		; sumo los primeros 4 a y b; a lo sumo ocupa 17 bits la suma
    pslld xmm0, 3			; 3 shifts a la izquierda para cada packed es lo mismo que multiplicar por 8, no hay riesgo de saturar
    paddd xmm1, xmm3		; sumo los siguientes a y b
    pslld xmm1, 3			; 3 shifts a la izquierda

    pcmpeqd xmm0, xmm4		; comparo el resultado de (a + b)*8 con c
    pcmpeqd xmm1, xmm5		; comparo el resultado de (a + b)*8 con c

    phaddd xmm0, xmm1		; | 0 + 1 | 2 + 3 | 4 + 5 | 6 + 7 |
    movdqa xmm1, xmm0		; lo copio

    phaddd xmm0, xmm1		; | 0 + 1 + 2 + 3 | 4 + 5 + 6 + 7 | 0 + 1 + 2 + 3 | 4 + 5 + 6 + 7 |
    movdqa xmm1, xmm0

    phaddd xmm0, xmm1		; | 0 + 1 + 2 + 3 + 4 + 5 + 6 + 7 | ... | ... | ... |

    xor    rax, rax
    pextrd eax, xmm0, 0		; tomo el primer valor

    cmp eax, -8
    jne .devolverCero

    sub rsi, 1
    jnz .ciclo

    xor rax, rax
    inc rax
    jmp .fin

.devolverCero:
    xor rax, rax

.fin:
    pop rbp
	ret
