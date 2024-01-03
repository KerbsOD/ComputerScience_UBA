/*
Input:
  - Multiconjunto C = {c1, ..., cn}
  - Natural k

Output:
  - Subconjunto de C que suma k

Tipos de soluciones:

	Soluciones Candidatas: Vectores a = (a1,...,an) de valores binarios. El subconjunto
	de C representado por a contiene a ci <-> ai = 1.

	Solucion valida: Vector a = (a1,...,an) tal que sum_{i=1}^{n} ai.ci = k

	Solucion parcial: Vector p = (a1,...,ai) de numeros binarios con 0 <= i <= n. Si i < n, las soluciones
	sucesoras de p son pU0 y pU1.

(a)

	Escribir el conjunto de soluciones candidatas para C = {6, 12, 6} y k = 12

	->
	{(1,1,1), (1,1,0), (1,0,1), (0,1,1), (1,0,0), (0,1,0), (0,0,1), (0,0,0)}

(b)

	Escribir el conjunto de soluciones válidas para C = {6, 12, 6} y k = 12

	->
	{(1,0,1), (0,1,0)}

(c)

	Escribir el conjunto de soluciones parciales para C = {6, 12, 6} y k = 12.

	->
	{(1), (1,0), (1,1) (0), (0,1), (0,0)}. Solucion parcial no implica solucion valida.

(d)

(e)

(f)

	2^n, para cada elemento se hacen 2 llamados recursivos.

(g)

	Son muy parecidos :O

(h)

	La regla de factibilidad nos dice que no vale la pena seguir una rama que no va a terminar en una
	solucion valida.

(i)
  - Si la sumatoria de todo lo que falta menos lo actual es mayor a 0 entonces no vale la pena seguir
  porque si nos falta j y lo que nos queda en el array no suma lo suficiente para que j-suma = 0 entonces no
  vale la pena seguir con la rama.
*/

package main

import "fmt"

var soluciones = [][]int{}
var solucion_parcial []int

func subset_sum(C []int, i int, j int, sufijo int) {
	if j < 0 {
		return
	}

	if j-sufijo > 0 {
		return
	}

	if i == -1 {
		if j == 0 {
			copiedSlice := make([]int, len(solucion_parcial))
			copy(copiedSlice, solucion_parcial)
			soluciones = append(soluciones, copiedSlice)
		}
		return
	}

	solucion_parcial = append(solucion_parcial, C[i])
	subset_sum(C, i-1, j-C[i], sufijo-C[i])
	solucion_parcial = solucion_parcial[:len(solucion_parcial)-1]
	subset_sum(C, i-1, j, sufijo)
}

func main() {
	ejemplo := []int{6, 12, 6}

	sufijo := 0
	for _, v := range ejemplo {
		sufijo += v
	}

	subset_sum(ejemplo, len(ejemplo)-1, 12, sufijo)
	fmt.Println(soluciones)
}
