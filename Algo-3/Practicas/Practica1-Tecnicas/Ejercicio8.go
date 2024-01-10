/*
	El problema de la vara.
	- Costo de cortar una vara de longitud l es l.

	Ejemplo:
		Vara de 10 metros que debe ser cortada en {2,4,7}.
		Los cortes se deben hacer a partir de ele xtremo. O sea, si la vara tiene 10 metros, cada metro
		es uno de las posiciones donde se debe hacer el corte.
		(lo explico porque me costo entenderlo, hay que separar la vara pero seguimos
		cortando siempre sobre la misma vara, solo cambian los costos!)

		|----------| <- Vara de 10 metros
		|--||--------| <- vara de 2 metros y de 8 metros (cortamos en la posicion 2)
		|--||--||------| <- vara de 2 metros, de 2 metros y de 6 metros (cortamos en la posicion 4)
		|--||--||---||---| <- vara de 2 metros, de 2 metros y de 6 metros (cortamos en la posicion 7)


*/

package main

func cortarVara(i int, j int, C []int, M [][]int) int {
	if j <= i {
		M[i][j] = 0
	}

	if M[i][j] == -1 {
		costoMinimoCorte := inf
		existeAlgunCorte := false

		for _, c := range C {
			if i < c && c < j {
				existeAlgunCorte = true
				costoMinimoCorte = min(costoMinimoCorte, cortarVara(i, c, C, M)+cortarVara(c, j, C, M))
			}
		}

		if existeAlgunCorte {
			M[i][j] = j - i + costoMinimoCorte
		} else {
			M[i][j] = 0
		}
	}

	return M[i][j]
}

/*
	Nuestro caso base en el algoritmo top-down es que si j <= i devolvemos 0. Si mi palo mide desde 4 a 10, no puedo pedir por ejemplo
	el costo de cortar en 2. o sea, pedir costo = min(costo, f(4,2)+f(2,10)). Porque en nuestro mundo es imposible calcular el costo f(4,2).
	Solo podemos entre 4 y 10.
	Entonces si j <= i, devolvemos 0. No podemos calcular el corte.

	Sabiendo esto, en el algoritmo Bottom-Up llenamos todos los casilleros donde j <= i con 0 y el resto con infinito.

	Ejemplo con l = 4 y C = {2, 3} (son 5 posiciones porque estamos 0-indexados)

	  __0____1_____2_____3_____4___
	0 | 0 | inf | inf | inf | inf |
	1 | 0 | 0   | inf | inf | inf |
	2 | 0 | 0   | 0   | inf | inf |
	3 | 0 | 0   | 0   | 0   | inf |
	4 | 0 | 0   | 0   | 0   | 0   |
	  -----------------------------

	Luego por definicion del algoritmo top down sabemos que:

	M[i][j] = min(M[i][j], M[i][c]+M[c][j]) para todo c perteneciente a C, i < c < j

	Supongamos que i = 0, j = 3 y c = 2. La llamada seria la siguiente.
	M[0][3] = min(M[0][3], M[0][2]+M[2][3])

	Para poder calcular M[0][3] necesitamos M[0][2] y M[2][3]. Por eso el loop va de j = 0 a l y de i = j-1 a 0. Gracias a este loop
	se calula la matriz de izquierda a derecha, de abajo para arriba.
	Hagamos una simulacion de que pasa cuando arrancamos el loop hasta j = 3 e i = 0.

	j = 0, i = -1

	j = 1, i = 0 -> M[0][1] = 0

	j = 2, i = 1 -> M[1][2] = 0
	j = 2, i = 0 -> M[0][2] = 0

	j = 3, i = 2 -> M[2][3] = 0
	j = 3, i = 1 -> M[1][3] = 0
	j = 3, i = 0 -> M[0][3] = min(M[0][3], M[0][2]+M[2][3]) + 3-0. Como existe un c entre 0 y 3 (c=2), se hace la cuenta y gracias a que calculamos
	 														 las "dependencias" de M[0][3] vamos a poder hacer la cuenta :)

	  __0____1_____2_____3_____4___
	0 | 0 | 0   | 0   | 3   | inf |
	1 | 0 | 0   | 0   | 0   | inf |
	2 | 0 | 0   | 0   | 0   | inf |
	3 | 0 | 0   | 0   | 0   | inf |
	4 | 0 | 0   | 0   | 0   | 0   |
	  -----------------------------

*/

func cortarVaraBU(l int, C []int, M [][]int) int {
	for i := 0; i <= l; i++ {
		for j := 0; j <= l; j++ {
			if j <= i {
				M[i][j] = 0
			} else {
				M[i][j] = inf
			}
		}
	}

	for j := 0; j <= l; j++ {
		for i := j - 1; i >= 0; i-- {
			existeAlgunCorte := false
			for _, c := range C {
				if i < c && c < j {
					existeAlgunCorte = true
					M[i][j] = min(M[i][j], M[i][c]+M[c][j])
				}
			}

			if existeAlgunCorte {
				M[i][j] += j - i
			} else {
				M[i][j] = 0
			}
		}
	}

	return M[0][l]
}
