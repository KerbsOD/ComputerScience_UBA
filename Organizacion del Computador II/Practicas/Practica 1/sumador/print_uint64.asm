global print_uint64

; Lógica para poder imprimir uints de 64 bits
table:
    db '0123456789ABCDEF'
UINT64_STRING_SIZE EQU 20
print_uint64:
    sub rsp, UINT64_STRING_SIZE

    ; Máximo offset desde el comienzo del string
    mov rax, UINT64_STRING_SIZE - 1
    mov BYTE [rsp+rax], 0
    dec rax
    mov BYTE [rsp+rax], 10 ; \n
    dec rax

    mov rcx, 16
    .loop:
        mov rsi, rdi
        and rsi, 0b1111
        mov sil, [table+rsi]
        mov [rsp+rax], sil
        dec rax
        shr rdi, 4
    loop .loop

    mov BYTE [rsp+rax], 'x'
    dec rax
    mov BYTE [rsp+rax], '0'
    dec rax

    mov rax, 1
    mov rdi, 1
    mov rsi, rsp
    mov rdx, 20
    syscall

    add rsp, UINT64_STRING_SIZE
    ret