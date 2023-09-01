

########### ESTOS SON LOS OFFSETS Y TAMAÑO DE LOS STRUCTS
Completar:
NODO_LENGTH	EQU	??
LONGITUD_OFFSET	EQU	??

PACKED_NODO_LENGTH	EQU	??
PACKED_LONGITUD_OFFSET	EQU	??

;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;########### LISTA DE FUNCIONES EXPORTADAS
global cantidad_total_de_elementos
global cantidad_total_de_elementos_packed

;########### DEFINICION DE FUNCIONES
;extern uint32_t cantidad_total_de_elementos(lista_t* lista);
;registros: lista[?]
cantidad_total_de_elementos:
	ret

;extern uint32_t cantidad_total_de_elementos_packed(packed_lista_t* lista);
;registros: lista[?]
cantidad_total_de_elementos_packed:
	ret

