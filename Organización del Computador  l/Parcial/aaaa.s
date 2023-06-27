.equ acumulado, 3
.equ a, 39
.equ b,  187

li a0, acumulado
li a1, a
li a2, b

main:
    # Termina si a==0 o b <= 0
    beqz a1, finDividir
    blez a2, finDividir
    
    # En t0 guardamos nuestro cociente.
    li t0, 0

    # Si A es positivo saltamos a LoopDivision
    # Si A es negativo, lo hacemos positivo y procedemos al loop negativo.
    bge a1, a2, LoopDivision
    
    neg a1, a1
    


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
    j finFinal
    
    
finFinal:
    j finFinal