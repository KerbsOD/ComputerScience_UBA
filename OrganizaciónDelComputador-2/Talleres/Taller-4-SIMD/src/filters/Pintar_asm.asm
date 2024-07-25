section .rodata
blanco: times 16 db 255
negro: db 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255

section .text
global Pintar_asm

;void Pintar_asm(unsigned char *src,    rdi
;              unsigned char *dst,      rsi
;              int width,               rdx
;              int height,              rcx
;              int src_row_size,        r8
;              int dst_row_size);       r9

Pintar_asm:
	push rbp
	mov  rbp, rsp

	mov rdi, rsi					; Guardo referencia de la primer columna.
	xor r10, r10					; Indice de i.
	xor r11, r11					; Indice de j.
	movdqu xmm0, [blanco]			; Cargo el color blanco en el registro xmm0.
	movdqu xmm1, [negro]			; Cargo el color negro en el registro xmm1.

	movdqa  xmm2, xmm0				; Cargo el color blanco en el registro xmm2.
	movdqa  xmm3, xmm0				; Cargo el color blanco en el registro xmm3.
	pblendw xmm2, xmm1, 00001111b	; 2 pixeles negros. 2 pixeles blancos.	
	pblendw xmm3, xmm1, 11110000b	; 2 pixeles blancos. 2 pixeles negros.

	push r12						; R12 es no volatil.
	mov  r12, rcx					; Guardo en R12 la altura total.
	sub  r12, 2						; Le resto 2 pixeles a la altura total.
	mov  rax, rdx					; Es una herramienta misteriosa que nos ayudará mas tarde.
	sub  rax, 4						; Juju

	jmp .llenarConNegro
			
.negroIzquierdo:
	movdqu [rsi], xmm2				; Cargo 2 pixeles negros y 2 blancos al inicio.
	add rsi, 16						; Avanzo 4 pixeles (16 byte).
	add r10, 4						; Avanzo 4 pixeles.

.llenarConBlanco:
	movdqu [rsi], xmm0				; Pinto 4 pixeles con blanco.
	add rsi, 16						; Avanzo 4 pixeles (16 bytes).
	add r10, 4						; Avanzo 4 pixeles.

	cmp r10, rax					; Si i no es igual al ancho total-4pixeles (borde derecho), volve a ejecutar.
	jne .llenarConBlanco

.negroDerecho:
	movdqu [rsi], xmm3				; Cargo 2 pixeles blancos y 2 negros al final.

	xor r10, r10					; Reseteo el indice i a 0.
	add r11, 1						; Aumento en 1 el indice j.
	add rdi, r9						; RDI salta a la siguiente fila en la columna 0.
	mov rsi, rdi					; RSI salta a la siguiente fila en la columna 0.

	cmp r11, r12					; Si j es diferente a la altura total menos 2 pixeles, vuelvo a iterar sobre la siguiente fila.
	jne .negroIzquierdo
	
.llenarConNegro:
	movdqu [rsi], xmm1				; Pintamos con negro.
	add rsi, 16						; Avanzamos 4 pixeles (16 bytes).
	add r10, 4						; Avanzamos 4 pixeles.

	cmp r10, rdx					; Si i no es igual al ancho total, volve a ejecutar.
	jne .llenarConNegro

	xor r10, r10					; Reseteo el indice i a 0.
	add r11, 1						; Aumento en 1 el indice j.
	add rdi, r9						; RDi salta a la siguiente fila en la columna 0.
	mov rsi, rdi					; RSI salta a la siguiente fila en la columna 0.

	cmp r11, rcx					; Si j es igual al alto total, terminé.
	je .finPintar

	cmp r11, 2						; Si j no es igual a 2 volvé a ejecutar.
	jne .llenarConNegro	

	jmp .negroIzquierdo				; Si no estoy ni en las primeras 2 filas ni las ultimas 2. Salto a rellenar con negro los bordes y blanco el centro.

.finPintar:
	pop r12
	pop rbp
	ret
