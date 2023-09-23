# Ejercicio 7
![[Pasted image 20230918023433.png]]

##### (a)
 Como se puede apreciar G = G1 $\cup$ G2 $\implies$ V(G) = {A, B, C, D, E} y E(G) = {(A,B), (B,C), (D,E)}.
   Es un grafo union porque no existen aristas entre G1 y G2.
   ![[Pasted image 20230918025616.png]]
###### (b) 
Si G es un grafo union entonces puede estar compuesto por G1 y G2. No hay aristas entre G1 y G2. La negacion de G implica que en $G^\complement$ existen todas las aristas que conectan $G_{1}$ con $G_{2}$ 

###### (c)
Si $\overline{G}$ es disconexo entonces en G estan todas las aristas entre $G{1}$ y $G_{2}$.   


# Ejercicio 8
![[Pasted image 20230918032109.png]]
- $G_{2}$
  ![[Pasted image 20230918032522.png]]
- $K_{1}$ 
![[Pasted image 20230918032658.png]]

##### **Caso Base**
 Tenemos el grafo $G_{3} = \overline{G_{2} \cup K_{1}}$. 
 - Vamos a graficar primero $G_{2} \cup K_{1}$.
   ![[Pasted image 20230918034516.png]]
- Entonces $\overline{G_{2} \cup K{1}}$ seria igual a 
  ![[Pasted image 20230918034659.png]]

Como se puede ver $G_{n}$ tiene 2 vertices de grado 1. Estos son los unicos vertices de grado 1.

$G_{4} = \overline{G_{3} \cup K_{1}}$ 
Sabemos que $G_{3}$ tiene esta forma:
  ![[Pasted image 20230918034659.png]]
Entonces $G_{3} \cup K{1}$ seria del tipo:
![[Pasted image 20230918041610.png]]
Esto implica que $G_{4} = \overline{G_{3} \cup K_{1}}$ es igual a:
![[Pasted image 20230918041939.png]]

$G_5$ 
![[Pasted image 20230918043320.png]]

**P(n)**: $G_{n}$ tiene un unico par de vertices de igual grado. Sabiendo que $G_{n+1} = \overline{G_{n} \cup K_{1}}$ 
**P(n+1)**: $G_{n+1}$ tiene un unico par de vertices de igual grado.

Para ver que $G_{n+1}$ tiene un unico par de vertices de igual grado debemos ver que $\overline{G_{n} \cup K_{1}}$ tiene un unico par de vertices de igual grado.
Teniendo $G_{n} \cup K_{1}$ por HI sabemos que $G_{n}$ tiene un unico par de vertices de igual grado ademas $K_{1}$ no tiene vertices asi que la union cumple tener un unico par de vertices de igual grado. Si lo negamos tenemos que el d(v) = d(w) (v y w siendo mis vertices de igual grado) ahora son $\overline{d(v)} = \overline{d(w)}$ como su grado era igual en $G_{n}$ entonces su grado sera igual en $\overline{G_{n}}$ 

# Ejercicio 9
![[Pasted image 20230918052034.png]]

> Notar que son *mas* de $n^{2}$ aristas. $n = 2n \ \wedge \ m > n^{2}$

**Caso Base:** $n = 2$ y $m = 4$  
   ![[Pasted image 20230918052842.png]]
   **P(k):** $(\forall G_{k} = (V, E): n = 2k \ \wedge \ m > k^{2} \ \implies Tiene \ triangulo)$
   **P(k+1):** $(\forall G_{k+1} = (V, E): n = 2(k+1) \ \wedge \ m > (k+1)^{2} \ \implies Tiene \ triangulo)$

**QVQ: P(k) $\implies$ P(k+1)** 

Sea G mi grafo con $n = 2(k+1)$ vertices y $m > (k+1)^{2}$ aristas.
Ahora supongamos que creamos un grafo G' a partir de G pero sin 2 vertices $v, w \in V(G)$.

**HI** 
$G'$ n' = 2(k+1) y m' > (k+1)$^{2}$
n' = 2k + 2 y m' > $k^{2}$ + 2k + 1
n' = 2k +2 -2 y m > $k^2$ + 2k + 1 - (k-1) - (k-2) = $k^2$ + 2k + 1 -k +1 - k + 2
n' =2k y m' > $k^2$ +  4

2k vertices y que tengo mas de $k^2$ +4 aristas 

Si cuando tengo mas de k^2 aristas, tengo un triangulo
Entonces al tener mas de k^2 + 4 aristas, claramente tengo un triangulo.

