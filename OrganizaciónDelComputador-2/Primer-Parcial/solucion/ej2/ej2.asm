global mezclarColores
section .data
mascaraMayor:   db  0x2,0x0,0x1,0x80, 0x6,0x4,0x5,0x80, 0xA,0x8,0x9,0x80, 0xE,0xC,0xD,0x80
mascaraMenor:   db  0x1,0x2,0x0,0x80, 0x5,0x6,0x4,0x80, 0x9,0xA,0x8,0x80, 0xD,0xE,0xC,0x80
mascaraR:       db  0x0,0x80,0x80,0x80, 0x4,0x80,0x80,0x80, 0x8,0x80,0x80,0x80, 0xC,0x80,0x80,0x80
mascaraG:       db  0x1,0x80,0x80,0x80, 0x5,0x80,0x80,0x80, 0x9,0x80,0x80,0x80, 0xD,0x80,0x80,0x80
mascaraB:       db  0x2,0x80,0x80,0x80, 0x6,0x80,0x80,0x80, 0xA,0x80,0x80,0x80, 0xE,0x80,0x80,0x80
limpiarAlpha:   db  0x0,0x1,0x2,0x80, 0x4,0x5,0x6,0x80, 0x8,0x9,0xA,0x80, 0xC,0xD,0xE,0x80

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;void mezclarColores(  uint8_t *X,       [rdi]
;                      uint8_t *Y,       [rsi]
;                      uint32_t width,   [rdx]
;                      uint32_t height); [rcx]
mezclarColores:
    push rbp
    mov rbp, rsp
    push r12

    mov rax, rdx                    ; Movemos a rax el valor de rdx
    mul rcx                         ; Multiplica rcx*rax
    mov r12, rax                    ; Guardamos en r12 la cantidad total de pixeles
    shr r12, 2                      ; Divido la cantidad de pixeles por 4. (son 4 pixeles)
    
    movdqu xmm10, [mascaraMayor]
    movdqu xmm11, [mascaraMenor]
    movdqu xmm12, [mascaraR]
    movdqu xmm13, [mascaraG]
    movdqu xmm14, [mascaraB]
    movdqu xmm15, [limpiarAlpha]

    .loopImagen:
        cmp r12, 0                  ; Si no quedan mas pixeles para procesar, termino.
        je .finImagen

        movdqu xmm1, [rdi]          ; XMM1 = [R,G,B,A, R,G,B,A, R,G,B,A, R,G,B,A]
        pshufb xmm1, xmm15          ; XMM1 = [R,G,B,0, R,G,B,0, R,G,B,0, R,G,B,0]

        movdqa xmm2, xmm1           ; XMM2 = [R,G,B,0, R,G,B,0, R,G,B,0, R,G,B,0]
        movdqa xmm3, xmm1           ; XMM3 = [R,G,B,0, R,G,B,0, R,G,B,0, R,G,B,0]
        movdqa xmm4, xmm1           ; XMM4 = [R,G,B,0, R,G,B,0, R,G,B,0, R,G,B,0]
        movdqa xmm5, xmm1           ; XMM5 = [R,G,B,0, R,G,B,0, R,G,B,0, R,G,B,0]
        movdqa xmm6, xmm1           ; XMM6 = [R,G,B,0, R,G,B,0, R,G,B,0, R,G,B,0]

        pshufb xmm2, xmm10          ; XMM2 = [B,R,G,0, B,R,G,0, B,R,G,0, B,R,G,0]
        pshufb xmm3, xmm11          ; XMM3 = [G,B,R,0, G,B,R,0, G,B,R,0, G,B,R,0]
        pshufb xmm4, xmm12          ; XMM4 = [R,0,0,0, R,0,0,0, R,0,0,0, R,0,0,0]
        pshufb xmm5, xmm13          ; XMM5 = [G,0,0,0, G,0,0,0, G,0,0,0, G,0,0,0]
        pshufb xmm6, xmm14          ; XMM6 = [B,0,0,0, B,0,0,0, B,0,0,0, B,0,0,0]
        
    .comparacionMayor:
        movdqa xmm7, xmm1           ; XMM7 = [R,G,B,0, R,G,B,0, R,G,B,0, R,G,B,0]
        movdqa xmm8, xmm4           ; XMM8 = [R,0,0,0, R,0,0,0, R,0,0,0, R,0,0,0]
        movdqa xmm9, xmm5           ; XMM9 = [G,0,0,0, G,0,0,0, G,0,0,0, G,0,0,0]
        
        pcmpgtd xmm8, xmm9          ; XMM8 = [R>G, R>G, R>G, R>G]
        pcmpgtd xmm9, xmm6          ; XMM9 = [G>B, G>B, G>B, G>B]
        pand    xmm8, xmm9          ; XMM8 = [R>G>B, R>G>B, R>G>B]

        movdqa   xmm0, xmm8         ; XMM0 = [R>G>B, R>G>B, R>G>B]
        pblendvb xmm7, xmm2         ; XMM7 tiene los pixles originales. XMM2 tiene los pixeles modificados por mayor. Ponemos en xmm7 los que estan en 1 en xmm0.
        movdqa   xmm1, xmm7         ; XMM1 = XMM7

    .comparacionMenor:
        movdqa xmm7, xmm1           ; XMM7 = XMM1
        movdqa xmm8, xmm6           ; XMM8 = [B,0,0,0, B,0,0,0, B,0,0,0, B,0,0,0]
        movdqa xmm9, xmm5           ; XMM9 = [G,0,0,0, G,0,0,0, G,0,0,0, G,0,0,0]

        pcmpgtd xmm8, xmm9          ; XMM8 = [B>G, B>G, B>G, B>G]
        pcmpgtd xmm9, xmm4          ; XMM9 = [G>R, G>R, G>R, G>R]
        pand    xmm8, xmm9          ; XMM8 = [B>G>R, B>G>R, B>G>R, B>G>R]

        movdqa   xmm0, xmm8         ; XMM0 = [B>G>R, B>G>R, B>G>R, B>G>R]
        pblendvb xmm7, xmm3         ; XMM7 tiene los pixles originales. XMM3 tiene los pixeles modificados por menor. Ponemos en xmm7 los que estan en 1 en xmm0.
        movdqa   xmm1, xmm7         ; XMM1 = XMM7

    .siguientesPixeles:
        movdqu [rsi], xmm1
        sub r12, 4                  ; Resto 4 pixeles a r12.
        add rdi, 16                 ; Avanzo 4 pixeles (4 bytes cada pixel)
        add rsi, 16                 ; Avanzo 4 pixeles (4 bytes cada pixel)
        jmp .loopImagen

    .finImagen:
    pop r12
    pop rbp
    ret

