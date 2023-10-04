section .text
    global Ejercicio5

Ejercicio5:
    push rbp
    mov  rbp, rsp

    mov rdi, 5
    call invocada       

    pop rbp
    ret

invocada:
    push rbp
    mov  rbp, rsp

    mov rax, [rbp+0x8] 
    add rax, rdi   

    pop rbp
    ret

