/*
(A)
Input:
  - B valores de billetes
  - c costo de un producto

Output:
  - Pagar con el minimo exceso posible (minimizar perdida)
  - Pagar con el minimo tiempo posible (minimizar tiempo)
  - Tupla (exceso, cantidad) Primero se ordenan por exceso y luego por cantidad de billetes
*/
package main

import (
	"fmt"
	"math"
)

func billetesBT(i int, j int, q int, c int, B []int) (int, int) {
	if i == len(B) {
		return math.MaxInt32, math.MaxInt32
	}

	if j >= c {
		return j, q
	}

	excesoAgrego, cantAgrego := billetesBT(i+1, j+B[i], q+1, c, B)
	excesoNoAgrego, cantNoAgrego := billetesBT(i+1, j, q, c, B)

	if excesoNoAgrego == excesoAgrego {
		if cantNoAgrego < cantAgrego {
			return excesoNoAgrego, cantNoAgrego
		}
		return excesoAgrego, cantAgrego
	}

	if excesoNoAgrego < excesoAgrego {
		return excesoNoAgrego, cantNoAgrego
	}

	return excesoAgrego, cantAgrego
}

/*
   (C) La complejidad de "billetesBT" es de 2^n. Luego la cantidad de instancias es
   igual a O(nc)
*/

type costo struct {
	exceso   int
	cantidad int
}

/*
Nueva complejidad O(nc)
La llamada que resuelve el problema es billetesDP(0, 0)
*/
func billetesDP(i int, j int, q int, memo [][]costo, c int, B []int) costo {
	if i == len(B) {
		return costo{math.MaxInt32, math.MaxInt32}
	}

	if j >= c {
		return costo{j, q}
	}

	if memo[i][j].exceso == -1 {
		excesoAgrego, cantAgrego := billetesBT(i+1, j+B[i], q+1, c, B)
		excesoNoAgrego, cantNoAgrego := billetesBT(i+1, j, q, c, B)

		if excesoAgrego > excesoNoAgrego {
			memo[i][j] = costo{excesoNoAgrego, cantNoAgrego}
		}

		if excesoAgrego < excesoNoAgrego {
			memo[i][j] = costo{excesoAgrego, cantAgrego}
		}

		if excesoAgrego == excesoNoAgrego {
			if cantAgrego < cantNoAgrego {
				memo[i][j] = costo{excesoAgrego, cantAgrego}
			} else {
				memo[i][j] = costo{excesoNoAgrego, cantNoAgrego}
			}
		}
	}

	return memo[i][j]
}

func main() {
	B := []int{2, 3, 5, 10, 20, 20}
	k := 14
	n := len(B)

	memo := make([][]costo, n+1)
	for i := 0; i <= n; i++ {
		memo[i] = make([]costo, k+1)
		for j := 0; j <= k; j++ {
			memo[i][j] = costo{-1, -1}
		}
	}

	fmt.Println(billetesDP(0, 0, 0, memo, k, B))
}
