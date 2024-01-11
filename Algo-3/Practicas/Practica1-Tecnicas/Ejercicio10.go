package main

import (
	"fmt"
	"math"
)

const inf int = math.MaxInt32 >> 8

func cajas(i int, p int, pesos []int, soportes []int, M [][]int) int {
	if i == -1 {
		return 0
	}

	if soportes[i] < p {
		return cajas(i-1, p, pesos, soportes, M)
	}

	if M[i][p] == -1 {
		M[i][p] = max(cajas(i-1, p+pesos[i], pesos, soportes, M)+1, cajas(i-1, p, pesos, soportes, M))
	}

	return M[i][p]
}

/*
	Todos los casos donde i = 1 llevan a M[1][j] = max(M[0][j+pesos[i]]+1, M[0][j]).

	Luego, como vimos en top down.
	M[0][p] = max(M[-1][p+pesos[i]]+1, M[-1][p]).
	Todas las llamadas donde i == -1 devuelven 0. Entonces M[0][p] = max(0+1,0) = 1

	Por eso hay un for donde a todas las casillas i == 0 le ponemos el numero 1.
*/

func cajasBU(n int, p int, pesos []int, soportes []int, M [][]int) int {
	return 0
}

func main() {
	pesos := []int{19, 7, 5, 6, 1}
	soportes := []int{150, 13, 7, 8, 2}
	n := len(pesos)

	maximoPeso := 0
	for i := 0; i < n; i++ {
		maximoPeso += pesos[i]
	}

	M := make([][]int, n)
	for i := 0; i < n; i++ {
		M[i] = make([]int, maximoPeso+1)
		for j := 0; j <= maximoPeso; j++ {
			M[i][j] = -1
		}
	}

	fmt.Println(cajas(n-1, 0, pesos, soportes, M))

	for i := 0; i < n; i++ {
		for j := 0; j <= maximoPeso; j++ {
			M[i][j] = -1
		}
	}

	fmt.Println(cajasBU(n, maximoPeso, pesos, soportes, M))
}
