; ==============================================================================
; TALLER System Programming - ORGANIZACION DE COMPUTADOR II - FCEN
; ==============================================================================

ORG 0x0001C000 ; TASK_IDLE_CODE

BITS 32

idle: jmp idle
