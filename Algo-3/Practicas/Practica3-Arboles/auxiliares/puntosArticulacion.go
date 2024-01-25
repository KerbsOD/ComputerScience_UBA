package auxiliares

func DFS(u int, padre int, nivel int, visitado []bool, nivelDe []int, minimoNivelDe []int, vecinosDe [][]int, puntos []bool) {
	visitado[u] = true
	nivelDe[u] = nivel
	minimoNivelDe[u] = nivel
	hijos := 0

	for _, v := range vecinosDe[u] {

		// Si el vecinos que estoy visitando es mi padre, lo ignoro
		if v == padre {
			continue
		}

		// Si el vecino que estoy visitando es un backedge, mi minimo nivel sera el minimo entre mi minimo nivel y el nivel del backedge
		if visitado[v] == true {
			minimoNivelDe[u] = min(minimoNivelDe[u], nivelDe[v])
		}

		// Si el vecino que estoy visitando es un tree edge...
		if visitado[v] == false {
			// Lo recorro
			DFS(v, u, nivel+1, visitado, nivelDe, minimoNivelDe, vecinosDe, puntos)
			hijos++

			// Mi minimo nivel sera el minimo entre mi minimo actual y hasta el fondo de lo minimo de la rama.
			minimoNivelDe[u] = min(minimoNivelDe[u], minimoNivelDe[v])

			// Si el minimo nivel de la rama no llega a ser menorque mi nivel => no hay descendiente mio conectado con un ancestro mio.
			if minimoNivelDe[v] >= nivelDe[u] && padre != -1 {
				puntos[u] = true
			}
		}
	}

	// Caso borde para la raiz
	if padre == -1 && hijos > 1 {
		puntos[u] = true
	}
}

// Backedge vw con nivel(v) < nivel(w) => v es ancestro de w
// Las hojas de T no son puntos de articulacion
// La raiz de T es punto de articulacion si d(r) > 1
// Si v no es hoja ni raiz entonces es punto de articulacion para vw <-> no existe descendiendte de w que conecte con un ancestro de v.
