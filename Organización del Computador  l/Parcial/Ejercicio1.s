.equ a, 10
.equ b, 2
.equ accum, 56

main: 
    # Terminamos si a==0 o b==0 o b<0
    beqz a1, FinDividir
    beqz a2, FinDividir
    blt a2, zero, FinDividir

    # accum = accum + a/b 
    div t0, a1, a2
    add a0, a0, t0 

FinDividir:
    ret

# FUNCIONA!!!
    