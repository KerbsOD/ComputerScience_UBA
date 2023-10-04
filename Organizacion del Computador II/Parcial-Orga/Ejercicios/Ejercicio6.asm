section .text
    global Ejercicio6   

extern calloc
extern strlen

Ejercicio6:
    ; rdi = char* s
    ; rsi = int x
    push rbp
    mov  rbp, rsp

    push rdi        ; Guardo la direccion de s en el stack.
    push rsi        ; Guardo x en el stack.

    call strlen     ; Me da en rax la longitud de s.
    inc rax         ; Sumo 1 por el '\0'.

    push rax        ; Guardo en el stack la cantida de eleemntos.
    sub rsp, 8      ; Alineo a 16 bytes

    mov rdi, rax    ; Muevo en rdi la cantidad de elementos a poner en 0 (s+1).
    mov rsi, rax    ; Muevo en rsi los bytes que ocupan;
    call calloc
    mov r8, rax     ; Muevo a r8 la direccion de esta tira de 0s.

    add rsp, 8
    pop rcx         ; Guardo en rcx la cantidad de eleementos.

    pop rsi         ; Guardo en rsi x.
    pop rdi         ; Guardo en rdi la direccion de s.

    .iterar:
        mov dl, [rdi]   ; Muevo a rdx la letra.
        mov [rax], dl   ; Muevo a la nueva direccion la letra.

        add rdi, 1
        add rax, 1
        sub rcx, 1
        jne .iterar

    .fin:
    mov rax, r8
    pop rbp
    ret



