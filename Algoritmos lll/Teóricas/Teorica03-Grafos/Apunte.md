# Introduccion a la teoría de Grafos

**Circuito Euleriano:** Cada *arista* se recorre solo una vez.
**Circuito Hamiltoneano:** Cada *vertice* se recorre solo una vez.

> Algoritmo de *Warnsdorff*: En cada paso mueve el caballo a la casilla vecina todavia sin visitar con menor valor. Es una **Heuristica golosa** porque no siempre encuentra un ciclo hamiltoneano aunque este exista.
> 

- A cada provicia asignarle un vertice. Si dos provincias tienen frontera entre si, las unimos con una arista. Pintar cada vertice de un colo diferente a sus aristas. 
  ![[Pasted image 20230908085433.png]]

# Definición
Un **grafo** *G* es un par de conjuntos. 
- **V:** Conjunto de vertices.
- **X:** Subconjunto del conjunto de pares no ordenados de elementos distintos de **V**. **X** representa al conjunto de aristas que conectan dos vertices pertenecientes a **V**. Son no ordenados porque las aristas no tienen vertices.

> **G = (V, X)**
> Donde:
> - V es un conjunto de vertices.
> - X es un conjunto de (v,w) donde v $\in$ **V** y w $\in$ **V**.

Si e = (v, w) $\in$ **X** decimos que: 
- *e* es una **arista**.
- v y w son **adyacentes**.
- *e* es **indicente** a v y w.

![[Pasted image 20230908094126.png]]
![[Pasted image 20230908094408.png]]
![[Pasted image 20230908094531.png]]
![[Pasted image 20230908101956.png]]

## Grafo Completo
Un grafo se dice completo si todos los vertices so adyacentes entre si. (Cuadrado, triangulo, etc)
