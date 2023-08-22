# Registros 

Las *word* en intel son de 16 bits.

Diagrama del 8086 de 20 bits.
![[Pasted image 20230821202159.png]]
- **AX:** Acumulador-Registro Privilegiado. Antes las operaciones solo se hacian con el registro *AX* por lo que se usaba para acumular informacion, como un sumador.
- **BX:** Registro Base. Un registro para utlizar como puntero de direccion base. Este registro apunta a una direccion de memoria. (AKA puntero)
- **CX:** Counter. Algunas instrucciones del 8086 decrementan al registro CX. Entonces podes cargar la cantidad de loops en *CX* y luego usar instrucciones que lo decrementen automaticamente. Obviamente algunas instrucciones de salto usan este registro de flag para saltar o no.
- **DX:** Data. Sirve para guardar datos comunes.
- **SI:** Source Index. Puntero a memoria
- **DI:** Destination Index. Puntero a memoria.
- **BP:** Base Pointer. Puntero base a la pila.
- **SP:** Stack Pointer. Puntero a la pila.
- **IP:** Instruction Pointer. Apunta a la siguiente instruccion. Hay que incrementarlo manualmente pues en intel las instrucciones son de **tamaño variable**.
- **Flags:** Estado de la maquina.
- **CS:** Code Segment. Es un segmento de memoria donde tengo las instrucciones de un programa.
- **SS:** Stack Segment. La pila.
- **DS:** Data Segment. Apunta a segmento de datos.
- **ES:** Extra Segmen. Apunta a segmento de datos.

**Segmento:** Es un pedazo de memoria  de tamaño variable. Comienza en una direccion y mide una cantidad determinada de bytes.

Diagrama del 8086 de 32 bits.
![[Pasted image 20230821204822.png]]
- **FS:** Segmento de datos.
- **ES:** Segmento de datos.

Diagrama 8086 de 64 bit
![[Pasted image 20230821205743.png]]
Tenemos registros FPU para operaciones de punto flotante y registros XMM para multimedia. LOs MMX ya estan  descontinuados.

**R8-R15:** Registros de 64 bits para proposito general.

Se puede acceder a los registros de 32 bits en la arquitectura de 64bits poniendo **R** de prefijo.

> Ejemplo: Si quiero acceder al registro EAX debemos usar el prefijo REX. Inc REX EAX.

En Intel la entrada/salida tiene un port separado de la memoria principal. Te obliga a usar instrucciones especificas para operar en la entrada/salida.

#### Segementacion
Espacio variable dentro de la memoria para almacenar nuestro programa o datos.
Cuando el instruction pointer empieza al inicio de un segmento, esta en la linea 0. El offset es a partir de un segmento y **no** a partir la memoria total.
El *CS* te dice donde empieza el codigo y el *IP* te dice donde estas parado. SI el *IP* vale 0, estas en el primer byte del *codigo*.

> Supongamos que el *IP* estaba en la posicion 4 de un codigo. Si el codigo empezaba en la posicion 8000 , entonces el *IP* estaba realmente en la posicion 8004 . Si ahora el sistema operativo lo movio a la posicion 1000000. Entonces el *IP* va a seguir en la posicion 4 pero gracias al offset realmente esta en la posicion 1000004. Es muy comodo!

![[Pasted image 20230821214831.png]]

Hoy en dia los segmentos pueden ser del mismo tamaño de la memoria total.

#### Direccionamiento indice.escala + desplazamiento
![[Pasted image 20230821220648.png]]
- Dir_tabla: la direccion de un dato en una tabla
- mascara: un dato

1. **mov exc, size_tabla**. Mueve el tamaño de la tabla al registro ecx. Recordemos que este registro es *contador*
2. **xor esi, esi**. La forma mas rapida de setear un registro a 0.
3. **and [esi.4 + Dir_tabla], mascara**. Como esi vale 0, se hace el and entre la primer direccion de la tabla y mascara.
4. **inc esi**. Incremento esi para que pase a la siguiente posicion de la tabla.
5. **loop mas**. Loop chequea si el registro ecx vale 0. Si vale 0 *no salta*, caso contrario salta a la etiqueta.

> Multiplicamos por 4 porque los datos de la tabla son de 32 bits!
> Entonces la posicion 1 va a estar en [0 + Dir_tabla]. La poscion 2 va a estar en [4 + Dir_Tabla], etc etc.

