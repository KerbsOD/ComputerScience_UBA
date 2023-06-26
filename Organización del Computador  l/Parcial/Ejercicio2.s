li a0, 0
li a1, 0
li a2, -1  # (0xffffffff)
# a0:accum, a1:a, a2:b

# Hago el shifting
slli a1, a1, 16 # Hacemos 16 shifts a la izquierda logico.
srai a1, a1, 16 # Hacemos 16 shifts a la derecha aritmetico, me mantiene el negativo.

# sumo a + b y luego b + accum
add a2, a2, a1
add a0, a0, a2

# Verifico si a == 0 o b == 0 o b < 0    
beqz a1, SetZero
beqz a2, SetZero
blt a2, zero, SetZero 
    
FinExtender:
    j FinExtender
    
SetZero:
    li a0, 0


