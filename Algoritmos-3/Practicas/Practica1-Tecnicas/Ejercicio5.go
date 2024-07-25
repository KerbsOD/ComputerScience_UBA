package main

/*
(A) O(2^n) llamadas recursivas
*/
func sumaConj(i int, j int, C []int) bool {
	if i == -1 {
		return j == 0
	}

	if C[i] > j {
		return sumaConj(i-1, j, C)
	}

	return sumaConj(i-1, j, C) || sumaConj(i-1, j-C[i], C)
}

/*
(B)
	O(nk) posibles instancias de 'sumaConj'
	Un ejemplo puede ser C = {6, 6, 6, 6, 6, 6} con k = 12. Supongamos que sumaConj(i,k,conj) = f(i,k)
											f(5, 12)
						f(4, 6)										f(4, 12)
			f(3, 0)					f(3, 6)				f(3, 6)					f(3, 12)
	Podemos ver que se repite f(3, 6). Y si seguimos bajando tendremos muchas mas repeticiones.
*/

/*
(C) Considerar que como j es un numero que no podemos modificar, cuando creamos M lo creamos con n+1 y k+1

	posiciones, entonces para que se indexe bien C debemos agregarle un elemento al inicio, yo le agregue 0
*/
func sumaConjDP(i int, j int, C []int, M [][]int) bool {
	if j < 0 {
		return false
	}

	if i == 0 {
		return j == 0
	}

	if M[i][j] == -1 {
		res := sumaConjDP(i-1, j, C, M) || sumaConjDP(i-1, j-C[i], C, M)
		if res == true {
			M[i][j] = 1
		} else {
			M[i][j] = 0
		}
	}

	if M[i][j] == 1 {
		return true
	}
	return false
}

/*
(D) La complejidad es de O(nk). Cuando k << 2^n es mejor la solucion con dp. Cuando k >> 2^n es
	mejor backtracking. No vale la pena gastar memoria en DP.
*/

/*
(E)
*/
func sumaConjBU(n int, k int, C []int, M [][]bool) bool {
	for i := 1; i <= n; i++ {
		for j := 1; j <= k; j++ {
			M[i][j] = M[i-1][j] || (j-C[i] >= 0 && M[i-1][j-C[i]])
		}
	}
	return M[n][k]
}
