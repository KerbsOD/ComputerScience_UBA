package Practica3_Arboles

func DFS_Orientar(u int, p int, adj [][]int, state []int, digrafo [][]int) {
	state[u] = 1

	for _, v := range adj[u] {
		if v == p {
			continue
		}

		if state[v] == 0 {
			digrafo[u] = append(digrafo[u], v)
			DFS_Orientar(v, u, adj, state, digrafo)
		} else if state[v] == 1 {
			digrafo[u] = append(digrafo[u], v)
		}
	}

	state[u] = 2
}

func orientar(aristas [][]int, r int) [][]int {
	n := len(aristas)
	visited := make([]int, n)
	digrafo := make([][]int, n)
	for i := 0; i < n; i++ {
		digrafo[i] = make([]int, 0)
	}

	for i := 0; i < n; i++ {
		visited[i] = 0
	}
	/*
		- 0: No fue visitado
		- 1: Visitando...
		- 2: Fue visitado
	*/
	DFS_Orientar(r, -1, aristas, visited, digrafo)
	return digrafo
}
