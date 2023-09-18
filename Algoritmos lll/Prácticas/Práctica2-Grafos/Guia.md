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
$|V(G')| = 2(k+1) - 2$ y $|E(G')| > (k+1)^{2} - ((k-1) + (k-2))$. 

> Recordar que cada nodo puede conectarse con como mucho k-1 nodos en el grafo. Como no sabemos el grado de los nodos que sacamos. Asumimos el peor caso. Sacamos el primer nodo que podia tener k-1 aristas. Sacamos el segundo nodo y como asumimos que el primero estaba conectado a este, cuando sacamos el primer nodo perdimos la arista que conectaba a este segundo asi que como mucho puede tener k-2 aristas. (estamso en grafos no direccionados).

$n = 2k + 2 - 2$ $\Longleftrightarrow$ $n = 2k$
$m > k^{2} + 2k + 1 - 2k + 3 $\Longleftrightarrow$ $m > k^{2} + 4$. 

Por HI podemos ver que n = 2k y que m > $k^{2} + 4$ porque $m > k^{2} \ \implies m > k^{2} + 4$ 

# Ejercicio 10
![[Pasted image 20230918064359.png]]
