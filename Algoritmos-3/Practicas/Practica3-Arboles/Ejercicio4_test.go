package Practica3_Arboles

import (
	"reflect"
	"testing"
)

func TestOrientarCalles(t *testing.T) {
	calles := [][]int{
		{},
		{2, 4},
		{1, 5},
		{6},
		{1, 5, 7},
		{2, 4, 8, 6},
		{3, 9, 5},
		{4},
		{5, 9},
		{8, 6},
	}

	result := orientarCalles(calles, 1)
	answer := [][]int{
		{},
		{2},
		{5},
		{},
		{1, 7},
		{4, 8},
		{3, 5},
		{},
		{9},
		{6},
	}

	if reflect.DeepEqual(result, answer) == false {
		t.Errorf("\nExpected: %v\n Given: %v\n", answer, result)
		return
	}
}
