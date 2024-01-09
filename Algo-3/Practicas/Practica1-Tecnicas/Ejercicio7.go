/*
	p es una lista con el precio de un asteroide por dia.
	pi es el precio de un asteroide el iesimo dia en una secuencia de n dias.
	Se quiere comprar y vender obteniendo la mayor ganancia
	Se puede comprar 1 asteroide por dia
	Se puede vender 1 asteroide por dia
	Se empieza sin asteroides
	No se pueden vender asteroides que no tenemos

	Notar:
		En la solucion optima se venden TODOS los asteroides.
		No se compra y vende el mismo dia. Gastariamos x y ganariamos x. x-x = 0

	Ejemplo 1:
		Si p = (3,2,5,6) entonces la ganancia = 6.
		Se compra en el dia 1 y 2 (a precio 3 y 2 respectivamente) y se venden los dias 3 y 4 (a
		precio 5 y 6 respectivamente).
		(-3) + (-2) + 5 + 6 = 6

	Ejemplo 2:
		Si p = (3,6,10) entonces la ganancia = 7
		Se compra el dia 1 (a 3) y se vende el dia 3 (a 10).
		(-3) + 10 = 7
*/

package main

import (
	"math"
)

func AstroVoid(j int, c int, p []int, M [][]int) int {
	if c < 0 || c > j {
		return math.MinInt32 + 10000 // Inifinito y evitamos overflow (en go hay overflow?)
	}

	if j == 0 {
		return 0
	}

	if M[j-1][c] == -1 {
		comprar := AstroVoid(j-1, c-1, p, M) - p[j-1]
		vender := AstroVoid(j-1, c+1, p, M) + p[j-1]
		pasar := AstroVoid(j-1, c, p, M)
		M[j-1][c] = max(comprar, vender, pasar)
	}

	return M[j-1][c]
}
