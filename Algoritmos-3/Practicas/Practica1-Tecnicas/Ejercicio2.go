/*
(A) Con fuerza bruta probariamos todas las combinaciones y luego chequeariamos cada solucion candidata para
ver si es o no un cuadrado magico. Generariamos todas las posbibildiades.

Empezamos con un cuadrado magico vacio de la forma:
0|0|0
0|0|0
0|0|0

Luego para el primer casillero tenemos 9 posibilidades (del 1 al 9), ponemos el 1:
1|0|0
0|0|0
0|0|0

Luego para el segundo casillero tenemos nuevamente 9 posibildiades (del 1 al 9) porque fuerza bruta prueba
TODAS las combinaciones, no se para a pensar si el 1 ya lo use o no.
1|1|0
0|0|0
0|0|0

Esto nos da una complejidad de (n^2)^(n^2). Para cada casillero (n^2 casilleros) tenemos n^2 numeros que
ponerle.


(B)
	- La solucion parcial esta completa de izquierda a derecha de arriba a abajo (los profes son unos hdps al
	  enunciarlo en chino)
	- Para el siguiente cuadrado disponible se prueban todos los numeros que no esten usados

	No voy a dibujar el arbol en los comentarios xd

(C)
	Al inicio tenemos el cuadrado vacio. Para la primera casilla tenemos n^2 posibilidades. Luego
	como la primer casilla se mantiene y NO SE PUEDEN REPETIR NUMEROS, para la segunda casilla hay n^2 - 1
	posibilidades asi hasta completar cada casilla con un numero diferente.

	Aclaro que cuando digo que la primer casilla se mantiene me refiero a que para esa solucion parcial,
	el numero de la primer casilla queda fijo. Luego hay soluciones parciales que tienen otro numero en la
	primer casilla. Pero traten de mirarlo por el lado de combinatoria (vector de posbiles valores).

	Si repetimos la cuenta para cada casilla tendremos que para la primer casilla hay n^2 posibles numeros.
	Para la segunda casilla hay n^2 - 1 posibles numeros.
	Para la tercer casilla hay n^2 - 2 posibles numeros.

	o sea,

	(n^2) * (n^2 - 1) * (n^2 - 2) * ... * (n^2 - (n^2 - 1)) = (n^2)!

(D)

*/

package main

func esCuadrado(n int, solucionParcial [][]int) int {
	magicNumber := 0
	for i := range solucionParcial {
		magicNumber += solucionParcial[i][0]
	}

	for i := 0; i < n; i++ {
		rowSum := 0
		colSum := 0
		for j := 0; j < n; j++ {
			rowSum += solucionParcial[i][j]
			colSum += solucionParcial[j][i]
		}

		if rowSum != magicNumber || colSum != magicNumber {
			return 0
		}
	}

	diagA := 0
	diagB := 0
	for i := 0; i < n; i++ {
		diagA += solucionParcial[i][i]
		diagB += solucionParcial[i][n-i-1]
	}

	if diagA != magicNumber || diagB != magicNumber {
		return 0
	}

	return 1
}

func cuadradoMagico1(i int, j int, n int, numeroUsado []bool, solucionParcial [][]int) int {
	if j == n {
		return cuadradoMagico1(i+1, 0, n, numeroUsado, solucionParcial)
	}

	if i == n {
		return esCuadrado(n, solucionParcial)
	}

	res := 0
	for x := 0; x < n*n; x++ {
		if numeroUsado[x] {
			continue
		}

		numeroUsado[x] = true
		solucionParcial[i][j] = x + 1
		res += cuadradoMagico1(i, j+1, n, numeroUsado, solucionParcial)

		numeroUsado[x] = false
	}

	return res
}

func cuadradoMagico2(i int, j int, n int, magicNumber int, solucionParcial [][]int, numeroUsado []bool, sumaParcialFilas []int, sumaParcialColumnas []int) int {
	if j == n {
		return cuadradoMagico2(i+1, 0, n, magicNumber, solucionParcial, numeroUsado, sumaParcialFilas, sumaParcialColumnas)
	}

	if i == n {
		return esCuadrado(n, solucionParcial)
	}

	res := 0
	for x := 0; x < n*n; x++ {
		if numeroUsado[x] {
			continue
		}

		if sumaParcialFilas[i]+x+1 > magicNumber {
			continue
		}

		if sumaParcialColumnas[j]+x+1 > magicNumber {
			continue
		}

		numeroUsado[x] = true
		solucionParcial[i][j] = x + 1
		sumaParcialFilas[i] += x + 1
		sumaParcialColumnas[j] += x + 1

		res += cuadradoMagico2(i, j+1, n, magicNumber, solucionParcial, numeroUsado, sumaParcialFilas, sumaParcialColumnas)

		numeroUsado[x] = false
		solucionParcial[i][j] = 0
		sumaParcialFilas[i] -= x + 1
		sumaParcialColumnas[j] -= x + 1
	}

	return res
}
