package Practica3_Arboles

import "testing"

func TestHayPuentes(t *testing.T) {
	aristas := [][]int{
		{},
		{2, 3},
		{1, 3},
		{1, 2, 4},
		{3, 5},
		{4, 6, 7},
		{5, 8},
		{5},
		{6, 9},
		{8, 6},
	}

	Puentes(1, aristas)
}
