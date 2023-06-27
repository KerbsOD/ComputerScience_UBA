# Devuelve accum + a / b 
# int32_t dividir(int32_t accum, int32_t a, int32_t b)
call_dividir: # a0:accum, a1:a, a2:b
    
    # Termina si a==0 o b <= 0
    beqz a1, finDividir
    blez a2, finDividir
    
    # En t0 guardamos nuestro cociente, inicializamos en 0.
    li t0, 0

    # Si A es mayor o igual a B, saltamos a LoopDivision.
    bge a1, a2, LoopDivision
    
    # Si A es negativo, lo hacemos positivo y si es mayor o igual a B, saltamos a LoopDivisionNegativa.
    neg a1, a1
    bge a1, a2, LoopDivision
    
    j finDividir
    
LoopDivisionNegativa:
    sub a1, a1, a2                      # A = A - B
    addi, t0, t0, -1                    # t0--
    bge a1, a2, LoopDivisionNegativa    # while A >= B

    j finDividir

LoopDivision:
    sub a1, a1, a2              # A = A - B
    addi, t0, t0, 1             # t0++
    bge a1, a2, LoopDivision    # while A >= B

    j finDividir
    
finDividir:
    add a0, a0, t0
    ret