Como en mi grafo sin 2 vertices tengo un triangulo por HI entonces, este mismo grafo con los 2 vertices de mas tiene un triangulo. Porque es el mismo k3 con vertices y aristas extra.

$G' - 2$ 
$|V(G'-2)| = 2k$ 
$|E(G'-2)| > k^{2} + 4 > k^2$ 
Por HI como tenemos un grafo con $k^2$ aristas + 4 aristas y sabiamos que con m > $k^2$ se cumplia que tiene un triangulo entonces tiene un triangulo. Es un k3 con mas boludeces arriba.

m > $k^2$ $\implies$ m' > $k^2$ + 4 

$|V(G')| = 2(k+1) - 2$ y $|E(G')| > (k+1)^{2} - ((k-1) + (k-2))$. 

> Recordar que cada nodo puede conectarse con como mucho k-1 nodos en el grafo. Como no sabemos el grado de los nodos que sacamos. Asumimos el peor caso. Sacamos el primer nodo que podia tener k-1 aristas. Sacamos el segundo nodo y como asumimos que el primero estaba conectado a este, cuando sacamos el primer nodo perdimos la arista que conectaba a este segundo asi que como mucho puede tener k-2 aristas. (estamso en grafos no direccionados).

$n = 2k + 2 - 2$ $\Longleftrightarrow$ $n = 2k$
$m > k^{2} + 2k + 1 - 2k + 3 $\Longleftrightarrow$ $m > k^{2} + 4$. 

Por HI podemos ver que n = 2k y que m > $k^{2} + 4$ porque $m > k^{2} \ \implies m > k^{2} + 4$ 

# Ejercicio 10
![[Pasted image 20230918064359.png]]
$G - v \ Bipartito \Longleftrightarrow \ G \ Bipartito \vee \ G \ ciclo \ impar$

Un grafo $G$ es bipartito si existen dos subconjuntos $V_{1}, V_{2}$ del conjunto $V(G)$ tal que:
$$
V = V_{1} \cup V_{2}, \ V_{1}\cap V_{2}= \emptyset
$$
**Ida:** $G-v \ Bipartito \ \forall \ v \ \implies G  \ Bipartito$
**Contrareciproco:** $G$ no Bipartito y G no es ciclo impar $\implies$ $G-v$ no Bipartito para algun $v \in V(G)$.

En este diagrama podemos ver que G no es bipartito porque $V = {A, B, C, D, E, F}$  y $V_1$ = {A, C}, $V_2$ = {D, E, F} no puedo separarlo en 2 grupos de vertices que nunca se tocan. Osea, $V \neq V_{1}\cup V_2$. Y G no es ciclo impar. El unico ciclo es A - B - C - D - A que es un ciclo par.
![[Pasted image 20230918222152.png]]
En este caso $G$ no es bipartito ni es un ciclo impar.  Al sacar cualquier vertice excepto b tengo un Grafo no bipartito.

# Representación de grafos en la computadora
## Matriz de adyacencia
![[Pasted image 20230918232224.png]]
## Matriz de incidencia
![[Pasted image 20230918233039.png]]
## Matriz adyacencia digrafo
![[Pasted image 20230918235716.png]]
![[Pasted image 20230918235943.png]]
## Matriz de incidencia digrafo
![[Pasted image 20230919000038.png]]
![[Pasted image 20230919001236.png]]


# Ejercicio de Parcial
![[Pasted image 20230919011148.png]]

$D =$ {$(v_{0}, w_{0}), \ (v_{1}, w_{1}), \ ...,\  (v_{m}, w_{m})$}
1. Genero todas las aristas de $D^R$ (reverso de D) en $O(m)$: Recorro $E(D)$ y dado una arista $(v,w)$ creo la misma arista pero al revez. $(w, v)$.
2. Concateno las aristas de $D$ con las de $D^R$.
3. Si una arista esta repetida es porque D la tenia antes.


# Ejercicio 11

![[Pasted image 20230919012932.png]]

*Conjunto de vecindarios:* Un conjunto que dado un vertice v me dice todos los vertices con los cuales tiene aristas.

**Estructura A:** 
![[Pasted image 20230919013844.png]]

**(a)** Me dan un conjunto de aristas (x,y): {(1, 4), (2,5), (3, 0), (3,4)}. Simplemente recorro la lista y pusheo en la posicion *x* a *y* y en la posicion *y* pusheo a x. Recordar que si x es vecino de y entonces y es vecino de x. $O(m)$.

**(b)** Accedo a $v$ en $O(1)$ y busco a $w$ en la lista. En el peor caso $v$ es adyacente con todos. $O(m)$.

**(c)** Accedo $v$ en $O(1)$ y recorro su arreglo en $O(m)$.

**(d)** $O(costo \ de \  elemento\ nuevo\ en\ lista) + O(N(v))$ 

**(e)** $O(1)$. Accedo a v y w en tiempo constante y les pusheo su contraparte.

**(f)** $O(costo \ de \ remover \ un\ elemento\ de\ arreglo) + O(n*m)$ 

**(g)** $2*O(m)$ 

**(h)** Cada vez que agrego una arista podria meterle el adyacente en orden por lo que seria $O(m)$


**Estructura B:** 
![[Pasted image 20230919020530.png]]

**(a)** Me dan un conjunto de aristas (x,y): {(1, 4), (2,5), (3, 0), (3,4)}. Simplemente recorro la lista y pusheo en la posicion *x* a *y* y en la posicion *y* pusheo a x. Recordar que si x es vecino de y entonces y es vecino de x. $O(m)$.

**(b)** Accedo a $v$ en $O(1)$ y busco a $w$ en la lista. En el peor caso $v$ es adyacente con todos. $O(m)$.

**(c)** Accedo $v$ en $O(1)$ y recorro su arreglo en $O(m)$.

**(d)** $O(costo \ de \  elemento\ nuevo\ en\ lista) + O(N(v))$ 

**(e)** $O(1)$. Accedo a v y w en tiempo constante y les pusheo su contraparte.

**(f)** En este caso remuevo el elemento de la lista y, si la lista es doblemente enlazada, puedo remover sus adyacencias en O(1). Depende la implementacion.

**(g)** $O(m)$ 

**(h)** Cada vez que agrego una arista podria meterle el adyacente en orden por lo que seria $O(m)$

**Estructura C:** 
Matriz de adyacencia.

**(a)** O(m*n^2)

**(b)** O(1)

**(c)** O(n)

**(d)** O(N(v))

**(e)** $O(1)$.

**(f)** O(n)

**(g)** $O(1)$ 

**(h)** O(1)

# Ejercicio 12
Recorro las m aristas buscando el maximo nodo. O(m).
Creo un vector con el maximo vertice. O(n).
Recorro las aristas y a cada v le pusheo su w y viceversa. O(m).

(b) En una tabla de hash seria similar pero sin el primer m y n.
(c) Construir seria O(n^2) y luego O(m) para rellenar.

# Ejercicio 13

**(B)** 

# Ejercicio 14
(A) Si todos los vertices tienen grado de salida mayor a 1 entonces hay 2 opciones. Los vertices son infinitos o un vertice apunta a otro que a futuro llevará a este por lo que hay un ciclo.
(B) Creo un arreglo vacio de vertices. Empiezo a recorrer. Cada vez que paso por un vertice chequeo si esta en mi arreglo. Lo guardo. Voy al siguiente vertices. Si un vertice se repite entonces termino.
(C) Creo un arreglo vacio en base a la cantidad de vertices. Cada vez que entro a un vertice, chequeo si ya lo recorri antes (con un arreglo de bools). Si ya lo recorri, retorno. Si no, lo pongo en true y voy al siguiente. O(n) para construir el vector. O(m) para recorrer todas las aristas.
(D) Si D sin v es aciclico entonces no existe un ciclico cuando no estaba v. Luego si agregamos v sin ninguna arista de salida, tampoco es ciclico. Pues este v no aporta una conexion para generar un ciclo.
(E) ![[Pasted image 20230919032102.png]]
En este caso tenemos 2 vertices con $d_{out}$ = 0.
1. Si el nodo no lo recorri. Lo guardo. Si lo recorri. Retorno el vertice actual en un vector vacio.
2. Llamo recursivamente a todos los nodos de salida.
3. Uno todos los vectores de vertices de salida en un vector y lo devuelvo.
4. Cuando vuelvo a la primera llamada de la funcion. verifico que todos los vertices tengan 0 vertices de salida. Si alguno es mayor a 0 entonces guarde un ciclo. Filtro los de salida 0 y me quedo con el ciclo. Otherwise me queda un vector con vertices sin salida.

(F) Recorrer los vertices es O(m). Buscar un ciclo en el vector restante es O(n).

# Ejercicio 15
(a)
1. Funciona porque prueba que todas las combinaciones de 3 vertices tengan las 3 aristas activas.
2.  Dentro de los vecinos de v verifica que estos esten conectados entre si formando un triangulo.





















