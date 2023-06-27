# Devuelve 1 si index >= length/2
# int32_t segunda_mitad(int32_t a, int32_t index, int32_t length)
call_segunda_mitad: # a0 a, a1 index, a2 length
    # Por las dudas inicializo a en 0
    li a0, 0
    # Shift para la derecha divide por 2
    srai a2, a2, 1
    # Si index >= length/ 2 entonces a = 1
    bge a1, a2, setOne
    # terminar
    j FinSM
    
setOne:
    li a0, 1
    j FinSM
    
FinSM:
    ret
