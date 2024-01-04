/*
Input:
	- Matriz M de nxn naturales
	- Numero natural k
Output:
	- Subconjunto I con valores del 1 a n, de tamaño k. que maximice sum de M.
	Explicado para boludos (yo):
		En el ejemplo nos dicen que k = 3 e I = {1,2,3}.
		Nos estan diciendo que los numeros {1,2,3} son los indices que maximizan la matriz.
		Porque: M[1][2] = 10, M[1][3] = 10 y M[2][3] = 5.
		Por eso ademas no tienen valores la parte baja de la matriz o las diagonales (o sea, no nos interesa
		M[1][1] o M[3][3]). Tener en cuenta ademas que estamos indexando con 1 y no 0.

(B)
    Como tenemos que armar todos los subconjuntos de k elementos la complejidad es el numero
	combinatorio (n k) = O(n!/(n-k)!k!)

(C)
	k == 0 puede ser una poda por optimalidad, no chequeamos los conjuntos mayores a k.
	k > i puede ser una poda por optimalidad, queremos un conjunto de tamaño exactamente k por lo que
	si los elementos que quedan son menos de los que necesito, no me sirve la rama.
*/

package main

import "fmt"

var matriz [][]int
var maxConju []int
var maxValor int

func maximize(i int, k int, valorConjI int, conjI []int) {
	if k == 0 {
		if valorConjI > maxValor {
			copiedSlice := make([]int, len(conjI))
			copy(copiedSlice, conjI)
			maxConju = copiedSlice
			maxValor = valorConjI
		}
		return
	}

	if k > i {
		return
	}

	if i == -1 {
		return
	}

	conjI = append(conjI, i)
	suma := 0
	for _, v := range conjI {
		suma += matriz[v][i] + matriz[i][v]
	}

	maximize(i-1, k-1, valorConjI+suma, conjI)

	conjI = conjI[:len(conjI)-1]
	maximize(i-1, k, valorConjI, conjI)
}

func Ejercicio3() {
	n := 4
	k := 3
	maxValor = 0
	matriz = [][]int{
		{0, 10, 10, 1},
		{0, 0, 5, 7},
		{0, 0, 0, 100},
		{0, 0, 0, 0}}
	maximize(n-1, k, 0, []int{})

	for i := k - 1; i >= 0; i-- {
		fmt.Printf("%v ", maxConju[i]+1)
	}
	fmt.Printf("\n")
}
