![[Pasted image 20230924082619.png]]

**Aristas Gruesas**: Son las que recorre el algoritmos dfs. 1-3-5-7.
**Aristas finas**: Son aristas que existen en el grafo pero en el arbol dfs no se recorren porque sus vertices ya fueron visitados. En este caso existe la arista 1-6 que el arbol no recorre porque antes se recorrio la 3-6.

![[Pasted image 20230924085646.png]]![[Pasted image 20230924085735.png]]

Cuando llego a DFS(7, 5). Me entero que el 3 ya se empezo a ver. Asi que como 3 (u) es diferente de 5(p) (o sea, 3 no es el padre directo de 7) significa que hay backedge.
Entonces el nodo 7 (v) es un extremo inferior de backedge.
3 (u) es un extremo superior de backedge.

O sea, 3 es el extremo superior y 7 es el eextremo inferior de un backedge.

## Contar
![[Pasted image 20230924091237.png]]
![[Pasted image 20230924091115.png]]

Si cubren es igual a 0. Encontramos un puente. 

# Determinar puentes dado dfs y cubren
![[Pasted image 20230924091256.png]]