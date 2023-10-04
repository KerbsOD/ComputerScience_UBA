global temperature_asm

section .data
mascaraAlpha: dw 0xFFFF, 0xFFFF, 0xFFFF, 0, 0xFFFF, 0xFFFF, 0xFFFF, 0

tres:    	   times 2 dq 3
treintaYdos:   times 4 dd 32
noventaYseis:  times 4 dd 96
cientosesenta: times 4 dd 160
dosdoscuatro:  times 4 dd 224

menor32:   dd 128, 0, 0, 255	; < 128 + t · 4, 0, 0 > 
menor96:   dd 255, 0, 0, 255 	; < 255, (t − 32) · 4, 0 >
menor160:  dd 255, 255, 0, 255	; < 255 − (t − 96) · 4, 255, (t − 96) · 4 >
menor224:  dd 0, 255, 255, 255	; < 0, 255 − (t − 160) · 4, 255 >
otherwise: dd 0, 0, 255, 255	; < 0, 0, 255 − (t − 224) · 4 >

section .text
;void temperature_asm(unsigned char *src,   [rdi]
;              unsigned char *dst,          [rsi]
;              int width,                   [rdx]
;              int height,                  [rcx]
;              int src_row_size,            [r8]
;              int dst_row_size);           [r9]

temperature_asm:
    push rbp
    mov  rbp, rsp    
	push r12						; No volatil.
	push r13						; No volatil.
	push rdi						; No volatil.
	push rsi						; No volatil.

    xor r10, r10    				; Representa al iterador de columnas i.
    xor r11, r11    				; Representa al iterador de filas j.
	mov rax, rsi					; rax se va a mantener en la primer columna.

	movdqu   xmm0, [mascaraAlpha]	; | 11111111 | 111111111 | 111111111 | 00000000 | 111111111 | 111111111 | 111111111 | 00000000 | 
	movdqu   xmm1, [tres]			; | 3 | 3 | 
	

.matrixLoop:
	pmovzxbw xmm2, [rdi]			; Muevo los primeros dos pixeles con extension de 0s a word.
	pand     xmm2, xmm0				; Pongo alpha en 0 en ambos pixeles.
	phaddw   xmm2, xmm2				; | P1b + P1g | P1r + 0 | P2b + P2g | P2r + 0 | (P: Pixel, b: blue, g: green, r: red)
	pmovzxwd xmm2, xmm2				; Muevo los primeros 2 pixeles con extension de 0s a dobleword. No quiero perder precision.
	phaddd   xmm2, xmm2				; | (P1b + P1g) + (P1r + 0) | (P2b + P2g) + (P2r + 0) |
	pmovzxdq xmm2, xmm2				; Muevo los primeros 2 pixeles con extension de 02 a quadword. No quiero perder precision.
	divpd    xmm2, xmm1				; Divido ambos double-precision por 3.

	cvttpd2dq xmm2, xmm2			; Convierto de doble precision a int truncado.
	pmovzxdq  xmm2, xmm2			; Extiendo con 0s de doubleword a quadraword cada t.

	movq xmm3, xmm2					; Guardo en xmm3 el t del primer pixel.
	xor r12, r12					; La cantidad de pixeles procesados (empieza en 0).
	
.procesarPixeles:
	extractps r13, xmm3, 0			; Extraigo el t a el registro r13.

	cmp r13, 32						; Si t no es mayor a 32.
	jng .TmenorA32
	
	cmp r13, 96						; Si t no es mayor a 96.
	jng .TmenorA96
	
	cmp r13, 160					; Si t no es mayor a 160.
	jng .TmenorA160
	
	cmp r13, 224					; Si t no es mayor a 224.
	jng .TmenorA224

	jmp .TmayorA224					; Otherwise

.TmenorA32:
	movdqu   xmm5, [menor32]		; Cargo la mascara de menor a 32.
	insertps xmm3, xmm3, 00001110b	; Muevo el t a la primera posicion del registro.

	pslld  xmm3, 2					; Multiplico t por 4.
	paddd  xmm3, xmm5			    ; Le sumo la mascara de menor a 32.
	
	packssdw xmm3, xmm3				; Desempaquetamos de dobleword a word.
	packuswb xmm3, xmm3				; Desempaquetamos de word a byte. Los primeros 4 bytes de xmm3 son el resultado.
	
	jmp .finProcesamientoDelPixel

.TmenorA96:
	movdqu xmm5, [menor96]			; Cargo la mascara de menor a 96.
	movdqu xmm6, [treintaYdos]		; Cargo el numero 32 dobleword en xmm6.
	
	psubd    xmm3, xmm6				; Hago t-32. | 0-32 | 0-32 | 0-32 | t-32|
	insertps xmm3, xmm3, 00011101b	; Muevo el t-32 a la segunda posicion y pongo el resto en 0.|0|0|t-32|0|.
	pslld    xmm3, 2					; Multiplico todo por 4.
	paddd    xmm3, xmm5				; Sumo a la mascara. |0|(t-32)*4|255|255|. (recordar que los xmm se leen al revez).

	packssdw xmm3, xmm3				; Desempaquetamos de dobleword a word.
	packuswb xmm3, xmm3				; Desempaquetamos de word a byte. Los primeros 4 bytes de xmm3 son el resultado.

	jmp .finProcesamientoDelPixel

