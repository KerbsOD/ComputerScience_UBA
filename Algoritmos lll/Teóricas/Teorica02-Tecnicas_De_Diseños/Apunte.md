# Fuerza Bruta
---
Consiste en probar todas las combinaciones posibles y quedarme con las soluciones que cumplan ciertas caracteristicas.

> Ejemplo: Crear **TODAS** las combinaciones posibles de un sudoku estandar (9x9) y quedarme solo con las soluciones donde para cada columna, fila y cuadrante no se repita el mismo numero. De todas las combinaciones *filtramos* las soluciones.
# Algoritmo Goloso
---
Consiste en elegir la mejor opcion dada la instancia actual. Esto **no** me garantiza que la solucion parcial sea una solucion candidata.

> Se comen lo mejor en el momento sin importarle el futuro.

> Ejemplo: En el problema de buscar el camino que me de la maxima suma en una matriz empezando por la posicion $[0][0]$ hasta la $[n][n]$ donde solo podemos movernos por posiciones adyacentes. Un algoritmos goloso elegiria *siempre* al adyacente mayor. Esta *no* es siempre la solucion correcta. Puede ser que al elegir al mayor de los adyacentes actuales perdamos la oportunidad de elegir a un numero mucho mas grande que este pero que solo se podia acceder mediante un adyacente pequeño.

**Heuristicas:** Algoritmos que me dan una solucion valida pero no necesariamente la mejor.
**Funcion de seleccion:** Es mi criterio por el cual tomo un camino u otro.

> Ejemplo: En el problema de la mochila continuo (obtener el maximo beneficio sin superar la capacidad de la mochila) debo elegir que elementos meter. Cual elijo? En que me baso?
> Mis funciones de seleccion son:
> - Menor peso: De mis elementos disponibles elijo primero el que pesa menos.
> - Mayor beneficio: De mis elementos disponibles elijo primero el que me da mas beneficio.
> - Mejor proporcion beneficio/peso: De mis elementos disponibles elijo primero el que tenga la mejor relacion beneficio/peso. (tener en cuenta que estamos en el problema continuo y puedo elegir el porcentaje necesario para llegar con el peso eligiendo al de mayor beneficio si o si)

---
