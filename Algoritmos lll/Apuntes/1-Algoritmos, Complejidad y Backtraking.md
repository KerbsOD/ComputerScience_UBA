## Problema
Llamamos problema a la __descripcion__ de los datos de entrada y la __respuesta__ a proporcionar para cada dato de entrada. Una instancia de un problema es un juego valido de datos de entrada.

Ejemplo: 
1. Entrada: Un numero n entero no negativo. 
2. Salida: ¿El numero n es primo?

> En este ejemplo, una instancia esta dada por un numero entero no negativo.

---

## Maquina RAM (Random Access Machine)

1. La memoria esta dada por una sucesion de celdas numeradas. Cada celda puede almacenar un valor de b bits. 
2. Supondremos habitualmente que el tamano b en bits de cada celda esta fijo, y suponemos que todos los datos individuales que maneja el algoritmo se pueden almacenar con b bits. 
3. Se tiene un programa imperativo no almacenado en memoria, compuesto por asignaciones y las estructuras de control habituales. 
4. Las asignaciones pueden acceder a celdas de memoria y realizar las operaciones estandar sobre los tipos de datos primitivos habituales.

Cada __instruccion__ tiene un tiempo de ejecucion asociado
1. El acceso a cualquier celda de memoria es _O(1)_ (lectura y escritura)
2. Las asignaciones y el manejo de las estructuras de control se realiza en _O(1)_ 
3. Las operaciones entre valores logicos son _O(1)_

Las operaciones entre enteros/reales dependen de b: 
1. Las sumas y restas son _O(b)_. 
2. Las multiplicaciones y divisiones son _O(b log b)_.

Si b esta fijo, estas operaciones son O(1). En cambio, si no se puede suponer esto, entonces hay que contemplar que el costo de estas operaciones depende de b.

> o sea, si b esta acotado por 16 bits entonces la complejidad es __constante__

Tiempo de ejecucion de un Algoritmos A $\implies$ $T_{A}(I)$ = suma de los tiempos de ejecucion de las instrucciones realizadas por el algoritmo con la instancia $I$.
 
Dada una instancia $I$, definimos |$I$| como la cantidad de bits necesarios para almacenar los datos de entrada de $I$. 1. Si b esta fijo y la entrada ocupa n celdas de memoria, entonces |$I$| = b.n = _O(n)_.

> Si b esta fijo significa acotado en tamano.
 

---

## Problemas bien resueltos
- __Satisfactorios__: Algoritmos polinomiales (cuanto menor sea el grado, mejor).
- __No Satisfactorios__: Algoritmos supra-polinomiales.

Un __problema de optimizacion__ consiste en encontrar la mejor solucion dentro de un conjunto.
> - $z^{*}$ = $max_{x∈S}$ f(x) $\implies$ $z^{*}$ es la f(x) donde _x_ que __maximiza__ a _f_
> - $z^{∗}$ = $mın_{x∈S}$ f(x) $\implies$ $z^{*}$ es la f(x) donde _x_ que __minimiza__ a _f_

- La funcion f : S → R se denomina __funcion objetivo__ del problema.
- El conjunto S es la __region factible__ y los elementos x ∈ S se llaman __soluciones factibles__.
- El valor $z^{∗}$ ∈ R es el __valor optimo__ del problema, y cualquier solucion factible $x^{∗}$ ∈ S tal que f ($x^{∗}$) = $z^{∗}$ se llama un __optimo__ del problema.

Un problema de optimizacion combinatoria es un problema de optimizacion cuya region factible es un conjunto definido por consideraciones combinatorias (!).

> Por ejemplo, regiones factibles dadas por todos los subconjuntos/permutaciones de un conjunto finito de elementos (posiblemente con alguna restricci´on adicional), todos los caminos en un grafo, etc.

---

## Algoritmos de fuerza bruta
Consiste en generar todas las soluciones y quedarse con la mejor.
- __Algoritmos exacto__: Si hay solución, la encuentra.

> Estos algoritmos es que suelen tener una complejidad exponencial

### El problema de la mochila
_Datos de entrada:_
- $C$ $\implies$ Capacidad de la mochila (peso máximo). $C \in$ $\mathbb Z_{+}$ 
- $n$ $\implies$  Cantidad de objetos. $n \in \mathbb N$ 
- $p_{i}$ $\implies$ Peso del i-ésimo objeto. $p_{i} \in \mathbb Z_{+}$
- $b_{i}$ $\implies$ Beneficio del i-ésimo objeto. $b_{i} \in \mathbb Z_{+}$

_Problema:_ Determinar que objetos debemos incluir en la mochila sin excedernos del peso maximo C, de modo tal de maximizar el beneficio total entre los objetos seleccionados.

_Inicializacion_:
- _B_ = $\emptyset \implies$ Empezamos el algoritmo con nuestra mochila $B$ vacia (ninguna razon en especifico, solo para inicializarla).
- $Mochila(\emptyset, 1) \implies$ Empezamos el algoritmo con nuestro conjunto S vacio y k en 1 
> k representa el tag del item.
> n de S representa la cantidad de elementos en S.
- $S$ es nuestra mochila __Inicial__ mientras que $B$ es nuestra mochila __final__. $S$ se modifica en cada llamado de la recursion mientras que B solo se modifica cuando obtenemos un mejor conjunto de objetos peso-beneficio.
 

![[Pasted image 20230817035233.png]]

_Que carajos esta pasando?_
- __Si k == n+1:__ Verificamos que la sumatoria de los pesos de los elementos en S sean menores al peso maximo y que el beneficio de S sea mayor al beneficio de B. 
> Se remplaza la mochila actual ($B$) cada vez que tenga un __peso menor al maximo__ ($C$) con un __beneficio mayor al actual__ (beneficio actual de $B$).  

- __Si k != n+1:__  Corremos el algoritmos nuevamente 2 veces. En una de las "corridas" agregamos el tag al subconjunto y en la otra simplemente no lo agregamos.

---

## Backtracking
Recorrer todas las posibles configuraciones del __espacio de soluciones__ de un problema computacional, eliminando las __configuraciones parciales__ que no puedan completarse a una solucion.

Utilizar un vector a = ($a_{1}, a_{2}, ..., a_{n}$) para representar una solucion candidata, cada $a_{i}$ pertenece a un dominio/conjunto ordenado y finito $A_{i}$

El __espacio de soluciones__ es el producto cartesiano $A_{1} \ \texttimes \ ... \ \texttimes \ A_{n}$  

> Cada solucion parcial eventualemente puede representar a un elemento del espacio de soluciones.


#### Todas las soluciones
![[Pasted image 20230817055234.png]]
#### Una solucion 
![[Pasted image 20230817055323.png]]

