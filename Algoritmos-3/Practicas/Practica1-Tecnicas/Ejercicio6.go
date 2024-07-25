/*
(A)
Input:
  - B valores de billetes
  - c costo de un producto

Output:
  - Pagar con el minimo exceso posible (minimizar perdida)
  - Pagar con el minimo tiempo posible (minimizar tiempo)
  - Tupla (exceso, cantidad) Primero se ordenan por exceso y luego por cantidad de billetes
*/
package main

/*
(A)

	En vez de q podemos optar por un arreglo de soluciones parciales binarias, luego una funcion lineal
	que nos diga el valor. Es medio ineficiente. No se si los profes no tuvieron en cuenta el parametro
	q o querian que lo hagamos de esa manera. Ademas, siento que el problema con programacion dinamica
	esta mal planteado porque en esta funcion hay 3 parametros. i, j y q. Luego hay i*j*q estados.
	Ejemplo:
		B  = {1,1,2,3}
		c  = 5

		Supongamos ahora p y p' siendo los valores binarios del arreglo B. Donde i = 2 y c = 5.
		p  = {1,1,0} -> cc(B, i, j) = cc(B, 2, 3)
		p' = {0,0,1} -> cc(B, i, j) = cc(B, 2, 3)
		A ojos de la funcion son la misma instancia pero los vectores binarios p y p' son completamente
		diferentes.

		Supongamos ahora que llamamos, con memoization, M[2][3]. En vez e la instancias p' = {0,0,1}
		podriamos caer en la instancia p = {1,1,0}.
		En ese caso q = 2 en vez de q = 1.

		Hay una inconsistencia por no tener en cuenta el parametro q en la memoization.

		En mi funcion van a ver que corre bien y van a decir "Fuaa, alto mentiroso este Octo!" pero
		lo que pasa es que mi funcion lo recorre de derecha a izquierda. Si en el test escriben:
		B = {3, 2, 1, 1} y c = 5. La solucion deberia ser exceso=0 y cantidad=2 (porque usamos los billetes
		3 y 2 para sumar 5). Pero la solucion que nos va a dar es exceso=0 y cantidad=3 (porque usamos
		los billetes 1, 1 y 3) Tener en cuenta que es un MULTI-conjunto.

		Por como se recorre, siempre vamos a usar la minima cantidad de billetes. Porque el enunciado
		especifica que se recorre de derecha a izquierda pero no te pide que el arreglo de billetes este
		ordenado. Deberian especificarlo.

(C)

	Complejidad de billetesBT(B,i,j,q): O(2^n)
	Cantidad de instancias: O(n*c)

	O(n*c) << 2^n cuando n tiende a infinito.

	Hay superposicion de subproblemas.
*/
func billetesBT(B []int, i int, j int, q int) (int, int) {
	if j <= 0 {
		if q == 0 {
			return inf, inf
		}
		return (-1) * j, q
	}

	if i == -1 {
		return inf, inf
	}

	excesoAgrego, cantidadAgrego := billetesBT(B, i-1, j-B[i], q+1)
	excesoNoAgrego, cantidadNoAgrego := billetesBT(B, i-1, j, q)

	if excesoAgrego < excesoNoAgrego || (excesoAgrego == excesoNoAgrego && cantidadAgrego < cantidadNoAgrego) {
		return excesoAgrego, cantidadAgrego
	}

	return excesoNoAgrego, cantidadNoAgrego
}

/*
Se resuelve con billetesDP(B, n, j, 0)
*/
type costo struct {
	exceso   int
	cantidad int
}

func billetesDP(B []int, i int, j int, q int, M [][]costo) costo {
	if j <= 0 {
		if q == 0 {
			return costo{inf, inf} // Es un caso borde. Sin esta guarda, devuelve siempre {0,0}
		}
		return costo{(-1) * j, q}
	}

	if i == -1 {
		return costo{inf, inf}
	}

	if M[i][j].cantidad == -1 {
		agrego := billetesDP(B, i-1, j-B[i], q+1, M)
		noAgrego := billetesDP(B, i-1, j, q, M)

		if agrego.exceso < noAgrego.exceso || (agrego.exceso == noAgrego.exceso && agrego.cantidad < noAgrego.cantidad) {
			M[i][j] = agrego
		} else {
			M[i][j] = noAgrego
		}
	}

	return M[i][j]
}

/*
	Esta es otra implementacion de billetes.
	En este caso podemos apreciar mas la recursion, donde tenemos un caso baso que es 'el primer paso'.
	Con estas implementaciones es mas facil luego pasar a bottom-up.

	Hay 2 tipos de algoritmos recursivos para resolver problemas.
	(A) Agregar las cosas a la siguiente llamada y procesar todo junto en el caso base.
	(B) Ir al caso base y a partir del return ir construyendo la solucion 'para arriba'.
*/

func billetesBT2(B []int, i int, j int) costo {
	if j <= 0 {
		return costo{0, 0}
	}

	if i == -1 {
		return costo{inf, inf}
	}

	agrego := billetesBT2(B, i-1, j-B[i])
	agrego.exceso += B[i]
	agrego.cantidad += 1

	noAgrego := billetesBT2(B, i-1, j)

	if agrego.exceso < noAgrego.exceso || (agrego.exceso == noAgrego.exceso && agrego.cantidad < noAgrego.cantidad) {
		return agrego
	}

	return noAgrego
}

func billetesDP2(B []int, i int, j int, M [][]costo) costo {
	if i == 0 && j > 0 {
		return costo{inf, inf}
	}

	if j <= 0 {
		return costo{0, 0}
	}

	if M[i][j].cantidad == -1 {
		agrego := billetesDP2(B, i-1, j-B[i], M)
		agrego.exceso += B[i]
		agrego.cantidad += 1

		noAgrego := billetesDP2(B, i-1, j, M)

		if agrego.exceso < noAgrego.exceso || (agrego.exceso == noAgrego.exceso && agrego.cantidad < noAgrego.cantidad) {
			M[i][j] = agrego
		} else {
			M[i][j] = noAgrego

		}
	}

	return M[i][j]
}

/*
(f) Nuestro algoritmo topdown tiene complejidad espacial O(nk), temporal O(nk) y se resuelve con
	cc(i, j) = cc(n-1, c).
*/

/*
(g)

	Estos son todos los estados de la matriz M:

	M[0][0] = {0,0}
	M[0][j] = {0,0}     									<-> j <= 0
	M[0][j] = {inf, inf} 									<-> j > 0
	M[i][j] = min(M[i-1][j], M[i-1][j-B[i]] + {B[i], 1})	cc

*/

func billetesBU(B []int, c int, n int, M [][]costo) costo {
	M[0][0] = costo{0, 0}

	for i := 1; i <= n; i++ {
		for j := c; j >= 0; j-- {
			agrego := M[i-1][0]

			if j-B[i] > 0 {
				agrego = M[i-1][j-B[i]]
			}

			agrego.exceso += B[i]
			agrego.cantidad += 1

			noAgrego := M[i-1][j]

			if agrego.exceso < noAgrego.exceso || (agrego.exceso == noAgrego.exceso && agrego.cantidad < noAgrego.cantidad) {
				M[i][j] = agrego
			} else {
				M[i][j] = noAgrego
			}
		}
	}
	return M[n][c]
}
