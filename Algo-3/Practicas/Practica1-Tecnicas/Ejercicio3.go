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

func maximize(i int, k int, valorConjI int, conjI []int, maxConju []int, maxValor int, matriz [][]int) ([]int, int) {
	if k == 0 {
		if valorConjI > maxValor {
			copiedSlice := make([]int, len(conjI))
			copy(copiedSlice, conjI)
			maxConju = copiedSlice
			maxValor = valorConjI
		}
		return maxConju, maxValor
	}

	if k > i {
		return maxConju, maxValor
	}

	if i == -1 {
		return maxConju, maxValor
	}

	conjI = append(conjI, i)
	suma := 0
	for _, v := range conjI {
		suma += matriz[v][i] + matriz[i][v]
	}

	maxConju, maxValor = maximize(i-1, k-1, valorConjI+suma, conjI, maxConju, maxValor, matriz)

	conjI = conjI[:len(conjI)-1]
	maxConju, maxValor = maximize(i-1, k, valorConjI, conjI, maxConju, maxValor, matriz)

	return maxConju, maxValor
}
