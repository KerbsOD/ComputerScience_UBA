# Programacion Orientada a datos

## Memoria Principal
![[Pasted image 20230823084324.png]]
La memoria principal es una *tira* contigua de bits (o bytes para que sea mas facil).
Depende de la arquitectura del cpu, se pueden direccionar una cierta de cantidad de bytes a la vez. Por ejemplo en la tabla de arriba el CPU es de 32 bits por lo que puede direccionar 4 bytes a la vez. Pero **las direcciones son a byte siempre**.

Que quiero decir? la direccion 0x0 es del bit 0 al 7, la 0x1 del bit 8 al 15, la direccion 0x2 del bit 16 al 23 y la 0x3 del 24 al 31.

![[Pasted image 20230823090012.png]]
En esta imagen la variable height ocuapa 1 byte. **Está en la dirección 0x1 de memoria total**.

> Aunque el procesador sea de 32 bits, realmente podemos poner datos a byte. La unica diferencia es que el PC se mueve de a 4bytes(32bits). 


### Tipos Atómicos
![[Pasted image 20230823094611.png]]

### Structs
![[Pasted image 20230823095415.png]]

O sea, las structs son literalmente datos de tamaños variables juntos en memoria y solo se pueden acceder con el identificador del struct.

```C
struct s {
uint16_t i;
char c;
}

struct s obj = {4, 0};
printf("%", obj.i)

>>> 4
```
En este ejemplo definimos la estructura s. Luego creamos el objeto "obj" que esta basado en la estructura s y para acceder a i de obj debemos llamarlo de esta manera. **No se puede acceder a i de otra forma**.

### Arreglos
![[Pasted image 20230823100408.png]]
Supongamos que type_t tiene un tamaño de 1 byte. Entonces para acceder a la siguiente posicion del array simplemente sumamos 1 byte. Es altamente importante que los arrays tengan elementos de un mismo tamaño para que acceder a una posicion de memoria sea constante. 
Supongamos esta data:
- Arreglo arr de tamaño N 
- Direccion donde comienza el arreglo: 0x14A3.
- Tamaño del tipo: 1 byte
- Queremos acceder a arreglo[5].
La forma que tiene la computadora para acceder a la posicion 5 de manera constante es:
$0x14A3 + 5*1$. A la posicion de inicio le sumamos la cantidad de posiciones que tenemos que avanzar por el tamaño en bytes del tipo de dato. Porque cada posicion ocupa 1 byte.
Entonces el dato arr[5] está en la posicion 0x14A8

![[Pasted image 20230823101638.png]]
El arreglo comienza en la posicion 0x1. Esta es la unica informacion que guardamos.

### Pointers
![[Pasted image 20230823102205.png]]
Tienen el mismo tamaño que las direcciones de nuetra arquitectura. En este caso la arquitectura es de 32 bits por lo que los pointers son de 4 byts (32 bits).

![[Pasted image 20230823104234.png]]
Lo que podemos leer es que para acceder al dato del arr[0] simplemente hacemos la suma de la direccion donde comienza el array, le sumamos el offset (en este caso 0 porque es la posicion 0) y luego desreferenciamos esa posicion $\implies$ dame el dato de esa posicion.

![[Pasted image 20230823104750.png]]
![[Pasted image 20230823104800.png]]
 Lo que entiendo es que todas las variables y arreglos apuntan a una direccion de memoria y cuando pedimos ver cuanto valen automaticamente te dan \*variable.
 La diferencia de los punteros es que no guardan informacion, guardan otra direccion! 
 Si yo desreferencio un puntero le estoy diciendo que vaya a otra direccion y que lea eso.


### Como sabe el pointer cuantos bytes moverse?
![[Pasted image 20230824114200.png]]
En esta funcion vemos que creamos un pointer char llamado iterador. En el while, hacemos iterador++. Por que iterador + 1 es igual a la siguiente posicion de memoria????
- Al ser un char\*, C le suma 1 byte cada vez que le sumo 1 al iterador.
![[Pasted image 20230824163844.png]]

# Alineacion de los datos en Memoria
![[Pasted image 20230823114000.png]]
![[Pasted image 20230823114131.png]]

