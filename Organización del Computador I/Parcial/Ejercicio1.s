# Devuelve accum = accum + a / b 
# int32_t dividir(int32_t accum, int32_t a, int32_t b)
# a0:accum, a1:a, a2:b

call_dividir: 
    beqz a1, finDividir         # Si a == 0 -> Terminamos.
    blez a2, finDividir         # Si b <= 0 -> Terminamos.

    li t0, 1                    # t0 = 1. Representa al cociente positivo.
    bge a1, a2, LoopDivision    # Si A >= B, hacemos la division.
    
    neg a1, a1                  # Negamos A.
    li t0, -1                   # t0 = -1. Representa al cociente negativo.
    bge a1, a2, LoopDivision    # Si A >= B, hacemos la division.
    
    j finDividir                # Termino porque no puedo dividir (|A| < B).
    
LoopDivision:
    sub a1, a1, a2              # A = A - B.
    add a0, a0, t0              # Acum = Acum + t0 (t0 puede ser 1 o -1).
    bge a1, a2, LoopDivision    # while A >= B.

    j finDividir                # Termino.
    
finDividir:
    ret
