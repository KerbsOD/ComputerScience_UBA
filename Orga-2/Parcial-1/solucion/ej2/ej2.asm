global mezclarColores

section .data
mascara: db 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;void mezclarColores( uint8_t *X,        [rdi]
;                      uint8_t *Y,       [rsi]
;                      uint32_t width,   [rdx]
;                      uint32_t height); [rcx]
mezclarColores:
    push rbp
    mov rbp, rsp

    mov rax, rdx                ; Obtengo la cantidad de pixeles totales en rax.
    mov rcx, rcx
    mul rcx

    mov r12, rax                ; Guardo en r12 la cantidad total de pixeles.
    xor r8, r8                  ; Uso r8 de contador de pixeles.

    movdqu xmm2, [mascara]      ; Cargo la mascara a xmm2

    .loopMezclar:
        movdqu xmm0, [rdi]      ; Cargo 4 pixeles en xmm0.
        pand   xmm0, xmm2       ; Pongo todos los alpha en 0.
        movdqa xmm1, xmm0       ; Copio los 4 pixeles a xmm1.
        
        ; Me quedo sin tiempo. Explico la idea.
        ;   - Mover xmm1 un byte para la izquierda.
        ;   - usar pcmpgtb para comparar byte a byte si r > g > b
        ;   - Para cada pixel que tenga r, g y b en 1 significa que entra en el caso 1.
        ;   - Para cada pixel que tenga r, g y b en 0 significa que entra en el caso 2.
        ;   - 
        ;   

        .caso1:


        .caso2:



        add rdi, 16             ; Avanzo 4 pixeles de X.
        add rsi, 16             ; Avanzo 4 pixeles de Y.
        add r8, 4               ; Agrego 4 pixeles al contador.

        cmp r8, rcx
        jne .loopMezclar

    .finMezclar:
    pop rbp
    ret

