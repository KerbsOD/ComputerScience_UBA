Se tiene una matriz cuadrada de naturales $M$ tal que $1 \le M[i][j] \le n$. O sea, la matriz es de tamaño $n \texttimes n$ y en cada casillero puede haber un numero entre 1 y $n$. 

> **Ejemplo:** Si la matriz es de 9x9 entonces en cada casillero solo pueden haber numeros del 1 al 9.

![[Pasted Image 20230819061659_731.png]]
##### Invariante:
- En cada fila no se repiten numeros.
- En cada columna no se repiten numeros.
- En cada submatriz no se repiten numeros.
##### Backtracking:
Recorrer las soluciones parciales. Si una solucion no cumple el invariante, se descarta y se sigue con otra solucion parcial hasta llegar a un _Sudoku Completo_.
![[Pasted image 20230819044740.png]]
Discontinuamos la rama del 1 porque en la misma columna ya hay otro 1.
Disconitunamos la rama del 2 porque en la misma fila ya hay otro 2.
Discontinuamos la rama del 3 porque en la misma sub-matriz ya hay otro 3.
Sucesivamente se siguen descartando casos hasta llegar al 6. El 6 es un numero valido para esa posicion por lo que seguimos con su rama.

Continunando por la rama donde pusimos el 6 tenemos nuevamente 9 opciones para poner en la siguiente posicion. La **poda** se hace recursivamente hasta obtener todas las soluciones posibles.
![[Pasted image 20230819051340.png]]

**Como se diferencia el _backtracking_ de la _fuerza bruta_?**
Con un algoritmos de fuerza bruta hubieramos desarrollado todas las combinaciones y luego filtrar las *hojas* por *Soluciones Validas* mientras que con backtracking cuando detectamos que una rama no lleva a una solucion, la *podamos*(la cortamos y no la seguimos desarrollando).
> Todas las hojas en *backtracking* son soluciones. No todas las hojas en *fuerza bruta* son soluciones.

---
# Algoritmo para resolver Sudokus
Enlistaremos una serie de pasos para resolver un sudoku.

## Verificacion Fila-Columna-Sector
Antes de poner un numero en una celda tengo que **Verificar** su existencia en la fila, columna y sector. Esto lo haremos mediante la funcion *Disponible*. 
> **bool Disponible(int n, int columna, int fila, int sector)**
> Me dice si un numero $n$ cumple con el invariante del sudoku. 
> - False si n se encuentra en la columna o la fila o el sector.
> - True en caso contrario.
#### Acceso a Sectores
![[Pasted image 20230819065818.png]]