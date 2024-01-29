package auxiliares

import (
	"sort"
)

type Edge struct {
	Src, Dest, Weight int
}

type Graph struct {
	Edges    []Edge
	Vertices int
}

type Subset struct {
	Parent int
	Rank   int
}

func find(subsets []Subset, i int) int {
	if subsets[i].Parent != i {
		subsets[i].Parent = find(subsets, subsets[i].Parent)
	}
	return subsets[i].Parent
}

func union(subsets []Subset, x, y int) {
	rootX := find(subsets, x)
	rootY := find(subsets, y)
	if subsets[rootX].Rank < subsets[rootY].Rank {
		subsets[rootX].Parent = rootY
	} else if subsets[rootX].Rank > subsets[rootY].Rank {
		subsets[rootY].Parent = rootX
	} else {
		subsets[rootY].Parent = rootX
		subsets[rootX].Rank++
	}
}

func kruskals(graph Graph) []Edge {
	sortedEdges := make([]Edge, len(graph.Edges))
	copy(sortedEdges, graph.Edges)
	sort.Slice(sortedEdges, func(i, j int) bool {
		return sortedEdges[i].Weight < sortedEdges[j].Weight
	})
	subsets := make([]Subset, graph.Vertices)
	for i := range subsets {
		subsets[i].Parent = i
		subsets[i].Rank = 0
	}
	result := make([]Edge, 0, graph.Vertices-1)
	for _, edge := range sortedEdges {
		srcRoot := find(subsets, edge.Src)
		destRoot := find(subsets, edge.Dest)
		if srcRoot != destRoot {
			result = append(result, edge)
			union(subsets, srcRoot, destRoot)
		}
	}
	return result
}
