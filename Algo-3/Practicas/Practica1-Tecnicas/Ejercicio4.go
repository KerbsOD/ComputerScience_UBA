/*
Input:
  - Matriz D de nxn naturales.

Output:
  - Permutacion de {1,...,n} que minimice la cuentita.

In Spanish: Parece que pi es una funcion que mapea indices. Por ejemplo si tengo el conjunto {2,3,1}.

	Entonces pi mapea de la siguiente manera:
	pi(1) = 2
	pi(2) = 3
	pi(3) = 1
	Todo esto de los mapeos parece ser solo para romper las bolas. Algo3, te odio!
*/
package main

func permutacionPi(n int, sumaActual int, pi []int, minPi []int, sumaMin int, D [][]int, numeroUsado []bool) ([]int, int) {
	if len(pi) == n {
		sumaActual += D[pi[n-1]][pi[0]]
		if sumaMin == -1 || sumaMin > sumaActual {
			copiedSlice := make([]int, len(pi))
			copy(copiedSlice, pi)
			minPi = copiedSlice
			sumaMin = sumaActual
		}
		return minPi, sumaMin
	}

	if sumaMin != -1 && sumaActual > sumaMin {
		return minPi, sumaMin
	}

	for i := 0; i < n; i++ {
		if numeroUsado[i] {
			continue
		}

		numeroUsado[i] = true
		pi = append(pi, i)

		suma := 0
		long := len(pi)
		if long > 1 {
			suma += D[pi[long-2]][pi[long-1]]
		}

		minPi, sumaMin = permutacionPi(n, suma+sumaActual, pi, minPi, sumaMin, D, numeroUsado)

		numeroUsado[i] = false
		pi = pi[:len(pi)-1]
	}

	return minPi, sumaMin
}
