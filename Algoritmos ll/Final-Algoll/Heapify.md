![[Pasted image 20230717001839.png]]
![[Pasted image 20230717001905.png]]
![[Pasted image 20230717002254.png]]
*Complejidad:* $\mathcal{O(n)}$ 
*Demostracion:*
 1. n es la cantidad de nodos
 2. h es la altura actual
 3. $\frac{n}{2^{h+1}}$ son la cantidad de nodos en el nivel. (si h es 0, estamos en el ultimo nivel por lo que hay $\frac{n}{2}$ nodos).
 4. log(n) es la cantida de niveles en el arbol.

Se hace sift down sobre cada nodo que no sea hoja (empezamos en la mitad).
En el peor caso, hacemos siftdown h veces para cada nodo del mismo nivel.
Por eso es ${\frac{n}{2^{h+1}}}*h$.
Todo esto lo repetimos para cada nivel:

> $\sum\limits_{h=0}^{log(n)}{\frac{n}{2^{h+1}}}*h$ 
 
 $\sum\limits_{h=0}^{log(n)}{\frac{n}{2^{h+1}}}*h$  =  $n*\sum\limits_{h=0}^{log(n)}{\frac{h}{2^{h}*2}}$ = $\frac{n}{2}*\sum\limits_{h=0}^{log(n)}{\frac{h}{2^{h}}}$

> $\sum\limits_{h=0}^{\infty}{\frac{h}{2^{h}}}$ = 2

$\frac{n}{2}*\sum\limits_{h=0}^{log(n)}{\frac{h}{2^{h}}}$ = $\frac{n}{2}$*2 = n