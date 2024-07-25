/*
- n dados
- k caras
- Calcular todas las maneras posibles de conseguir la suma total s.

(A) Dados distinguibles. Si 3 dados y 4 caras entonces existen 10 posibilidades que suman 6. Sea (D1,D2,D3) el valor de los 3 dados.
	- 4 posibilidades donde el primer dado vale 1 y los otros dos suman 5: {(1,2,3),(1,3,2),(1,4,1), (1,1,4)})
	- 3 posibilidades donde el primer dado vale 2 y los otros dos suman 4: {(2,2,2), {2,1,3}, {2,3,1}}
	- 2 posibilidades donde el;priemr dado vale 3 y los otros dos suman 3: {(3,1,2), (3,2,1)}
	- 1 posibilidad donde el primer dado vale 4 y los otros dos suman 2: {(4,1,1)}

(B) Dados indistinguibles. Si 3 dados y 4 caras entonces existen 3 posibilidades que suman 6. Sea (D,D,D) el valor de los 3 dados.
	- (4,1,1)
	- (3,2,1)
	- (2,2,2)
*/

package main

import "fmt"

func dadosDist(n int, s int, k int, M [][]int) int {
	if n == 0 {
		if s == 0 {
			return 1
		}
		return 0
	}

	if s <= 0 {
		return 0
	}

	if M[n][s] == -1 {
		M[n][s] = 0
		for i := 1; i <= k; i++ {
			M[n][s] += dadosDist(n-1, s-i, k, M)
		}
	}

	return M[n][s]
}

// No voy a hacer el B, ya estoy re quemado con programacion dinamica y odio combinatoria. Tal vez otro año :p

func main() {
	n := 3
	k := 4
	s := 6

	M := make([][]int, n+1)
	for i := 0; i <= n; i++ {
		M[i] = make([]int, s+1)
		for j := 0; j <= s; j++ {
			M[i][j] = -1
		}
	}
	fmt.Println(dadosDist(n, s, k, M))
}
