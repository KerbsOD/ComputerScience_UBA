;########### LISTA DE FUNCIONES IMPORTADAS
extern print_stack_from_a_to_b

;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;########### LISTA DE FUNCIONES EXPORTADAS
global stack_snooper
global stack_snooper_n

;void stack_snooper();
stack_snooper:
    push rbp
    mov rbp, rsp
    mov rdi, rbp   
    mov rsi, [rbp] 
    call print_stack_from_a_to_b wrt ..plt
    pop rbp
    ret

;void stack_snooper_n(int n);
stack_snooper_n:
    push rbp
    mov rbp, rsp

    mov rcx, rdi
    mov rdi, rbp   
    mov rsi, [rbp] 
    .for:
        mov rsi, [rsi]
        dec rcx
        jnz .for
        
	call print_stack_from_a_to_b wrt ..plt

    pop rbp
    ret

