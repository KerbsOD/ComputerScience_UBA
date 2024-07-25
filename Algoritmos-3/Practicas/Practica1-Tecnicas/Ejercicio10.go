package main

// const inf int = math.MaxInt32 >> 8

func cajas(i int, p int, pesos []int, soportes []int, M [][]int) int {
	if i == -1 {
		return 0
	}

	if soportes[i] < p {
		return cajas(i-1, p, pesos, soportes, M)
	}

	if M[i][p] == -1 {
		agrego := cajas(i-1, p+pesos[i], pesos, soportes, M) + 1
		noAgrego := cajas(i-1, p, pesos, soportes, M)
		M[i][p] = max(agrego, noAgrego)
	}

	return M[i][p]
}

// func main() {
// 	pesos := []int{19, 7, 5, 6, 1}
// 	soportes := []int{1500, 13, 7, 8, 2}
// 	n := len(pesos)

// 	maximoPeso := 0
// 	for i := 0; i < n; i++ {
// 		maximoPeso += pesos[i]
// 	}

// 	M := make([][]int, n)
// 	for i := 0; i < n; i++ {
// 		M[i] = make([]int, maximoPeso+1)
// 		for j := 0; j <= maximoPeso; j++ {
// 			M[i][j] = -1
// 		}
// 	}

// 	fmt.Println(cajas(n-1, 0, pesos, soportes, M))
// }
