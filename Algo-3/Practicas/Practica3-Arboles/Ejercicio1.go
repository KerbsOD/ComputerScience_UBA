package Practica3_Arboles

func dfs(u int, adj [][]int, biparticion []int, padre []int) (bool, int) {
	esBipartito := true
	loopStart := -1

	for _, v := range adj[u] {
		esBipartito2 := true
		loopStart2 := -1

		if padre[v] == -1 {
			padre[v] = u
			biparticion[v] = 1 - biparticion[u]
			esBipartito2, loopStart2 = dfs(v, adj, biparticion, padre)
		} else if biparticion[v] == biparticion[u] {
			return false, v
		}

		if esBipartito2 == false {
			esBipartito = false
			loopStart = loopStart2
		}
	}

	return esBipartito, loopStart
}

func bipartito(r int, aristas [][]int) (int, []int) {
	n := len(aristas)
	biparticion := make([]int, n)
	parent := make([]int, n)
	for i := 0; i < n; i++ {
		biparticion[i] = -1
		parent[i] = -1
	}

	for i := 1; i < n; i++ {
		if biparticion[i] == -1 {
			parent[i] = 0
			biparticion[i] = 0
			esBipartito, loopStart := dfs(i, aristas, biparticion, parent)
			if !esBipartito {
				return loopStart, parent
			}
		}
	}

	return -1, biparticion
}