> Nos esta diciendo que solo podemos leer direcciones multiples de 4, no cada 4 bytes. O sea, solo se pueden leer la 0x0, 0x4, 0x8, 0x12, etc.

Tenemos que leer el ultimo byte de 0x0(0x3-0x4) y luego leer el primer byte de 0x4(0x4, 0x5).
![[Pasted image 20230823132936.png]]
Todo lo siguiente es suponiendo que donde esta toda la data es el registro RBX de 64 bits.

- Movemos la data del registro RBX a la parte baja del registro R10
  R10d son los primeros 32 bits del registro R10
  ![[Pasted image 20230823114654.png]]
-  Movemos la data del registro RBX + 4 (osea, 0x4-0x8) a la parte baja del registro R11.
  ![[Pasted image 20230823123339.png]]
- Hacemos 24 bit shifts sin signo para la derecha sobre la parte baja del registro R10. Esto hace que ahora este en las primeras posiciones del registro R10.
  ![[Pasted image 20230823123348.png]]
- Hacemos 8 bit shifts sin signo para a izquierda sobre la parte baja del registro R11. Esto hace que ahora tenga 8 ceros al incio del registro R11, bastante util.
  ![[Pasted image 20230823133803.png]]
- Hacemos un or entre la parte baja de R10 y R11 y lo guardamos en el Registro 10. Como sabemos el or "agrega los bits" del r11 al r10. Como todo lo que no es la primera mitad de i es 0, entonces ganamos la informacion de la primera mitad de i y c.
  ![[Pasted image 20230823123404.png]]
- Guardamos la data de la parte baja de la parte baja de R10 en AX. (o sea, los primeros 16 bits) 
  ![[Pasted image 20230823123411.png]]
## Datos alineados a n bytes
![[Pasted image 20230823134821.png]]
![[Pasted image 20230823134713.png]]
- Un dato esta **alineado a n bytes** si la posicion en la que comienza es multiplo de **n**.
- Un Tamaño de dato esta **alineado a n bytes** si es multiplo de **n**.
El Compilador va a hacer lo siguiente para que se cumplan estas condiciones:
![[Pasted image 20230823135136.png]]
![[Pasted image 20230823143908.png]]
![[Pasted image 20230823153943.png]]
- Nombre es un puntero por lo que ocupa el mismo espacio que la arquitectura del CPU. 64 bits. Empieza en la posicion 0 de la memoria. 64 bits son 8 bytes.
- Comision es un char por lo que cupa 1 byte. Poiscion 8 de la memoria.
- Dni es int por lo que ocupa 4 bytes. Posicion 12 de la memoria. 8 + 4bytes. Como dni es de 4 bytes, debe estar en un multiplo de 4.(*alineado a 4 bytes*)

![[Pasted image 20230823155917.png]]
# Stack y Heap
Existen 3 tipos de datos: Estaticos, Dinamicos y temporales.
Los estaticos pueden ser constantes.. Los dinamicos son los que se allocan en el heap y luego hay que eliminarlos. Los temporales son los que se encuentran en el scope de una funcion.

![[Pasted image 20230823161217.png]]

![[Pasted image 20230823170714.png]]

![[Pasted image 20230824115447.png]]

Las direcciones de 32bits normalmente se leen en Hexadecimal.
![[Pasted image 20230824115825.png]]
> Notar que cada 4 bits representamos un numero hexadecimal.

Que la computadora pueda direccionar como minimo de a byte no significa que las direcciones sean de a byte.

En una arquitectura de 32 bits. Como 1 byte(8bits) es la unidad mas pequeña direccionable, se divide en 4 celdas de 1 byte.
Luego para direccionar memoria, esas 4 celdas se dividen en 8 celdas de 4 bits para representarlas de manera hexadecimal.
![[Pasted image 20230824121403.png]]

![[Pasted image 20230824121807.png]]
1. 4 bytes (32 bits)
2. 8 celdas de 4 bits (para representarlos hexadecimal, 2$^{4}-1$, del 0 al 15)
3. Cada celda te da un numero
4. Juntamos todos los numeros y tenemos una direccion en memoria.