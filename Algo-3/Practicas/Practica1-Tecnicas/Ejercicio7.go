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

/*
	Parametros:
		- j representa al dia
		- c representa a la cantidad de asteroides en posesion de AstroVoid
		- p es nuestra lista de precios de tamaño n.
		- M tiene que ser una matriz de (n+1)*(n+1) con el valor menosInf.

	Llamada:
		El problema se soluciona con la llamada AstroVoid(n,0).
		Como se calcula por dia, llamamos a la funcion con n. Luego nos dara el maximo entre
		AstroVoid(n-1,0-1)-p[n-1], Astrovoid(n-1,0) y AstroVoid(n-1,0+1)+p[n-1],
		y lo guardara en M[n][0].

		Recordemos que la lista de precios es 0-indexada por lo que va desde 0 a n-1.

		comprar := AstroVoid(j-1, c-1, p, M) - p[j-1].
		Ayer (j-1) compramos un asteroide por lo que la cantidad de asteroides que TENIAMOS AYER
		es uno menos que la que tenemos hoy.
		Entonces hoy tenemos menos plata porque ayer compramos.

		vender := AstroVoid(j-1, c+1, p, M) + p[j-1].
		Ayer (j-1) vendimos un asteroide por lo que la cantidad de asteroides que TENIAMOS AYER
		es uno mas que la que tenemos hoy.
		Entonces hoy tenemos mas plata porque ayer vendimos.

	Indefinidos:
		- c < 0: La cantidad de asteroides que tenemos es negativa. Absurdo, no podemos vender
		asteroides que no tenemos. (Por enunciado)
		- c > j: La cantidad de asteroides que tenemos es mayor a el dia actual. Absurdo, solo se puede
		comprar un asteroide por dia por lo que es imposible tener mas asteroides que dias.
*/

func AstroVoid(j int, c int, p []int, M [][]int) int {
	if c < 0 || c > j {
		return menosInf
	}

	if j == 0 && c == 0 {
		return 0
	}

	if M[j][c] == menosInf {
		comprar := AstroVoid(j-1, c-1, p, M) - p[j-1]
		pasar := AstroVoid(j-1, c, p, M)
		vender := AstroVoid(j-1, c+1, p, M) + p[j-1]
		M[j][c] = max(comprar, pasar, vender)
	}

	return M[j][c]
}

/*
	Siendo comprar = M[j-1][c-1]-p[j-1], vender = M[j-1][c+1]+p[j-1] y pasar = M[j-1][c]. Los
	estados posibles de la matriz son los siguientes:
		- M[j][c] = -inf 						<---> c < 0 o c > j
		- M[j][c] = 0 							<---> j == 0 y c == 0
		- M[j][c] = max(comprar, pasar, vender) caso contrario

	1 <= j <= n: Necesitamos cubrir todos los valores desde 0 a n.
	0 <= c <= j: Necesitamos que c valga 0 y valga n, especialmente los casos donde c = 0. No queremos,
	             por enunciado, que c sea negativo o que sea mayor a j. Por eso las restricciones.
*/

func AstroVoidBU(M [][]int, p []int, n int) int {
	M[0][0] = 0

	for j := 1; j <= n; j++ {
		for c := 0; c <= j; c++ {
			comprar := menosInf
			pasar := M[j-1][c]
			vender := menosInf

			if c-1 >= 0 {
				comprar = M[j-1][c-1] - p[j-1]
			}

			if c+1 <= j {
				vender = M[j-1][c+1] + p[j-1]
			}

			M[j][c] = max(comprar, pasar, vender)
		}
	}

	return M[n][0]
}
