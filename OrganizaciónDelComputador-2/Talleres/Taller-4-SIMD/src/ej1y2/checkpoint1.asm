global invertirQW_asm

section .data
uno: times 16 db 1

section .text



; void invertirQW_asm(uint64_t* p)

invertirQW_asm:
    push rbp
    mov rbp, rsp

    ; movdqu xmm0, [rdi]

    ; shufpd xmm0, xmm0, 01
    ; movdqu [rdi], xmm0

    ;===== Algoritmo =====;
	mov rax, rsi			; Cargo en rax la direccion de dst.
	xorps xmm12, xmm12		; Seteo una mascara con todos 0s.
	xor r10, r10			; Va a ser mi iterador i. Representa a rdx.
	xor r11, r11			; Va a ser mi iterador j. Representa a rcx.
	
	movdqu   xmm9, [uno]
	pmovsxbd xmm9, xmm9
	 	


    pop rbp
	ret
