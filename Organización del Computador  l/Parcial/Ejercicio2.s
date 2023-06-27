# Extiende el signo de a de 16 a 32 bits y devuelve accum + ext_sign(a) + b 
# int32_t sumar_extender(int32_t accum, int32_t a, int32_t b)
call_sumar_extender: # a0:accum, a1:a, a2:b
    # Hago el shifting
    slli a1, a1, 16 # Hacemos 16 shifts a la izquierda logico
    srai a1, a1, 16 # Hacemos 16 shifts a la derecha aritmetico, me mantiene el negativo 
    
    # sumo a + b y luego b + accum
    add a2, a2, a1
    add a0, a0, a2
    
FinExtender:
	ret	
