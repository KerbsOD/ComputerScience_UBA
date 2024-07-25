# Aclaraciones
---
# Ejercicio 1 - Dividir
Para este ejercicio vamos a usar los siguentes registros:

- __a0__: Guarda el valor de *accum*.
- __a1__: Guarda el valor de *a*.
- __a2__: Guarda el valor de *b*.
- __t0__: Empieza valiendo 1. Si *a* es negativo, vale -1. 

El concepto de la implementacion es tener un registro t0 que vale 1 o -1. Mientras que *a* >= b, le resto *b* a *a* y le sumo t0 a *accum*. Este loop se realiza n veces. Sumar 1 n-veces a *accum* es lo mismo que sumar n una vez, siendo n = *a*/*b*. ( *accum* = *accum* + *a*/*b* ).

Esto nos sirve solo si *a* es positivo. Si *a* es negativo seteamos t0 = -1, en vez de sumar 1 sumamos -1 ( *accum* = *accum* - *a*/*b* ).
Para poder reutilizar la etiqueta "LoopDividir" le cambiamos el signo a *a* entonces funciona mientras *a* >= *b*. 

La division va a ser exactamente igual que cuando *a* es positiva pero en vez de sumar 1 n veces a *accum* le vamos a sumar -1 n veces.

1. Etiqueta "call_dividir"
   1. Si a == 0 o b <= 0 entonces terminamos el programa.
    
        ```riscv  
        beqz a1, finDividir         
        blez a2, finDividir
        ```
   2. Inicializamos t0 = 1. Si a >= b entonces hacemos la division.
    
        ```riscv
        li t0, 1                    
        bge a1, a2, LoopDivision    
        ```

   3. Se puede dar el caso donde la razon por la cual *a* < *b* 
   es porque *a* es negativo pero |*a*| >= *b*. Cambiamos el signo de *a* complemento a 2 y seteamos t0 = -1. Si |*a*| >= *b* entonces hacemos la division "negativa".

        ```riscv
        neg a1, a1                  
        li t0, -1
        bge a1, a2, LoopDivision
        ```
   4. En caso de que a < b y |a| < b entonces la division da 0. Terminamos el programa.

        ```riscv
        j finDividir
        ```

2. Etiqueta "LoopDivision". 
    1. En cada iteracion del ciclo queremos realizar la operacion *a* = *a* - *b*. 
        ```riscv
        sub a1, a1, a2              
        ``` 
    2. Le sumamos t0 a *accum*.
        ```riscv          
        add a0, a0, t0              
        ``` 
    3. Si *a* >= *b* entonces repetimos el ciclo.
        ```riscv         
        bge a1, a2, LoopDivision 
        ``` 
    4. Si *a* < *b* terminamos el programa.
        ```riscv         
        j finDividir 
        ``` 

3. Etiqueta "FinDividir"
    1. Contiene el ret del programa.
        ```riscv
        ret
        ```

---

# Ejercicio 2 - Sumar_Extender
Para este ejercicio vamos a usar los siguentes registros:

- __a0__: Guarda el valor de *accum*.
- __a1__: Guarda el valor de *a*.
- __a2__: Guarda el valor de *b*.

Si necesito pasar *a* de 16bits a 32bits complemento a 2 entonces necesito preservar el signo si es que *a* es negativo. Para esto hago 16 shifts logicos a la izquierda, de esta manera estoy moviendo el valor de *a* hasta la parte "alta" de los 32bits poniendole unicamente 0s atras (tambien pudo ser logico pero en el paquete basico de riscv no se encuentra la funcion).
Luego hago 16 shifts aritmeticos a la derecha, como *a* se encuentra en la parte "alta", su signo se encuentra en el bit mas significativo y el shift aritmetico nos conserva el signo, entonces toda la parte "alta" de *a* se va a llenar de su bit mas significativo.


1. Etiqueta "call_sumar_extender"
   1. Hago 16 shifts logicos a la izquierda sobre *a* y luego 16 shifts aritmeticos a la derecha sobre *a*.
        ```riscv
        slli a1, a1, 16 
        srai a1, a1, 16  
        ```
   2. A *b* le sumo *a* y luego a *accum* le sumo *b*.
        ```riscv
        add a2, a2, a1
        add a0, a0, a2
        ```

2. Etiqueta "FinExtender"
    1. Contiene el ret del programa.
        ```riscv
        ret
        ```
   
---

# Ejercicio 3 - Segunda_Mitad
Para este ejercicio vamos a usar los siguentes registros:

- __a0__: Guarda el valor de *a*.
- __a1__: Guarda el valor de *index*.
- __a2__: Guarda el valor de *length*.

Para dividir lenght hacemos un shift aritmetico a la derecha, esto lo divide por 2 y al ser aritmetico conserva el signo. Luego comparamos length/2 con el index, si index es mayor saltamos a la etiqueta que setea *a* a 1, otherwise terminamos el programa.


1. Etiqueta "call_segunda_mitad"
   1. Inicializo a = 0, se supone que por defecto es 0 y vale 1 si y solo si Index >= Length/2. Divido Length por 2 con un shift aritmetico a la derecha.
        ```riscv
        li a0, 0            
        srai a2, a2, 1 
        ```
    2. Si Index >= Length/2, entonces saltamos a la etiqueta que modifica *a*.
        ```riscv
        bge a1, a2, setOne
        ```
    3. En el caso donde Index < Length/2 simplemente termino.
        ```riscv
        j FinSegundaMitad
        ```

2. Etiqueta "setOne"
    1. Seteamos a = 1 y terminamos.
        ```riscv
        li a0, 1            
        j FinSegundaMitad   
        ```

3. Etiqueta "FinSegundaMitad"
    1. Contiene el ret del programa.
        ```riscv
        ret
        ```



---

# Ejercicio 4 - Numero_Impar
Para este ejercicio vamos a usar los siguentes registros:

- __a0__: Guarda el valor de *a*.
- __a1__: Guarda el valor de *index*.
- __a2__: Guarda el valor de *length*.

El operador ANDi hace la interseccion bit a bit de un registro y un numero. Si en la misma posicion hay un 1, entonces se guarda un 1. Si en la misma posicion uno tiene un 1 y el otro 0, se guarda el 0.

Para saber si el valor de un registro es impar puedo usar esta operacion con el valor del registro y el numero 0x00000001. Si el valor del registro es impar, su primer bit es 1. Se guarda el 1 y como el resto de 0x00000001 son 0s, simplemente me queda 0x00000001 en el registro. Si el numero es par entonces la interseccion entre 1 y 0 me deja el registro en 0x00000000.


1. Etiqueta "call_numero_impar"
   1. Comparo a bit a bit con el numero 0x00000001, guardo 1 si es impar, 0 si no y termino el programa.
        ```riscv
        li a0, 0            
        srai a2, a2, 1 
        ```
---