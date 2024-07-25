package auxiliares

import (
	"testing"
)

func TestMuchosPuntosDeArticulacion(t *testing.T) {
	n := 11
	visitado := make([]bool, n+1)
	nivelDe := make([]int, n+1)
	minimoNivelDe := make([]int, n+1)
	vecinosDe := [][]int{
		{},              // 0
		{2, 3, 4, 5, 8}, // 1
		{1},             // 2
		{1, 6, 9},       // 3
		{1},             // 4
		{1, 7, 8},       // 5
		{3, 9, 10, 11},  // 6
		{5},             // 7
		{5, 1},          // 8
		{6, 3},          // 9
		{6, 11},         // 10
		{10, 6},         // 11
	}

    answer := []bool{false, true, false, true, false, true, true, false, false, false, false, false}
	puntos := make([]bool, n+1)
	DFS(1, -1, 0, visitado, nivelDe, minimoNivelDe, vecinosDe, puntos)
    
    for i := 0; i < n+1; i++ {
        if answer[i] == false && puntos[i] == true {
            t.Errorf("%v no es un punto de articulacion!", i)
        }

        if answer[i] == true && puntos[i] == false {
            t.Errorf("%v es un punto de articulacion!", i)
        }
    }
}

func TestPocosPuntosDeArticulacion(t *testing.T) {
	n := 8
	visitado := make([]bool, n+1)
	nivelDe := make([]int, n+1)
	minimoNivelDe := make([]int, n+1)
	vecinosDe := [][]int{
		{},           // 0
		{2, 3},       // 1
		{3, 1},       // 2
		{4, 5, 2, 1}, // 3
		{3},          // 4
		{6, 3, 7, 8}, // 5
		{8, 5},       // 6
		{5},          // 7
		{5, 6},       // 8
	}

    answer := []bool{false, false, false, true, false, true, false, false, false}
	puntos := make([]bool, n+1)
	DFS(1, -1, 0, visitado, nivelDe, minimoNivelDe, vecinosDe, puntos)

    for i := 0; i < n+1; i++ {
        if answer[i] == false && puntos[i] == true {
            t.Errorf("%v no es un punto de articulacion!", i)
        }

        if answer[i] == true && puntos[i] == false {
            t.Errorf("%v es un punto de articulacion!", i)
        }
    }
}
