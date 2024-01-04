package main

import "fmt"

func main() {
	Ejercicio2()
}

/* Funciones Utiles que usare a lo largo de las guias */

func InicializarMatriz(filas int, columnas int) [][]int {
	matriz := make([][]int, filas)
	for i := range matriz {
		matriz[i] = make([]int, columnas)
	}
	return matriz
}

func ImprimirMatriz(matriz [][]int) {
	for i := range matriz {
		for j := range matriz[i] {
			fmt.Print(matriz[i][j], " ")
		}
		fmt.Print("\n")
	}
}
