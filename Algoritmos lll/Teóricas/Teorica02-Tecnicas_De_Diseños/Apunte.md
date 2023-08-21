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
# Backtracking
Consiste en recorrer todas las configuraciones e ir *podando* las ramas que no me van a llevar a una solucion.

Se utiliza un vector a = ($a_{1}, a_{2}, ..., a_{n}$) para representar una **solucion candidata** 

Cada paso del algoritmo va a ir extendiendo al vector a = ($a_{1}, a_{2}, ..., a_{k}$), $k < n$. 

> Notar que k es estrictamente menor a n pues este vector representa una **solucion parcial** y no una candidata. Todavia no se lleno.

$a_{k+1} \in S_{k+1} \subseteq A_{k+1}$ 

Estando en la coordenada $k-esima$ voy a buscar quienes son todos los posibles  $a_{k+1}$ para agregar al vector. Si el conjunto de *soluciones sucesoras* de $a_{k}$ es vacio ($S_{k+1} \equiv \emptyset$) ya esta, por esa rama no continuo explorando. 

> La raiz del arbol representa al vector a vacio, o sea, que no elegi nada.

#### Tipos de podas
- **Factibilidad:** Si sigo por esta rama no voy a obtener ninguna solucion valida del problema.
- **Optimalidad:** Si sigo por esta rama no voy a obtener la solucion optima.

> Nuestro objetivo en **Backtracking** es podar mucho!

#### Problema de las 8 reinas.
Supongamos que tengo mi vector solucion donde en cada posicion escribo la columna donde se encuentra la reina y la posicion en el vector me dice la fila.
Ej si una reina esta en la columna 2 y la fila 1 entonces el *primer* elemento del vector deberia ser el numero 2. Pues esta en la primer fila y la segunda columna. Como se lee el ejemplo de abajo?
- Fila 1, Columna 2
- Fila 2, Columna 4
- Fila 3, Columna 1
- Fila 4, Columna 3
- Fila 5, Columna 6
- Fila 6, Columna 5
- Fila 7, Columna 8
- Fila 8, Columna 7
![[Pasted image 20230821015604.png]]
En este caso cada reina **Solo** puede estar en una fila. Porque hay 8 posiciones en el vector y son unicos.
La cantidad de combinaciones es igual a 8$^{8}$ porque no pusimos restricciones sobre las columnas. (8$\texttimes$ 8 $\texttimes$ 8 $\texttimes$ 8 $\texttimes$ 8 $\texttimes$ 8$\texttimes$ 8$\texttimes$ 8)

> Pensarlo como combinatoria de probabilidad y estadistica!

Si ahora ponemos la restriccion de que no se pueden repetir columnas. Tendriamos 8! combinaciones. (8 $\texttimes$ 7 $\texttimes$ 6 $\texttimes$ 5 $\texttimes$ 4 $\texttimes$ 3 $\texttimes$ 2 $\texttimes$ 1)

#### Diseno y repeticiones
A la hora de disenar un algoritmos de backtracking queremos evitar la repeticion de "instancias".
Sabemos que el vector de soluciones empieza vacio $\implies$ a = ().
Luego, en el primer nivel, a nuestro vector se le agrega una solucion $c_{i}$ $\implies$ a = ($c_{i}$). Pero en otra rama que sale de la misma raiz se le agrega una solucion parcial $c_{j}$ $\implies$ a' = ($c_{j}$).
- a = ($c_{i}$)
- a' = ($c_{j}$)
Que pasa cuando ambas soluciones parciales van al nivel 2?
Supongamos que en el nivel 2 del arbol se agrega las siguientes soluciones parciales a nuestros vectores:
- a = ($c_{i}, c_{j}$)
- a' = ($c_{j}, c_{i}$)
> Si importa el orden en el vector entonces no pasa nada, son diferentes. Pero si hablamos de un conjunto estos dos vectores **son iguales**.


#### Por que se le llama 'backtracking'?
Notemos que en la primera opcion pusimos un '1' en el sudoku, al detectar que ya existe un '1' en esa columna, lo que hacemos es "volver para atras". O sea, esta *solucion parcial* se descarta para siempre y mi *raiz* sigue con la siguiente. Fuimos para atras porque subimos por donde bajamos. 
Tener en cuenta que el codigo es *secuencial*. Cuando una funcion recursiva termina, **volvemos la instancia anterior**.
![[Pasted image 20230821014711.png]]
![[Pasted image 20230821014613.png]]

#### Como se diferencia el backtracking de la fuerza bruta?
Con un algoritmos de fuerza bruta hubieramos desarrollado todas las combinaciones y luego filtrar las *hojas* por *Soluciones Validas* mientras que con backtracking cuando detectamos que una rama no lleva a una solucion, la *podamos* (la cortamos y no la seguimos desarrollando).

> Todas las hojas en *backtracking* son soluciones. No todas las hojas en *fuerza bruta* son soluciones.

