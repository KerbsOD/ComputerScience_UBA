section .data
    vector:   dq  10, 2, 3, 4, 5, 6, 7, 8, 9, 11, 11, 12, 13, 14, 15, 16

section .text
    global Ejercicio4
    
Ejercicio4:
    push rbp
    mov rbp, rsp

    push qword [vector+0x78]
    push qword [vector+0x70]
    push qword [vector+0x68]
    push qword [vector+0x60]
    push qword [vector+0x58]
    push qword [vector+0x50]
    push qword [vector+0x48]
    push qword [vector+0x40]
    push qword [vector+0x38]
    push qword [vector+0x30]
    push qword [vector+0x28]
    push qword [vector+0x20]
    push qword [vector+0x18]
    push qword [vector+0x10]
    push qword [vector+0x8]
    push qword [vector+0x0]
    
    mov rcx, 16
    xor rax, rax

    .iterar:
        pop r10
        add rax, r10

        dec rcx
        cmp rcx, 0
        jne .iterar
    
    pop rbp
    ret