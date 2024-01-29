package Practica3_Arboles

import "fmt"

type Arista struct {
	u int
	v int
}

func DFS(u int, p int, l int, adj [][]int, visited []bool, level []int, minLevel []int) []Arista {
	visited[u] = true
	level[u] = l
	minLevel[u] = l
	treeEdges := []Arista{}

	for _, v := range adj[u] {
		if v == p {
			continue
		}

		if visited[v] == false {
			treeEdges = append(treeEdges, Arista{u, v})
			treeEdges = append(treeEdges, DFS(v, u, l+1, adj, visited, level, minLevel)...)
			minLevel[u] = min(minLevel[u], minLevel[v])
		} else {
			minLevel[u] = min(minLevel[u], level[v])
		}
	}

	return treeEdges
}

func Puentes(r int, aristas [][]int) {
	n := len(aristas)
	visited := make([]bool, n)
	level := make([]int, n)
	minLevel := make([]int, n)

	dfsTree := DFS(r, -1, 0, aristas, visited, level, minLevel)

	for _, e := range dfsTree {
		if minLevel[e.u] < minLevel[e.v] {
			fmt.Printf("%v es puente\n", e)
		}
	}
}
