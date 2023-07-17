# Direct Adressing
---
Universo U donde hay claves unicas y cada una tiene una posicion en el arreglo. Quiere decir que el slot *k* corresponde a la clave *k*. 

![[Pasted image 20230716190749.png]]

- *Buscar*: $\mathcal{O(1)}$
- *Inertar*: $\mathcal{O(1)}$
- *Eliminar*: $\mathcal{O(1)}$


## Funciones
Sea "h" a nuestra funcion de *hashing*. Llamamos *hash value* a h(k).
La funcion "h" mapea los valores del universo "U" de claves en *slots* de nuestra *hash table*

- El tamano de nuestro arreglo es *menor* al tamano del unvierso a insertar. 
- Decimos que una clave "k" hashea a un slot h(k).
- Tratamos de interpretar las claves como numeros naturales para asignarles una posicion.

![[Pasted image 20230716195024.png]]


> Llamaremos $\alpha$ a nuestro  *load factor* y lo calculamos de la siguiente manero:
> $\alpha$ = n/m
> - Siendo n la cantidad de elementos en nuestro universo.
> - Siendo m el tamano de la tabla de hash.


### Metodo de division
A partir de una clave *k* y un arreglo de tamano  *m*. Nuestro *hash value* sera el resto entre la division de k sobre m.
> h(k) = k mod m

- m no deberia ser una potencia de 2. Pues todos los valores irian al 0 o al 1.
- elegir un m primo muy alejado de una potencia de 2.

### Metodo de multiplicacion
A partir de una clave k, un arreglo de tamano m y una constante A tal que 0 < A < 1.
1. Multiplicamos A y k.
2. Agarramos la parte fraccional de esta multiplicacion y la multiplicamos por m.

> h(k) = floor(m * kA)

#### Encadenamiento
En cada slot hay una lista doblemente enlazada, cuando insertamos un elemento lo hacemos en el inicio de la lista enlazada.
- *Buscar*: $\mathcal{O(n)}$
- *Inertar*: $\mathcal{O(1)}$
- *Eliminar*: $\mathcal{O(n)}$

> Podemos asumir que todos los elementos tienen la misma probabilidad de ser hasheados a cualquier slot del hash table. A esto lo llamamos *simple uniform hashing*.

Buscar un elemento que no existe en la hash table doblemente enlazada tiene un caso promedio *$\theta(\alpha + 1)$*



# Open Adressing
---
En open adressing todos los elementos ocupan un espacio en la tabla de hash. Cada slot de la tabla tiene un elemento o nil.

#### Linear probing
> h(k, i) = (h'(k) + i) mod m
- Si el slot esta ocupado, probamos con el de al lado. 
- Si todos los slots estan ocupados entonces no podemos insertar en la hashtable.
- *Buscar*: $\mathcal{O(n)}$
- *Inertar*: $\mathcal{O(n)}$
- *Eliminar*: $\mathcal{O(n)}$
#### Quadratic probing
> h(k, i) = (h'(k) + $c_{1}i$ + $c_{2}i^2$) mod m

#### Double hashing
> h(k, i) = $(h_{1}(k) + i*h_{2}(k))$ mod m

- La idea es que primero se va a h1(k). 
- Si no es exitoso, se aumenta i y se prueba nuevamente.
- El i nos da un nuevo offset.
- Tener en cuenta que la primer vez, i = 0. Por lo que en el primer intento de hashing, double hashing es igual al metodo de division.

Ejemplo:
- $h_{1}(k) = k\ mod\ 13$
-  $h_{2}(k) =1 + (k \ mod \ 11)$

$h_{1}(14) = 1$
$h_{2}(14) = 4$

$h(k, i)\ =\ (h_{1}(k)\ +\ i*h_{2}(k))\ mod\ m$ 
$h(14, 0)\ =\ (h_{1}(14)\ +\ 0*h_{2}(14))\ mod\ 13$ = 1 + 0 mod 13 = 1 *Ocupado!*
$h(14, 1)\ =\ (h_{1}(14)\ +\ 1*h_{2}(14))\ mod\ 13$ = 1 + 4 mod 13 = 5 *Ocupado!*
$h(14, 2)\ =\ (h_{1}(14)\ +\ 2*h_{2}(14))\ mod\ 13$ = 1 + 8 mod 13 = 9 *Libre!, lo ocupamos con nuestro k (14)*



![[Pasted image 20230716221328.png]]