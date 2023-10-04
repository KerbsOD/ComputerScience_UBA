

;########### ESTOS SON LOS OFFSETS Y TAMAÑO DE LOS STRUCTS
; Completar:
NODO_LENGTH	EQU	0x20 
LONGITUD_OFFSET	EQU	0x18

; 0x20 = 32 bytes. 0x0 a 0x8 a 0x10 a 0x18 a 0x20 
; (recordemos que la estructura esta alineada a 8 bytes por lo que los ultimso 4 bytes de longitud 
; se 'desperdician' tambien los 7 bytes de categoria).

; typedef struct nodo_s {
; 	struct nodo_s* next; ->	8bytes  PosicionEnMemoria-> 0x0
; 	uint8_t categoria;   -> 1byte   PosicionEnMemoria-> 0x8
; 	uint32_t* arreglo;   -> 8bytes  PosicionEnMemoria-> 0x10
; 	uint32_t longitud;   -> 4bytes  PosicionEnMemoria-> 0x18
; } nodo_t;			  

; Grafico
;	########	(next)
;   #			(categoria)
;   ########	(arreglo)
;   ####		(longitud)
; La estructura esta alineada a 8 bytes.
; En total se ocupan 4 bloques de 8bytes

PACKED_NODO_LENGTH	EQU	0x15
; 0x15 = 21 bytes. 0x0 a 0x8 a 0x9 a 0x11 a 0x15
PACKED_LONGITUD_OFFSET	EQU	0x11

; typedef struct __attribute__((__packed__)) packed_nodo_s {
; 	struct packed_nodo_s* next; -> 8bytes  PosicionEnMemoria-> 0x0
; 	uint8_t categoria; 			-> 1byte   PosicionEnMemoria-> 0x8
; 	uint32_t* arreglo; 			-> 8bytes  PosicionEnMemoria-> 0x9
; 	uint32_t longitud; 			-> 4bytes  PosicionEnMemoria-> 0xD
;} packed_nodo_t;

; Grafico
;	########	(next 8bytes)
;   ########    (categoria 1byte + arreglo 7bytes)
;   #####	    (arreglo 1byte + longitud 4bytes) 

;########### SECCION DE DATOS
section .data
;########### SECCION DE TEXTO (PROGRAMA)
section .text

;########### LISTA DE FUNCIONES EXPORTADAS
global cantidad_total_de_elementos
global cantidad_total_de_elementos_packed

;########### DEFINICION DE FUNCIONES
;extern uint32_t cantidad_total_de_elementos(lista_t* lista);
;registros: lista[rdi]
cantidad_total_de_elementos:
	push rbp
	mov  rbp, rsp
	; ALINEADO
	
	xor rax, rax			; Limpiamos rax para guardar aqui el resultado.
	mov qword rcx, [rdi]	; Guardamos en rcx la direccion de head.

	jrcxz fin			  	; Si head es NULL, terminamos la ejecucion. No hay nada que calcular.

iterar:
	add dword rax, [rcx + LONGITUD_OFFSET]	; Sumamos a rax la longitud del arreglo del nodo.		
	mov qword rcx, [rcx]					; Move la direccion a la que apunta next a rcx.
	jrcxz fin								; Si la direccion es 0, termina de iterar.

	jmp iterar								

fin:
	pop rbp
	ret

;extern uint32_t cantidad_total_de_elementos_packed(packed_lista_t* lista);
;registros: lista[rdi]
cantidad_total_de_elementos_packed:
	push rbp
	mov  rbp, rsp
	; ALINEADO
	
	xor rax, rax			; Limpiamos rax para guardar aqui el resultado.
	mov qword rcx, [rdi]	; Guardamos en rcx la direccion de head.

	jrcxz fin_packed		; Si head es NULL, terminamos la ejecucion. No hay nada que calcular.

iterar_packed:
	add dword eax, [rcx + PACKED_LONGITUD_OFFSET]	; Sumamos a rax la longitud del arreglo del nodo. 
													; Como le pedimos la parte baja cuando va en el bus no le importa		
	mov qword rcx, [rcx]							; Move la direccion a la que apunta next a rcx.
	jrcxz fin_packed								; Si la direccion es 0, termina de iterar.

	jmp iterar_packed								

fin_packed:
	pop rbp
	ret

