# Ejercicio 1 ###################################################################
alfajores = read.table("alfajores.txt", header = TRUE)
nalfajores = nrow(alfajores)


# A
sum(alfajores$fabrica == 0) / nalfajores 

# B
sum(alfajores$defectuosos == 3 & alfajores$fabrica == 0) / nalfajores

# C
pxy = t(table(alfajores)) / nalfajores
pxy

# D
mean(alfajores$defectuosos)
var(alfajores$defectuosos)

# E

