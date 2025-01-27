section .text

global contar_pagos_aprobados_asm
global contar_pagos_rechazados_asm

global split_pagos_usuario_asm

extern malloc
extern free
extern strcmp


;########### SECCION DE TEXTO (PROGRAMA)

; uint8_t contar_pagos_aprobados_asm(list_t* pList, [rdi]
;                                    char* usuario  [rsi]
;);
contar_pagos_aprobados_asm:
    push rbp
    mov  rbp, rsp
    push r12                ; Guardo los no volatiles en el stack.
    push r13                ; Como voy a llamar a cmpstr, necesito saber que estos no seran modificados.
    push r14                ; Por lo tanto uso r12-14 para guardar mis parametros.
    push r15
    ; Alineado

    mov r12, [rdi]          ; Guardo la direccion de first en r12.
    xor r13, r13            ; Inicializo mi contador en 0.
    mov r14, rsi            ; Guardo el nombre de usuario.

    .loopContar:        
        cmp r12, 0          ; Si first == NULL. Termino.
        je .fin
        
        mov r15,  [r12]     ; Guardamos la direccion de data en r15.
        mov rdi,  [r15+16]  ; Guardamos el nombre del cobrador en rdi. Al ser unpacked tenemos que movernos 16 bytes.
        mov rsi,  r14       ; Guardamos el nombre de usario en rsi.
        call strcmp         ; Ejecutamos strcmp
        cmp rax, 0
        jne .siguiente      ; Si no es nuestro usuario, saltamos al siguiente elemento.

        add r13b, [r15+1]   ; Sumamos el segundo byte de data (aprobado)

    .siguiente:
        mov r12, [r12 + 8]  ; Salto a next 
        jmp .loopContar
    
    .fin:
    mov rax, r13
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbp
    ret


; uint8_t contar_pagos_rechazados_asm(list_t* pList, char* usuario);
contar_pagos_rechazados_asm:
    push rbp
    mov  rbp, rsp
    push r12                ; Guardo los no volatiles en el stack.
    push r13                ; Como voy a llamar a cmpstr, necesito saber que estos no seran modificados.
    push r14                ; Por lo tanto uso r12-14 para guardar mis parametros.
    push r15
    ; Alineado

    mov r12, [rdi]          ; Guardo la direccion de first en r12.
    xor r13, r13            ; Inicializo mi contador en 0.
    mov r14, rsi            ; Guardo el nombre de usuario.

    .loopContar:        
        cmp r12, 0          ; Si first == NULL. Termino.
        je .fin
        
        mov r15,  [r12]     ; Guardamos la direccion de data en r15.
        mov rdi,  [r15+16]  ; Guardamos el nombre del cobrador en rdi. Al ser unpacked tenemos que movernos 16 bytes.
        mov rsi,  r14       ; Guardamos el nombre de usario en rsi.
        call strcmp         ; Ejecutamos strcmp
        cmp rax, 0
        jne .siguiente      ; Si no es nuestro usuario, saltamos al siguiente elemento.

        cmp byte [r15+1], 0 ; Comparamos el aprobado con 0. Si fue rechazado, sumamos 1.
        jne .siguiente
        inc r13

    .siguiente:
        mov r12, [r12 + 8]  ; Salto a next 
        jmp .loopContar
    
    .fin:
    mov rax, r13
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbp
    ret

; pagoSplitted_t* split_pagos_usuario_asm(list_t* pList, char* usuario);
split_pagos_usuario_asm:
    push rbp
    mov  rbp, rsp
    push r12                ; Guardo los no volatiles en el stack.
    push r13                ; Como voy a llamar a cmpstr, necesito saber que estos no seran modificados.
    push r14                ; Por lo tanto uso r12-14 para guardar mis parametros.
    push r15
    ; Alineado

    mov r14, rdi            ; Quiero preservar los valores de entrada.
    mov r15, rsi            

    mov rdi, r14            
    mov rsi, r15            
    call contar_pagos_aprobados_asm
    mov r12, rax            

    mov rdi, r14            
    mov rsi, r15            
    call contar_pagos_rechazados_asm
    mov r13, rax

    ; R12 = cantidad de aprobados.
    ; R13 = cantidad de rechazados.
    ; R14 = Direccion de lista
    ; R15 = Usuario
    
    push r14                ; Guardo en el stack la direccion de lista
    push r15                ; Guardo en el stack el nombre de usuario.
    ; Alineado
    
    mov rax, 8 
    mov rcx, r12
    mul rcx

    mov rdi, rax         ; pago_t ocupa 24 bytes lo quiero aprobados veces.
    call malloc
    mov r14, rax

    mov rax, 8 
    mov rcx, r13
    mul rcx

    mov rdi, rax         ; pago_t ocupa 24 bytes lo quiero rechazados veces.
    call malloc
    mov r15, rax
    
    ; R12 = cantidad de aprobados.
    ; R13 = cantidad de rechazados.
    ; R14 = Direccion aprobados.
    ; R15 = Direccion rechazados.

    pop r11                 ; En r11 tengo el nombre de usuario.
    pop r10                 ; En r10 ahora tengo la direccion de la lista.
    push r14                ; Guardo en el stack la direccion de aprobados
    push r15                ; Guardo en el stack la direccoon de rechazados
    ; Alineado

    mov r10, [r10]          ; En r10 tengo la direccion del first.

    .loopData:
        cmp r10, 0           ; Si next == 0 termina
        je .finsplit
        
        mov r8,  [r10]       ; Guardamos la direccion de data en r8.
        mov rdi, [r8+16]     ; Guardamos el nombre del cobrador en rdi.
        mov rsi, r11         ; Guardamos el nombre del usuario en rsi.
        
        ; Preservamos los volatiles
        push r8
        push r10
        push r11
        sub rsp, 8
        ;Alineado
        call strcmp
        add rsp, 8
        pop r11
        pop r10
        pop r8
idea detras de la modificacion es correcta o v
        cmp rax, 0          ; Si no tienen el mismo nombre, anda al siguiente nodo.
        jne .siguiente

        xor rdi, rdi
        mov dil, [r8+1]     ; Guardo en rdi si fue aprobado o no.
        cmp dil, 1          ; Si es 1 fue aprobado, si no es 1 fue rechazado.
        jne .rechazado        

    .aprobado:
        mov r8, [r10]
        mov [r14], r8    ;Guarda en el nodo aprobado la data.
        add r14, 24         ;Avanza al siguiente nodo.
        jmp .siguiente

    .rechazado:
        mov r8, [r10]    ; Guardo en el nodo recahzadps la data.
        mov [r15], r8
        add r15, 8         ; Avanza al siguiente nodo.
        jmp .siguiente

    .siguiente:
        mov r10, [r10+8]
        jmp .loopData

    .finsplit:
        mov rdi, 8     ; Muevo a rdi el tamaño de pago splited
        call malloc

        pop r15     ; Le devolvemos a r15 la direccion de rechazados.
        pop r14     ; Le devolvemos a r14 la direccion de aprobados.

        ;Guardo la data
        mov [rax],    r12b
        mov [rax+1],  r13b
        mov [rax+8],  r14       ; Por alguna razon tira seggault
        mov [rax+16], r15       ; Por alguna razon tira segfault.

    pop r15
    pop r14
    pop r13
    pop r12
    pop rbp
    ret

