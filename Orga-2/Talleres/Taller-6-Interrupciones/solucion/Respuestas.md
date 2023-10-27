1. El modo real es el modo en el que empieza el procesador al iniciar la PC. Solo cuenta con 16 bits de direccionamiento  y solo puede usar los 20bits mas bajos del bus por lo que podemos direccionar hasta 1mb de memoria. Sin niveles de privilegios, toda la ISA disponible.
El modo protegido es el modo nativo del procesador. Cuenta con 32 bits de direccionamiento por lo que puede direccionar 4gb de memoria. Cuenta con niveles de proteccion y las instrucciones dependen del nivel de privilegio actual.
2. El problema del modo real es la falta de privilegios y la memoria direccionable. Sin los niveles de privilegio cualquier tarea podria acceder a cualquier informacion dentro de la memoria y podria, en el peor de los casos, romper el kernel. La cantidad de memoria direccionabble tambien seria un problema teniendo en cuenta que hoy en dia es normal que un sistema operativo consuma 4gb de ram en IDLE. 
3. La GDT es la tabla donde se definen los segmentos del sistema con sus respectivos privilegios y estado de escritura-lectura. Cada vez que un proceso quiera acceder a algun segmento tiene que pasar por la GDT para determinar si tiene o no la autorizacion requerida.

- 31-24, 7-0, 31-16: La ubicacion de la base del segmento. Son 3 campos que juntos forman la base del segmento de 32 bits (8bits + 8bits + 16bits)
- 15-0, 19-16: Determina el tamano del segmento.
- 11-8: Tipo de segmento, hay 2, expand-up y expand-down. Expand-up: El offset va desde 0 al limite del segmento. Expand-down: El offste va desde limit+1 hasta FFFFFFFH.
- 12: S tipo de descriptor, del sistema o de codigo/data.
- 14-13: DPL. Nivel de privilegio.
- 15: Indica si el segmento esta en la memoria o no.
- 20: AVL. bit reservado para lo que quieras.
- 21: Indica si las instrucciones se ejecutan en modo 64 bits o en modo compatible.
- 22: 
- 23: Si la G esta en 0, Interpreta el limite en bytes. Cuando G esta en 1 interpreta el limite de a 4kbytes.

4. 1010

6. gdt[] es el arreglo con todos los descriptores de segmento. GDT_DESC nos dice cuantos descriptores de segmento hay y en que posicion esta el base pointer.
7. 
