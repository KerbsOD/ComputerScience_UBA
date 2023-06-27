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

3. Etiqueta "finDividir"
    1. Contiene el ret del programa.
        ```riscv
        ret
        ```

---
# Ejercicio 2 - Sumar_Extender

---
# Ejercicio 3 - Segunda_Mitad

---
# Ejercicio 4 - Numero_Impar
---