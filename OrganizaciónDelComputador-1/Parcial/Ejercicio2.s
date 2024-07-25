# Extiende el signo de a de 16 a 32 bits y devuelve accum + ext_sign(a) + b 
# int32_t sumar_extender(int32_t accum, int32_t a, int32_t b)
# a0:accum, a1:a, a2:b

call_sumar_extender: 
    slli a1, a1, 16     # Hacemos 16 shifts logicos a la izquierda.
    srai a1, a1, 16     # Hacemos 16 shifts aritmeticos a la derecha.
    
    add a2, a2, a1      # b = b + a.
    add a0, a0, a2      # accum = accum + b.
    
FinExtender:
	ret	
