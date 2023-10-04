section .data
    vector:   dq  10, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16

section .text
    global Ejercicio3
    
Ejercicio3:
    push rbp
    mov rbp, rsp
    push rdi
    push rsi
    push r12
    push r13
    push r14
    push r15

    ; 8 bytes = 64 bits
    mov rdi, [vector]
    mov rsi, [vector+0x8]     
    mov rcx, [vector+0x10]
    mov rdx, [vector+0x18]
    mov r8,  [vector+0x20]
    mov r9,  [vector+0x28]
    mov r10, [vector+0x30]
    mov r11, [vector+0x38]
    mov r12, [vector+0x40]
    mov r13, [vector+0x48]
    mov r14, [vector+0x50]
    mov r15, [vector+0x58]

    push qword [vector+0x78]
    push qword [vector+0x70]
    push qword [vector+0x68]
    push qword [vector+0x60]
    
    xor rax, rax
    add rax, rdi
    add rax, rsi
    add rax, rcx
    add rax, rdx
    add rax, r8
    add rax, r9
    add rax, r10
    add rax, r11
    add rax, r12
    add rax, r13
    add rax, r14
    add rax, r15
    
    pop rdi
    add rax, rdi

    pop rdi
    add rax, rdi
    
    pop rdi
    add rax, rdi

    pop rdi
    add rax, rdi

    pop r15
    pop r14
    pop r13
    pop r12
    pop rdi
    pop rsi
    pop rbp
    ret