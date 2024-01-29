package Practica3_Arboles

import (
	"reflect"
	"testing"
)

func TestVacio(t *testing.T) {
	r := 1
	aristas := [][]int{
		{},
		{},
	}

	loopStart, biparticion := bipartito(r, aristas)

	if loopStart != -1 {
		t.Error("Graph doesn't have a loop\n")
	}

	if reflect.DeepEqual(biparticion, []int{-1, 0}) == false {
		t.Error("Wrong bipartition")
	}
}

func TestGrafoBipartito(t *testing.T) {
	r := 1
	aristas := [][]int{
		{},
		{2, 3, 7},
		{1, 4, 5},
		{1, 5, 6},
		{2, 7},
		{2, 3, 8, 7},
		{3, 8, 9},
		{1, 4, 5},
		{5, 6},
		{6},
	}

	loopStart, biparticion := bipartito(r, aristas)

	if loopStart != -1 {
		t.Error("Graph doesn't have a loop\n")
	}

	if reflect.DeepEqual(biparticion, []int{-1, 0, 1, 1, 0, 0, 0, 1, 1, 1}) == false {
		t.Error("Wrong bipartition")
	}
}

func TestGrafoNoBipartito(t *testing.T) {
	r := 1
	aristas := [][]int{
		{},
		{2, 3, 7},
		{1, 4, 5},
		{1, 5, 6},
		{2, 7},
		{2, 3, 8, 7},
		{3, 8, 9},
		{1, 4, 5},
		{5, 6, 3},
		{6},
	}

	loopStart, padre := bipartito(r, aristas)

	if loopStart != 3 {
		t.Errorf("Graph does have a loop. LoopStart: %v, answer: 3\n", loopStart)
	}

	expected := []int{-1, 0, 1, 5, 2, 7, 3, 4, 6, 6}
	if reflect.DeepEqual(padre, expected) == false {
		t.Errorf("Wrong loop!\n Expected: %d\n Given: %d\n", expected, padre)
	}
}
