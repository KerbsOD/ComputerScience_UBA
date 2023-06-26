li a0, 0
li a1, 0
li a2, 4294967295 

main: 
    # a0 a, a1 index, a2 length
    li t0, 0
    srai a2, a2, 1
    bge a1, a2, SetToOne
    j FinMitad

SetToOne:
    addi t0, t0, 1

FinMitad:
	ret