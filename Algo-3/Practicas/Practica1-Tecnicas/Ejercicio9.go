package main

/*
	Si una casilla es igual a -2 entonces necesito al menos 2 vidas para pasar. Por eso restamos lo negativo.
	Si una casilla me da valor positivo entonces devuelvo 1 porque necesito al menos 1 vida para pasar por ahi.
*/

// const inf int = math.MaxInt32 >> 8

func minVida(i int, j int, n int, m int, A [][]int, M [][]int) int {
	if (i == n && j+1 == m) || (i+1 == n && j == m) {
		return 0
	}

	if i == n || j == m {
		return inf
	}

	if M[i][j] == -1 {
		M[i][j] = min(minVida(i+1, j, n, m, A, M), minVida(i, j+1, n, m, A, M)) - A[i][j]
		if M[i][j] <= 0 {
			M[i][j] = 1
		}
	}

	if i == 0 && j == 0 {
		return M[i][j] + 1
	}

	return M[i][j]
}

/*
	M[i][j] depende de M[i+1][j] y M[j][i+1]
*/

func minVidaBU(n int, m int, A [][]int, M [][]int) int {
	M[n][m-1] = 0
	M[n-1][m] = 0

	for i := n - 1; i >= 0; i-- {
		for j := m - 1; j >= 0; j-- {
			M[i][j] = min(M[i+1][j], M[i][j+1]) - A[i][j]

			if i == 0 && j == 0 {
				M[i][j] = min(M[i+1][j], M[i][j+1]) - A[i][j]
			}

			if M[i][j] <= 0 {
				M[i][j] = 1
			}
		}
	}

	return M[0][0] + 1
}

// func main() {
// 	n := 10000
// 	m := 10000

// 	A := make([][]int, n+1)
// 	for i := 0; i <= n; i++ {
// 		A[i] = make([]int, m+1)
// 		for j := 0; j <= m; j++ {
// 			A[i][j] = (j + 1) * (i + 1) * (-1 + ((j % 2) * 2))
// 			if A[i][j]%4 == 0 {
// 				A[i][j] *= 6
// 			} else {
// 				A[i][j] *= 12
// 			}
// 		}
// 	}

// 	// A := [][]int{{-2, -3, 3}, {-5, -10, 1}, {10, 30, -5}}

// 	M := make([][]int, n+1)
// 	for i := 0; i <= n; i++ {
// 		M[i] = make([]int, m+1)
// 		for j := 0; j <= m; j++ {
// 			M[i][j] = -1
// 		}
// 	}

// 	timeStart := time.Now()
// 	resultado := minVida(0, 0, n, m, A, M)
// 	timeStop := time.Since(timeStart)
// 	fmt.Printf("MinimasVidas Top-Down \nResultado: %v \nTiempo: %v \n", resultado, timeStop)

// 	fmt.Println()
// 	for i := 0; i <= n; i++ {
// 		for j := 0; j <= m; j++ {
// 			M[i][j] = -1
// 		}
// 	}

// 	timeStart = time.Now()
// 	resultado = minVidaBU(n, m, A, M)
// 	timeStop = time.Since(timeStart)
// 	fmt.Printf("MinimasVidas Bottom-Up \nResultado: %v \nTiempo: %v \n", resultado, timeStop)
// }
