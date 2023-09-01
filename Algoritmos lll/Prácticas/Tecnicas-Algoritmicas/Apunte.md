# Backtracking
## CD
![[Pasted image 20230828212959.png]]

> Dado un limite P. Que cantidad de minutos es la maxima sin pasarse de este limite?

- Input: [1,4,2]
- Output: 5

>$c_{1} = 1$ y $c_{2} = 4$ $\implies$ $c_{1} + c_{4} = 5$ y $5 \leq P = 5$ 
>Como podemos ver la mejor combinacion es 5 pues maximiza los minutos sin pasarse.  

![[Pasted image 20230828214430.png]]

- $i$ es el indice por el que voy de mi array de inputs.
- $k$ son los minutos que **No puedo exceder**.

![[Pasted image 20230829142543.png]]
Empezamos en i = 0. O sea, no agregamos ninguna cancion. Tenemos que probar las dos opciones. Agregar la cancion y por lo tanto sus minutos o no agregarla y seguir con el siguiente elemento?
```C++
A = CD(i+1, k)
B = CD(i+1, k-p) + p

max(A, B)
```
> Supongamos que el conjunto se representa como una secuencia. $i$ representa la posicion donde comienza. Entonces si una secuencia tiene 10 elementos e i es 3. La secuencia es el conjunto de los 10 elementos menos los primeros 3. Es una forma muy efectiva de *sacar* un elemento de un conjunto sin usar operaciones de conjunto. Ademas en un conjunto no pueden haber elementos repetidos mientras que en la secuencia si.
> ![[Pasted image 20230829142417.png]]

1. Opcion A. No agregamos el elemento ni sus minutos. Por lo tanto la cantidad sumada actual de minutos sera 0 + 0.
2. Opcion B. Agregamos el elemento por lo tanto sus minutos. Por lo tanto la cantidad sumada actual de minutos sera 0 + $p_{i}$ (en este caso, 1).
   
> Por que tenemos esto de CD(i+1, k -pi) + pi?
> - $k$ representa cuanto nos queda por gastar. Si k es menor a 0 entonces ya no tenemos nada mas por gastar.
> - Agregamos pi porque recordemos que cada iteracion de la funcion recursiva nos devuelve el maximo que se puede gastar. k -$p_{i}$ nos ayuda a saber cuando nos pasamos y asi podar el arbol.

Podemos agregar una tercera poda:
$sumaRestante(i)$ para $sumarestante(i) \leq k$. Esto nos ayuda a evitar llamadas recursivas. Si la suma restante de los elementos de la lista es menor a k entonces para que voy a seguir buscando?? Para que voy a seguir iterando? 
## Prime Ring
![[Pasted image 20230829161412.png]]

> $N \ numeros \ naturales$ $\implies$ {2, 5, 3, 6, 3}.


## Sudoku
[[Sudo ku]]

## Dobra
![[Pasted image 20230901094853.png]]
![[Pasted image 20230901101219.png]]
> Probamos todas las combinaciones y con una etapa de verificacion podemos ver si se cumplen las restricciones. 

Dejamos de seguir la solución parcial si:
- Hay 3 vocales seguidas.
- Hay 3 consonantes seguidas.

Posibles podas:
- Si hay 2 vocales seguidas, solo probamos con consonantes.
- Si hay 2 consonantes juntas solo probamos con vocales.
- Siempre empezamos los comodines para consonantes con L.
# Dynamic Programming - Top Down
## King Army

![[Pasted image 20230901105056.png]]
![[Pasted image 20230901105312.png]]

> La idea es que, mediante *memoization* guardemos las cuentas que hacemos y cuando la necesitamos simplemente accedemos al resultado.

![[Pasted image 20230901105930.png]]
![[Pasted image 20230901110237.png]]
![[Pasted image 20230901110524.png]]
## Vacations
![[Pasted image 20230901110736.png]]
![[Pasted image 20230901110808.png]]

> Esta combinacion es invalida porque en el segundo dia hacemos programacion pero ya hicimos programacion el primer dia!

![[Pasted image 20230901111310.png]]

- **Puedo hacer solo gym:**
  ![[Pasted image 20230901111557.png]]
  
  > Si descansamos entonces sumamos 1 a la solucion porque estamos *agregando* un dia de descanso. (El resultado del algoritmo me devuelve la menor cantidad de dias posibles de descanso)
  
- **Puedo hacer solo competencia:** 
  ![[Pasted image 20230901111732.png]]
- **Puedo hacer ambas:**
  ![[Pasted image 20230901111825.png]]
- **No puedo hacer ninguna:**
  ![[Pasted image 20230901112143.png]]
![[Pasted image 20230901113051.png]]


![[Pasted image 20230901151318.png]]














## Caesar’s Legions

## Fire

## Farmer

# Dynamic Programming - Bottom Up






