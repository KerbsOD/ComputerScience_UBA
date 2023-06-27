# Devuelve 1 si a es impar, 0 en caso contario
# int32_t numero_impar(int32_t a, int32_t index, int32_t length)
# a0 a, a1 index, a2 length

call_numero_impar: 
    andi a0, a0, 1  # AND bit a bit.
	ret
