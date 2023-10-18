## Variantes
- **Single-source:** Camino minimo de un nodo a todo el resto.
- **Single-destination:** Camino minimo de todos los nodos a un nodo. Es literalmente invertir *Single-source*.
- **Single-pair:** Camino minimo de un nodo v a un nodo u. Es igual a *Single-source*, paramos cuando encontramos a nuestro u.
- **All-pairs:** Camino minimo para cada nodo v a cada nodo u en $G$. Es un *Single-source* pero guardando el camino a cada nodo. Creo que se puede abusar de programacion dinamica con una matriz.

## Pesos negativos
El problema de tener un grafo con pesos negativos es que exista un ciclo de pesos negativos tal que cada vez que yo completo el ciclo, el peso de mi camino se vuelve mas chico. Me quedo trabado en un loop infinito. Esto implica que el problema esta mal modelado, tenemos que sacar ese ciclo. 
![[Pasted image 20231017144001.png]]
- $\delta(s,a)=w(s,a)=3$ 
- $\delta(s,b)=w(s,a)+w(a,b)=3+(-4)=-1$
- $\delta(s,c)=w(s,c)=5$ 
- $\delta(s,d)=w(s,c)+w(c,d)=5+6=11$

El problema es cuando queremos buscar el camino minimo desde s a e, $\delta(s,e)=-\infty$ porque
$w(s,e)=2 \ \wedge \ w(e,f)=3 \ \wedge \ w(f,e)=-6$
- $P(s,e,f,e) = w(s,e) + w(e,f) + w(f,e) = 2+3+(-6)=-1$  
- $P(s,e,f,e,f,e)=2+3+(-6)+3+(-6)=-4$  
- $P(s,e,f,e,f,e,f,e)=2+3+(-6)+3+(-6)+3+(-6) =-7$. 

Hasta llegar a $-\infty$ porque siempre tenemos un camino mas corto en distancia.
Lo mismo pasa con el camino minimo desde s a f y desde s a g. 
En el caso de g podemos llegar haciendo P(s,c,d,g). Pero un camino mas *corto* seria ir por P(s,e,f,e,f,e,f,e......) infinitamente.

En un grafo disconexo, los nodos que no estan en el mismo componente de $s$ tiene peso $\infty$. 

## **Ciclos**
Como vimos arriba. Un *camino minimo* entre un nodo $a$ y un nodo $b$ no puede tener ciclos donde su peso sea negativo. Tampoco tiene ciclos con peso positivo porque sacando el ciclo, sacamos el peso y tenemos un camino menor. En el ultimo caso, ciclos donde todas las aristas tiene peso nulo (0), se puede remover pues no me modifica mi camino, solo agrega nodos.

Todo esto que nos dice? 
> **Un camino minimo tiene como mucho |$V$| nodos y |$V$|$-1$ aristas**.


## Representacion de un camino minimo
Dado un grafo $G=(V,E)$ para cada nodo $v \in V(G)$ un padre que es un nodo o null. Nos interesa el grafo de padres generado por BFS. $G_{\pi}=(V_{\pi},E_{\pi})$.
Dado una raiz generamos un arbol de padres para todos los nodos alcanzables por la raiz. Si un nodo no esta en el mismo componente que la raiz, entonces este nodo no pertenece al arbol de padres.
$$
(\forall \ v\in V_{\pi}) \ el\ camino\ de\ la\ raiz\ s\ a\ v\ en\ G_{\pi}\ es\ el\ camino\ minimo\ de\ s\ a\ v\ en\ G.
$$
> Pueden haber multiples caminos minimos con mismo peso en un grafo $G$.

#### Inicializacion
Inicializamos cada nodo $v \in G$ con peso $w(v)=\infty$ y padre $p(v)=null$.
Inicializamos la raiz $s$ del arbol con peso $w(s) = 0$. (s de source).
![[Pasted image 20231017160100.png]]
El concepto de relajacion de un vertice es verificar si hay un costo menor al actual. En ese caso, modificarlo.
1.  En el caso *(a)* si vamos desde la raiz s->u->v el costo es $w(s,u) + w(u,v) = 5 + 2$. Actualizamos el minimo valor de $w(s,v)$ porque el valor anterior es 9.
2. En el caso *(b)* si vamos desde la raiz s->u->v el costo es 7 $w(s,u) + w(u,v) = 5+2$. No actualizamos el minimo valor de $w(s,v)$ porque el valor anterior es 6, *menor* que 7.
> En el primer caso ya habiamos generado un peso $w(s,v)$ pero al recorrer por u encontramos uno todavia mejor!

