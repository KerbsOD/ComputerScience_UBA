package auxiliares

func DFS(u int, padre int, nivel int, visitado []bool, nivelDe []int, minimoNivelDe []int, vecinosDe [][]int, puntos []bool) {
	visitado[u] = true
	nivelDe[u] = nivel
	minimoNivelDe[u] = nivel
	hijos := 0

	for _, v := range vecinosDe[u] {
		if v == padre {
			continue
		}

		if visitado[v] == true {
			minimoNivelDe[u] = min(minimoNivelDe[u], nivelDe[v])
		}

		if visitado[v] == false {
			DFS(v, u, nivel+1, visitado, nivelDe, minimoNivelDe, vecinosDe, puntos)
			hijos++

			minimoNivelDe[u] = min(minimoNivelDe[u], minimoNivelDe[v])

			if minimoNivelDe[v] >= nivelDe[u] && padre != -1 {
				puntos[u] = true
			}
		}
	}

	if padre == -1 && hijos > 1 {
		puntos[u] = true
	}
}
