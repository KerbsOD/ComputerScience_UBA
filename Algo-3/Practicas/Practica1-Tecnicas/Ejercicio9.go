package main

/*
	Se resta para saber cuantas vidas necesitamos, si la cuenta es negativa (M[i][j] <= 0) entonces implica que no se necesitan vidas
	para pasar por la casilla [i][j] hasta la [n][m]. Por eso escribimos M[i][j] = 1. Necesitamos COMO MUCHO 1 vida para hacer el camino
	desde [i][j]. (Porque si tenes menos de 1 vida estas muerto :p).

	Luego el caso base es estar justo en el ultimo casillero, si estamos en el ultimo casillero llegamos.
	Como sabemos si estamos en el ultimo casillero? Recordemos que las llamadas a la funcion son f(i+1, j) y f(i,j+1), O sea que NUNCA
	vamos a llegar al casillero f(n,m). Solo vamos a llegar al f(n,m-1) y al f(n-1,m) aka f(i==n, j+1 == m) y f(i+1==n, j == m).
	Cuando detectemos que llegamos al final, devolvemos 0.

	Luego si estamos en la casilla [0][0], sumamos 1. Porque el algoritmo nos dice cual es el camino que saca menos vidas, enntonces necesitamos
	1 vida mas para poder pasarlo y no quedar en 0.
*/

// const inf int = math.MaxInt32 >> 8

func minVida(i int, j int, n int, m int, A [][]int, M [][]int) int {
	if (i == n && j+1 == m) || (i+1 == n && j == m) {
		return 0
	}

	if i == n || j == m {
		return inf
	}

	if M[i][j] == -1 {
		M[i][j] = min(minVida(i+1, j, n, m, A, M), minVida(i, j+1, n, m, A, M)) - A[i][j]
		if M[i][j] <= 0 {
			M[i][j] = 1
		}
	}

	if i == 0 && j == 0 {
		return M[i][j] + 1
	}

	return M[i][j]
}

/*
	M[i][j] depende de M[i+1][j] y M[j][i+1].
	Seteamos la matriz con el caso base del algoritmo topdown. Como i empieza en n-1 y j empieza en m-1, la primer llamada sera
	M[n-1][m-1] = min( M[n][m-1], M[n-1][j] ) - A[n-1][m-1]. Por lo que necesitamos que esas posiciones tengan un valor default,  en este
	caso es 0.

	Nuevamente sumamos 1 al return para que nos de la cantidad de vidas minimas.
*/

func minVidaBU(n int, m int, A [][]int, M [][]int) int {
	M[n][m-1] = 0
	M[n-1][m] = 0

	for i := n - 1; i >= 0; i-- {
		for j := m - 1; j >= 0; j-- {
			M[i][j] = min(M[i+1][j], M[i][j+1]) - A[i][j]
			if M[i][j] <= 0 {
				M[i][j] = 1
			}
		}
	}

	return M[0][0] + 1
}

