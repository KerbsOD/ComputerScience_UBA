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
