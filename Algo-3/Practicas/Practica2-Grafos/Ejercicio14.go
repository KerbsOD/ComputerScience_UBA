package main

import "fmt"

var visited []bool
var vecinos [][]int
var padres []int

func buscarCiclo(u int) []int {
	if visited[u] {
		return []int{u}
	}

	visited[u] = true
	ramas := []int{}
	for _, v := range vecinos[u] {
		ramas = append(ramas, buscarCiclo(v)...)
		if len(ramas) != 0 {
			ramas = append(ramas, u)
			break
		}
	}

	return ramas
}

func main() {
	n := 8
	vecinos = [][]int{
		{4},
		{0},
		{1},
		{2, 4},
		{6},
		{},
		{5, 7},
		{}}
	visited = make([]bool, n)
	padres = make([]int, n)

	sinCiclo := []int{}
	for i := 0; i < n; i++ {
		if len(vecinos[i]) == 0 {
			sinCiclo = append(sinCiclo, i)
		}
	}

	ciclo := buscarCiclo(0)

	if len(ciclo) == 0 {
		fmt.Println(sinCiclo)
	} else {
		fmt.Println(ciclo)
	}

}