## Propiedades
![[Pasted image 20231017161309.png]]
1. $\delta(s,v)\ \leq \ \delta(s,u)+w(u,v)$. 
   -  $\delta(s,v)\ = \ \delta(s,u)+w(u,v)$ $\Longleftrightarrow$ $w(u,v)=\delta(u,v)$. O sea solo si $w(u,v)$ es el camino minimo.
   -  $\delta(s,v)\ < \ \delta(s,u)+w(u,v)$ $\Longleftrightarrow$ $w(u,v) \neq \delta(u,v)$. El camino minimo sera menor solo cuando algun componente del camino no sea el camino minimo.
2. $v.d \geq \delta(s,v)\ \forall\ v \in V_{G}$. El componente peso de un vertice sera siempre mayor o igual al minimo peso desde $v$ a $s$. Una vez que se consigue el peso $\delta$, no se vuelve a  modificar.
3. Si no existe camino de $v$ a $s$ entonces el componente peso de $v$ y el camino minimo son $\infty$.
4. Si s->u->v es el camino minimo entonces nunca seran modificados.
6. Una vez que todos los nodos tengan su peso minimo, el arbol sera el camino minimo desde la raiz a todos los nodos. 
## Bellman-Ford
![[Pasted image 20231018082632.png]]
![[Pasted image 20231018083050.png]]

### Ejemplo
![[Pasted image 20231018092500.png]]
1. Inicializamos un arreglo con todos los nodos y su peso en infinito.
2. El peso de la raiz $s$ lo seteamos a 0.
3. Relajamos cada nodo |$V$|-1 veces.

```C++
for (i = 0; i < v.size(); i++) {
	for (Arista e : aristas) {
		if (d[e.v]+e.w < d[e.u]) {
			d[e.u] = d[e.v]+e.w;
		}
	}
}

for (i = 0; i < v.size(); i++) {
	for (Arista e : aristas) {
		if (d[e.v]+e.w < d[e.u]) {
			return false
		}
	}
}
```
Complejidad: $O(|V|.|E|)$
En la primer corrida del algoritmo se establece el minimo peso desde la raiz a cada nodo. 
En la segunda corrida, si existe un peso menor, significa que hay un ciclo negativo. Devolvemos false.

![[Pasted image 20231018093848.png]]Despues de la primera iteracion asi queda la lista de adyacencia.

> El algoritmo recorre cada arista n-1 veces. O sea que si empezamos por la arista 
> 5->8, su peso queda en infinito. 
> d[5]+(5,8).w < d[8] $\Longleftrightarrow$ $\infty+50\ <\ \infty$. Falso, no se actualiza el peso de 8.

El algoritmo empieza a funcionar cuando llegamos a la arista (0,1).
> d[0] + (0,1).w < d[1] $\Longleftrightarrow$ 0 + 5 < $\infty$ $\implies$ d[1] = 5


## DAG (Directed Acyclic Graph)
![[Pasted image 20231018101328.png]]
Ordenamos los nodos en orden topologico. O sea, nunca vas a encontrar un nodo que vaya a uno atras suyo. 
- Las aristas de 0 van para adelante.
- Las aristas de 6 van para adelante.
- Las aristas de 1 van para adelante.
![[Pasted image 20231018101741.png]]
- $O(topologicallSort) = O(V+E)$
- $O(initializeSingleSource)=O(V)$
- $O(for) = O(V+E)$. Tener en cuenta que en el peor caso $E=2*|V|*(|V|-1)$. En el peor caso cada nodo esta conectado con todos los nodos por ida y por vuelta.

## Dijkstra
![[Pasted image 20231018131306.png]]
Mantiene los nodos visitados. Algoritmo greedy, elijo al nodo con menor peso y recorro sus hijos. Es un DFS solo que los backedges no se los descarta si no que se los actualiza si es que el costo actual del nodo + el costo de la arista es menor al del hijo.
![[Pasted image 20231018131925.png]]
- Empezamos por 0.
- Actualizamos la distancia de 0 a 1 y de 0 a 2.
- Metemos ambos nodos (1 y 2) al min heap.
- Agarramos el de maxima prioridad (menor costo), en este caso es el 2. Del 2 actualizamos el valor de todos sus hijos y los agregamos al heap (siempre y cuando no hayan sido visitados antes). 


## Floyd-Warshall
