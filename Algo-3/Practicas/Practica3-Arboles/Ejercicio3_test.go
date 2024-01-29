package Practica3_Arboles

import (
	"reflect"
	"testing"
)

func TestOrientar(t *testing.T) {
	aristas := [][]int{
		{},
		{5, 4},
		{5, 6},
		{6, 7},
		{1, 8},
		{1, 8, 2, 9},
		{2, 9, 3, 10},
		{3, 10},
		{4, 5},
		{5, 6},
		{6, 7},
	}

	answer := [][]int{
		{},
		{4},
		{6},
		{7},
		{8},
		{1, 2},
		{9, 3},
		{10},
		{5},
		{5},
		{6},
	}

	result := orientar(aristas, 5)

	if reflect.DeepEqual(result, answer) == false {
		t.Errorf("\nExpected: %v\n Given: %v\n", answer, result)
		return
	}
}
