# Intencion
Distribuir el procesamiento de una request mediante la delegacion polimorfica.

En algo2 cuando haciamos la igualdad observacional teniamos que comparar cada observador por separado y hasta de manera recursiva para saber si 2 TADs eran iguales. En este caso, la comparacion de objetos se hace comparando sus colaboradores internos; que estan compuestos por otros objetos (integers por ejemplo) que tienen su respectiva operacion de comparacion y asi hasta llegar a comparar primitivas del sistema.

La comparacion "=" entre dos objetos es un ejemplo claro de **Object Recursion**. La implementacion de un mensaje recursivo manda el mismo mensaje a uno o mas colaboradores internos  y asi sucesivamente.
El mensaje navega por toda la estructura hasta las "hojas" que pueden simplemente implementar el mensaje y volver.

![[Pasted image 20240524073308.png]]

En este ejemplo estamos comparando dos engines. Dos engines son iguales si su "size" y "power" son iguales. Estamos enviando el comparador "=" de manera recursiva hasta llegar a la primitiva anInteger que si sabe implementar la comparacion. 

El patron se basa en la delegacion del mensaje.

Es como numeros de Peano donde el mensaje previous se delegaba hasta llegar al 1. No es un ejemplo muy preciso porque cada numero tenia el comportamiento de modificar el string mientras se delegaba.

# Usos Conocidos
- Algoritmo para imprimir un objeto como un string. El algoritmo imprime la raiz como un string y le dice de manera recursiva a sus hijos que lo hagan.
