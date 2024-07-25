package auxiliares

import "fmt"

func prims(cost [][]int) {
	n := len(cost)
	visited := make([]bool, n)
	visited[0] = true
	var total int = 0
	fmt.Println("Edge : Weight")

	for count := 0; count < n-1; count++ {
		minimum := 9999999
		x := 0
		y := 0
		for i := 0; i < n; i++ {
			if visited[i] {
				for j := 0; j < n; j++ {
					if !visited[j] && cost[i][j] != 0 {
						if minimum > cost[i][j] {
							minimum = cost[i][j]
							x = i
							y = j
						}
					}
				}
			}
		}
		fmt.Printf("%d - %d : %d\n", x, y, minimum)
		visited[y] = true
		total += minimum
	}
	fmt.Printf("Minimum Cost: %d\n", total)
}
