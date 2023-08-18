## Fuerza Bruta
Analizar __todas__ las posibilidades y quedarme con las que me interesan.
Con esta técnica los algoritmos __siempre funcionan__ pero generalmente son muy ineficientes.

_Problema de las n reinas_ 
Hallar todas las formas posibles de colocar $n$ reinas en un tablero de ajedrez de $n$ $\texttimes$ $n$ casillas de forma que ninguna reina amenace a otra.   

1. Solución por Fuerza Bruta 
   Hallar __todas__ las formas posibles de colocar $n$ reinas en un tablero $n$ $\texttimes$ $n$ y luego __filtrar__ las que cumplen las restricciones.
	Tenemos que elegir $n$ posiciones de $n^2$ casillas posibles.
	> Si hacemos la combinatoria en total hay ${n^{2} \choose n} = \frac{n^{2}!}{(n^{2}-n)!n!}$ posibles configuraciones! 
	> Luego hay que filtrar las que nos sirven pero sabemos que la mayoria no sirven!


---
## Algoritmos Golosos
En cada etapa se toma la decision que parece mejor basandose en la informacion disponible en ese momento, sin tener en cuenta las consecuencias futuras. La decision se toma mediante una **funcion de seleccion**.
Nunca vuelven para atras, se podria entender como una filosofia contraria al backtracking.
- **No funcionan para todos los problemas**. Al no mirar para atras, tal vez en el momento la que parecia la mejor solucion al final resulta no serlo. Ej: El problema donde habia que buscar el camino que sumaba mas numeros en una matriz solo yendo arriba, abajo, izquierda o derecha. Un algoritmos goloso elegiria el numero mas grande a su alrededor pero tal vez el camino que siguio no es el que mas suma.

> Se le llama algoritmos goloso porque se **come** lo mejor del momento sin importarle el futuro

- Proporcionan **heuristicas** sencillas para problemas de optimizacion. En general permiten construir soluciones razonables, pero **sub-optimas**.

> **Heuristicas**: Algoritmos que me dan una solucion valida pero no necesariamente la mejor.

> **Solucion sub-optima**: No es la mejor solucion.

_Problema de la mochila_
Tengo una mochila con un **peso máximo** y $n$ objetos que podría poner en la mochila. Cada objeto tiene un **peso** y un **beneficio**. Lo que se busca es maximizar el beneficio sin pasarse de peso.

- Capacidad $C \in \mathbb R_{+}$ de la mochila (peso maximo).
- Cantidad $n \in \mathbb N$ de objetos que puedo poner en la mochila.
- Peso $p_{i} \in \mathbb R_{+}$ del objeto i, para i = 1,...,n.
- Beneficio $b_{i} \in \mathbb R_{+}$ del objeto i, para i = 1,...,n.  

> En este caso el problema es continuo, o sea, el peso y el beneficio son fraccionables. De esta forma puedo calcular una proporcion peso/beneficio y quedarme con la mejor en cada iteracion. (**Algoritmo goloso**)

![[Pasted image 20230818055859.png]]
En esta imagen tenemos 3 **Funciones de Seleccion**. La primera elige los objetos en base a cual tiene mayor beneficio. La segunda elige los objetos en base a cual tiene menor peso y, la tercera, elige los objetos en base a su proporcion peso/beneficio. 

- Mayor Beneficio: Elijo **primero** el objeto que me de el mayor beneficio. Entonces elijo primero el 3 (66b y 30p), luego el 5 (60b y 50p) y luego la mitad del 4 (20b y 20p) para sumar un total de 100p que es el peso maximo (C) con un beneficio de 146.