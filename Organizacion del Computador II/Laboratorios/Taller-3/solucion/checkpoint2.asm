extern sumar_c
extern restar_c
;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text


;########### LISTA DE FUNCIONES EXPORTADAS

global alternate_sum_4
global alternate_sum_4_simplified
global alternate_sum_8
global product_2_f
global alternate_sum_4_using_c
global product_9_f

;########### DEFINICION DE FUNCIONES
; uint32_t alternate_sum_4(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; registros: x1[RDI], x2[RSI], x3[RDX], x4[RCX]
alternate_sum_4:
	;prologo
	; COMPLETAR
	push rbp	  ; Guardo el rbp de la funcion llamadora 
	mov rbp, rsp  ; Ahora el rsp va a ser el rbp de la funcion alternate_sum_4
	sub rsp, 8    ; Dejamos 64 bits alineados a 16
	
	sub rdi, rsi
	sub rdx, rcx
	add rdi, rdx

	mov rax, rdi

	;recordar que si la pila estaba alineada a 16 al hacer la llamada
	;con el push de RIP como efecto del CALL queda alineada a 8

	;epilogo
	; COMPLETAR
	add rsp, 8
	pop rbp    ; guarda el valor del stack frame ANTERIOR, el de la funcion llamadora.
	ret

; uint32_t alternate_sum_4_using_c(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; registros: x1[rdi], x2[rsi], x3[rdx], x4[rcx]
; Cuando se llama a 'alternate_sum_4_using_c' se guarda  x1[rdi], x2[rsi], x3[rdx], x4[rcx]
alternate_sum_4_using_c:
	;prologo
	push rbp 	; alineado a 16
	mov rbp,rsp 

	call restar_c
	push rax	; Pusheamos el valor de 'restar_c' al stack 
	; DESALINEADO
	sub rsp, 8  ; Alineamos el stack a 16 bytes para las llamadas a las funciones de C.	
	; ALINEADO

	mov rdi, rdx	
	mov rsi, rcx
	call restar_c

	mov rdi, rax
	add rsp, 8	; Volvlemos a donde pusheamos rax para poder guardarlo en rsi.
	; DESALINEADO
	pop rsi     
	; ALINEADO
	call sumar_c
	
	;epilogo
	pop rbp
	ret

; uint32_t alternate_sum_4_simplified(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; registros: x1[rdi], x2[rsi], x3[rdx], x4[rcx]
alternate_sum_4_simplified:
	call restar_c
	mov r10, rax	; guardamos en r10 el valor de retorno de restar_c

	mov rdi, rdx	; x3 esta en rdx pero restar_c solo toma rdi y rsi
	mov rsi, rcx	; x4 esta en rcx pero restar_c solo toma rdi y rsi
	call restar_c

	mov rdi, rax	; guardamos en rdi el valor de retorno de restar_c
	mov rsi, r10    ; guardamos en rsi el valor de retorno de la primera vez que llamamos a restar_c
	call sumar_c

	ret

; uint32_t alternate_sum_8(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4, uint32_t x5, uint32_t x6, uint32_t x7, uint32_t x8);
; registros y pila: x1[rdi], x2[rsi], x3[rdx], x4[rcx], x5[r8], x6[r9], x7[rbp + 0x10], x8[rbp + 0x18]
alternate_sum_8:
	;prologo
	push rbp
	mov  rbp, rsp
	
	; COMPLETAR
	
	call alternate_sum_4_simplified
	push rax					; Guardo el resultado en el stack.
	;DESALINEADO
	sub rsp, 0x8
	;ALINEADO

	mov rdi, r8
	mov rsi, r9
	mov rdx, [rbp+0x10]
	mov rcx, [rbp+0x18]
	call alternate_sum_4_simplified

	add rsp, 0x8
	;DESALINEADO
	pop rdi
	;ALINEADO
	add rax, rdi

	;epilogo
	pop rbp
	ret


; SUGERENCIA: investigar uso de instrucciones para convertir enteros a floats y viceversa
;void product_2_f(uint32_t * destination, uint32_t x1, float f1);
;registros: destination[rdi], x1[rsi], f1[XMM0]
product_2_f:
	push rbp
	mov rbp, rsp

	cvtsi2ss xmm1, rsi	  ; Convierto int to single
	
	mulss xmm0, xmm1	  ; Multiplicamos los singles
	
	cvttss2si rsi, xmm0   ; Convierto el single a int

	mov [rdi], esi        ; Muevo el valor a la direccion que me pasaron

	pop rbp
	ret

;extern void product_9_f(uint32_t * destination
;, uint32_t x1, float f1, uint32_t x2, float f2, uint32_t x3, float f3, uint32_t x4, float f4
;, uint32_t x5, float f5, uint32_t x6, float f6, uint32_t x7, float f7, uint32_t x8, float f8
;, uint32_t x9, float f9);
;registros y pila: destination[rdi], x1[rsi], f1[xmm0], x2[rdx], f2[xmm1], x3[rcx], f3[xmm2], x4[r8], f4[xmm3]
;	, x5[r9], f5[xmm4], x6[rbp + 0x10], f6[xmm5], x7[rbp + 0x18], f7[xmm6], x8[rbp + 0x20], f8[xmm7],
;	, x9[rbp + 0x28], f9[rbp + 0x30]
product_9_f:
	;prologo
	push rbp
	mov rbp, rsp

	mov r10,  [rbp+0x10]
	mov r11,  [rbp+0x18]
	mov r12,  [rbp+0x20]
	mov r13,  [rbp+0x28]
	movss xmm8, [rbp+0x30]

	;convertimos los flotantes de cada registro xmm en doubles
	; COMPLETAR
	cvtss2sd xmm0, xmm0
	cvtss2sd xmm1, xmm1
	cvtss2sd xmm2, xmm2
	cvtss2sd xmm3, xmm3
	cvtss2sd xmm4, xmm4
	cvtss2sd xmm5, xmm5
	cvtss2sd xmm6, xmm6
	cvtss2sd xmm7, xmm7
	cvtss2sd xmm8, xmm8

	;multiplicamos los doubles en xmm0 <- xmm0 * xmm1, xmmo * xmm2 , ...
	; COMPLETAR
	mulsd xmm0, xmm1
	mulsd xmm0, xmm2
	mulsd xmm0, xmm3
	mulsd xmm0, xmm4
	mulsd xmm0, xmm5
	mulsd xmm0, xmm6
	mulsd xmm0, xmm7
	mulsd xmm0, xmm8

	; convertimos los enteros en doubles y los multiplicamos por xmm0.
	; COMPLETAR
	cvtsi2sd xmm1, rsi
	cvtsi2sd xmm2, rdx
	cvtsi2sd xmm3, rcx
	cvtsi2sd xmm4, r8
	cvtsi2sd xmm5, r9
	cvtsi2sd xmm6, r10
	cvtsi2sd xmm7, r11
	cvtsi2sd xmm8, r12
	cvtsi2sd xmm9, r13

	mulsd xmm0, xmm1
	mulsd xmm0, xmm2
	mulsd xmm0, xmm3
	mulsd xmm0, xmm4
	mulsd xmm0, xmm5
	mulsd xmm0, xmm6
	mulsd xmm0, xmm7
	mulsd xmm0, xmm8
	mulsd xmm0, xmm9

	movsd [rdi], xmm0

	; epilogo
	pop rbp
	ret


