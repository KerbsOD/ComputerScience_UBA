package main

func PowInts(x, n int) int {
	if n == 0 {
		return 1
	}
	if n == 1 {
		return x
	}
	y := PowInts(x, n/2)
	if n%2 == 0 {
		return y * y
	}
	return x * y * y
}

func intercalar(i int, x int, v []int, w int, n int, M [][]int) bool {
	if i == n {
		return x == w
	}

	if x > w {
		return false
	}

	if M[i][x] == -1 {
		suma := intercalar(i+1, x+v[i], v, w, n, M)
		multiplicion := intercalar(i+1, x*v[i], v, w, n, M)
		potencia := intercalar(i+1, PowInts(x, v[i]), v, w, n, M)

		if suma || multiplicion || potencia {
			M[i][x] = 1
		} else {
			M[i][x] = 0
		}
	}

	if M[i][x] == 1 {
		return true
	}

	return false
}

func intercalarBU(n int, w int, v []int, M [][]bool) bool {
	M[n][w] = true

	for i := n - 1; i >= 0; i-- {
		for j := w; j >= 0; j-- {
			suma := false
			if j+v[i] <= w {
				suma = M[i+1][j+v[i]]
			}

			multiplicacion := false
			if j*v[i] <= w {
				multiplicacion = M[i+1][j*v[i]]
			}

			potencia := false
			if PowInts(j, v[i]) <= w {
				potencia = M[i+1][PowInts(j, v[i])]
			}

			M[i][j] = suma || multiplicacion || potencia
		}
	}

	return M[0][0]
}

// func main() {
// 	v := []int{3, 1, 5, 2, 1}
// 	n := len(v)
// 	w := 400
// 	M := make([][]int, n+1)
// 	for i := 0; i <= n; i++ {
// 		M[i] = make([]int, w+1)
// 		for j := 0; j <= w; j++ {
// 			M[i][j] = -1
// 		}
// 	}

// 	fmt.Println(intercalar(0, 0, v, w, n, M))

// 	MBU := make([][]bool, len(v)+1)
// 	for i := 0; i <= len(v); i++ {
// 		MBU[i] = make([]bool, w+1)
// 		for j := 0; j <= w; j++ {
// 			MBU[i][j] = false
// 		}
// 	}
// 	fmt.Println(intercalarBU(n, w, v, MBU))
// }