/*
	Es un algoritmo feo, lo se. Cursed. No supe interpretar lo de O(min(n,m)) asi que lo hice a mi manera. Creando un arreglo para cada caso
	y operando sobre este.

	Hagamos una simulacion del algoritmo bottom-up del enunciado d. Con n = 3 y m = 3. Se empieza con i = 2 y j = 2.

	M[i][j]:

	M[2][2] = min( M[3][2], M[2][3] ) --> M[2][2] depende de M[3][2] y M[2][3] que son posiciones indefinidas, devuelven 0.
	M[2][1] = min( M[3][1], M[2][2] ) --> M[2][1] depende de M[3][1] y M[2][2]. La primera una posicion indefinida y la segunda la calculamos previamente.
	M[2][0] = min( M[3][0], M[2][1] ) --> M[2][0] depende de M[3][0] y M[2][1]. La primera una posicion indefinida y la segunda la calculamos previamente.

	M[1][2] = min( M[2][2], M[1][3] ) --> M[1][2] depende de M[2][2] y M[1][3]. La primera la calulamos antes y la segunda esta indefinida.
	M[1][1] = min( M[2][1], M[1][2] ) --> M[1][1] depende de M[2][1] y M[1][2]. La primera la calulamos antes y la segunda la calculamos previamente.
	M[1][0] = min( M[2][0], M[1][1] ) --> M[1][0] depende de M[2][0] y M[1][1]. La primera la calulamos antes y la segunda la calculamos previamente.

	M[0][2] = min( M[1][2], M[0][3] ) --> M[0][2] depende de M[1][2] y M[0][3]. La primera la calulamos antes y la segunda esta indefinida.
	M[0][1] = min( M[1][1], M[0][2] ) --> M[0][1] depende de M[1][1] y M[0][2]. La primera la calulamos antes y la segunda la calculamos previamente.
	M[0][0] = min( M[1][0], M[0][1] ) --> M[0][0] depende de M[1][0] y M[0][1]. La primera la calulamos antes y la segunda la calculamos previamente.

	Hay un patron, no?
   i\j_0_1_2
	0|_|_|_|
	1|_|_|_|
	2|_|_|_|

	(1) se usa la posicion [2][2] que depende de 2 casos borde. (fuera de la matriz)
	(2) Se usa la posicion [2][1] que depende de la posicion [2][2] y nuevamente de un caso borde (fuera de la matriz)
	(3) Se usa la posicion [2][0] que depende de la posicion [2][1] y nuevamente de un caso borde (fuera de la matriz)

	(4) Se usa la posicion [1][2] que depende de la posicion [2][2] y nuevamente de un caso borde (fuera de la matriz)
	(5) Se usa la posicion [1][1] que depende de la posicion [2][1] y [1][2].

	Si se dan cuenta, luego de usar la posicion [2][2] para calcular [1][2], la posicion [2][2] NO SE USA NUNCA MAS.
	Ademas, para calcular [1][1] se usa la posicion [1][2] que la calculamos previamente y la [2][1]. Pero despues de este calculo
	la posicion [2][1] NO SE USA NUNCA MAS.

	Esto que me dice? Podemos reciclar filas. Podemos sobrescribir las filas. Porque una vez usado [2][2] para calcular [1][2], no se usa
	nunca mas. Asi que en vez de guardar [1][2] en su propia casilla vamos a pegarla arriba de [2][2].

	-> La posicion m de la matriz la guardamos para los casos indefinidos. O sea cuando i == n o j == m.
	n = 3
	m = 3
	M = [_,_,_,0]

	Si n < m, iteramos nuestro arreglo con i. Caso contrario iteramos con j.
	Notar que el tamaño del arreglo es igual al minimo entre n y m.
	Si n < m entonces el arreglo M sera de columnas. Empezando por la columna de la derecha del todo.
	Si m >= n entoences el arreglo M sera de filas. Empezano por la fila de abajo el todo.

	A = [[-2,-3,3],
		 [-5,-10,1],
		 [10,30,-5]]

	M = [inf, inf, inf, 0]

	i = 2 y j = 2
	M[2] = min( M[2], M[3] ) - A[2][2] = 0 - (-5) = 5
	M = [inf, inf, 5, 0]

	i = 1 y j = 2
	M[1] = min( M[1], M[2] ) - A[1][2] = 5 - (1) = 4
	M = [inf, 4, 5, 0]

	i = 0 y j = 2
	M[0] = min( M[0], M[1] ) - A[0][2] = 4 - (3) = 1
	M = [1, 4, 5, 0]

	i = 2 y j = 1
	M[2] = min( M[2], M[3] ) - A[2][1] = 0 - 30 = -30 (como es negativo ponemos 1, como dice el enunciado)
	M = [1, 4, 1, 0]

	i = 1 y j = 1
	M[1] = min( M[1], M[2] ) - A[1][1] = 1 - (-10) = 11
	M = [1, 11, 1, 0]

	i = 0 y j = 1
	M[0] = min( M[0], M[1] ) - A[0][1] = 1 - (-3) = 4
	M = [4, 11, 1, 0]

	i = 2 y j = 0
	M[2] = min( M[2], M[3] ) - A[2][0] = 0 - 10 = -10 (como es negativo ponemos 1)
	M = [4, 11, 1, 0]

	i = 1 y j = 0
	M[1] = min( M[1], M[2] ) - A[1][0] = 1 - (-5) = 6
	M = [4, 6, 1, 0]

	i = 0 y j = 0
	M[0] = min( M[0], M[1] ) - A[0][0] = 4 - (-2) = 6
	M = [6, 6, 1, 0]

	Luego devolvemos M[0][0] + 1 y obbtenemos 7!
	Podemos ir sobreescribiendo el mismo vector y no afecta en nada!
*/

func minVidaBUV2(n int, m int, A [][]int) int {

	// n es mayor a m
	if n < m {
		M := make([]int, n+1)
		for i := 0; i < n; i++ {
			M[i] = inf
		}
		M[n] = 0

		for j := m - 1; j >= 0; j-- {
			for i := n - 1; i >= 0; i-- {
				M[i] = min(M[i], M[i+1]) - A[i][j]
				if M[i] <= 0 {
					M[i] = 1
				}
			}
		}

		return M[0] + 1

	}

	// m es mayor o igual a n
	M := make([]int, m+1)
	for i := 0; i < m; i++ {
		M[i] = inf
	}
	M[m] = 0

	for i := n - 1; i >= 0; i-- {
		for j := m - 1; j >= 0; j-- {
			M[j] = min(M[j], M[j+1]) - A[i][j]
			if M[j] <= 0 {
				M[j] = 1
			}
		}
	}

	return M[0] + 1
}

// func main() {
// 	n := 1000
// 	m := 500

// 	A := make([][]int, n+1)
// 	for i := 0; i <= n; i++ {
// 		A[i] = make([]int, m+1)
// 		for j := 0; j <= m; j++ {
// 			A[i][j] = (j + 1) * (i + 1) * (-1 + ((j % 2) * 2))
// 			if A[i][j]%4 == 0 {
// 				A[i][j] *= 6
// 			} else {
// 				A[i][j] *= 12
// 			}
// 		}
// 	}

// 	// A := [][]int{{-2, -3, 3}, {-5, -10, 1}, {10, 30, -5}}

// 	M := make([][]int, n+1)
// 	for i := 0; i <= n; i++ {
// 		M[i] = make([]int, m+1)
// 		for j := 0; j <= m; j++ {
// 			M[i][j] = -1
// 		}
// 	}

// 	timeStart := time.Now()
// 	resultado := minVida(0, 0, n, m, A, M)
// 	timeStop := time.Since(timeStart)
// 	fmt.Printf("MinimasVidas Top-Down \nResultado: %v \nTiempo: %v \n", resultado, timeStop)

// 	fmt.Println()
// 	for i := 0; i <= n; i++ {
// 		for j := 0; j <= m; j++ {
// 			M[i][j] = -1
// 		}
// 	}

// 	timeStart = time.Now()
// 	resultado = minVidaBU(n, m, A, M)
// 	timeStop = time.Since(timeStart)
// 	fmt.Printf("MinimasVidas Bottom-Up \nResultado: %v \nTiempo: %v \n", resultado, timeStop)

// 	fmt.Println()

// 	timeStart = time.Now()
// 	resultado = minVidaBUV2(n, m, A)
// 	timeStop = time.Since(timeStart)
// 	fmt.Printf("MinimasVidas Bottom-Up Optimizado \nResultado: %v \nTiempo: %v \n", resultado, timeStop)
// }
