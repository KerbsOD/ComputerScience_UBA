# Devuelve 1 si index >= length/2
# int32_t segunda_mitad(int32_t a, int32_t index, int32_t length)
# a0 a, a1 index, a2 length

call_segunda_mitad: 
    li a0, 0            # Inicializo a = 0.
    srai a2, a2, 1      # Hacemos 1 shift aritmetico a derecha.
    
    bge a1, a2, setOne  # Si Index >= Length/2, a = 1.
    
    j FinSegundaMitad   # Termino porque Index < Lenght/2.
    
setOne:
    li a0, 1            # a = 1
    j FinSegundaMitad   # Termino.
    
FinSegundaMitad:
    ret