.TmenorA160:
	movdqu xmm5, [menor160]			; Cargo la mascara de menor a 160.
	movdqu xmm6, [noventaYseis]		; Cargo el numero 96 doblword en xmm6.

	psubd  	 xmm3, xmm6				; Hago t-96
	insertps xmm3, xmm3, 00101010b  ; Muevo el t-96 a la primera posicion y a la anteultima. Pongo todo el resto en 0.
	pslld    xmm3, 2				; Multiplico todo por 4.

	psubd    xmm5, xmm3 			; |255-(t-96)*4|255-0|0-(t-96)*4|255-0|
	insertps xmm3, xmm3, 00101011b	; Dejo en xmm3 solo el tercer (t-96)*4. |0|0|(t-96)*4|0|
	paddd	 xmm5, xmm3				; |255-(t-96)*4 + 0|255 + 0|-(t-96)*4 + (t-96)*4|255 + 0|
	paddd	 xmm5, xmm3				; |255-(t-96)*4 + 0|255+0|(t-96)*4|255 + 0|
	
	movdqa 	 xmm3, xmm5				; xmm3 = xmm5.

	packssdw xmm3, xmm3				; Desempaquetamos de dobleword a word.
	packuswb xmm3, xmm3				; Desempaquetamos de word a byte. Los primeros 4 bytes de xmm3 son el resultado.

	jmp .finProcesamientoDelPixel

.TmenorA224:
	movdqu xmm5, [menor224]			; Cargo la mascara de menor a 224.
	movdqu xmm6, [cientosesenta]	; Cargo el numero 160 doblword a xmm6.

	psubd    xmm3, xmm6				; Hago t-160. |t-160|0|0|0
	insertps xmm3, xmm3, 00011101b	; Muevo t-160 a la segunda posicion. |0|t-160|0|0
	pslld    xmm3, 2				; Multiplico todo por 4.
	psubd    xmm5, xmm3				; |255 - 0|255-(t-160)*4|0-0|255-0|

	movdqa   xmm3, xmm5				; xmm3 = xmm5

	packssdw xmm3, xmm3				; Desempaquetamos de dobleword a word.
	packuswb xmm3, xmm3				; Desempaquetamos de word a byte. Los primeros 4 bytes de xmm3 son el resultado.
	
	jmp .finProcesamientoDelPixel

.TmayorA224:
	movdqu xmm5, [otherwise]		; Cargo la mascara de mayor/igual a 224.
	movdqu xmm6, [dosdoscuatro]		; Cargo el numero 224 dobleword a xmm6.

	psubd    xmm3, xmm6				; Hago t-224. |t-224|0-224|0-224|0-224|
	insertps xmm3, xmm3, 00101011b 	; Muevo t-224 a la tercera posicion. |0|0|t-224|0|
	pslld    xmm3, 2				; Multiplico todo por 4.
	psubd    xmm5, xmm3				; |0-0|0-0|255-(t-224)*4|255-0|

	movdqa   xmm3, xmm5				; xmm5 = xmm3

	packssdw xmm3, xmm3				; Desempaquetamos de dobleword a word.
	packuswb xmm3, xmm3				; Desempaquetamos de word a byte. Los primeros 4 bytes de xmm3 son el resultado.

	jmp .finProcesamientoDelPixel

.finProcesamientoDelPixel:
	movd [rsi], xmm3			; Cargo en la matriz dst el pixel. (4 bytes, 32 bits, doubleword)

	add r12, 1					; Aumentamos r12 en 1 porque procesamos 1 pixel.
	add rdi, 4					; Avanzo el iterador 1 pixel (4 bytes).
	add rsi, 4					; Avanzo el iterador 1 pixel (4 bytes).
	add r10, 1					; Avanzo el iterador i 1 pixel.
	
	shufpd xmm2, xmm2, 01		; Swapeamos los t de los pixeles de lugar.
	movq xmm3, xmm2				; Cargamos el segundo pixel a xmm3.

	cmp r12, 2					; Si r12 es diferente de 2. Procesar el siguiente pixel.
	jne .procesarPixeles

	cmp r10, rdx				; Si i es igual al largo entonces salto de fila. Otherwise itero nuevamente.
	jne .matrixLoop

	xor r10, r10				; Reseteo el iterador i a 0.
	add r11, 1					; Aumento en 1 el iterador j.
	add rax, r9					; RAX salta a la siguiente fila de la columna 0.
	mov rdi, rax				; RDI salta a la siguiente fila de la columna 0.
	mov rsi, rax				; RSI salta a la siguiente fila de la columna 0.

	cmp r11, rcx				; Si el iterador j es igual a la cantidad de filas, terminé.
	jne .matrixLoop

.finTemperatura:
	pop rsi
	pop rdi
	pop r13
	pop r12
    pop rbp
    ret