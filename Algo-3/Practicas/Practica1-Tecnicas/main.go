package main

import "fmt"

func main() {
	Ejercicio4()
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

func ImprimirVector(vector []int, offset int) {
	fmt.Printf("(")
	for i := 0; i < len(vector); i++ {
		if i == len(vector)-1 {
			fmt.Printf("%v)\n", vector[i]+offset)
			continue
		}
		fmt.Printf("%v, ", vector[i]+offset)
	}
}
