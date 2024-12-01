##  Hablar de RAID (para qué sirve). Explicar la diferencia entre RAID 4 y RAID 5. ¿Cuál es mejor y por qué?

La idea de RAID es tener multiples dispositivos para guardar data. 
Podemos guardar la misma informacion en dispositivos distintos (RAID 1), luego si alguno de estos se rompe, tenemos el otro como backup. Es conveniente porque ademas podemos leer el mismo conjunto de datos de diferentes dispositivos al mismo tiempo (trabajo en paralelo).
Tambien podemos guardar secciones de toda la data en diferentes discos y si alguno se rompe no perdimos toda la informacion. (RAID 0).

**Raid 4**: Se separa la data y se pone en diferentes discos. Cada bloque esta en un solo disco. Si algun bloque se dana hay metadata que ayuda a reconstruir la informacion perdida. Requiere 1 disco de paridad.
Como los bloques estan distribuidos a traves de multiplis discos tenemos lectura en paralelo -> Entrada/Salida mas eficiente.
Hay cuello de botella por el disco de paridad, todas las escrituras lo necesitan.
![[Pasted image 20241130184623.png]]

**RAID 5**: Cada bloque de cada archivo va a un bloque distinto. Para cada bloque uno de los discos tiene los datos y otro tiene la informacion de paridad. De esta manera ya no hay mas cuello de botella para las escrituras y se puede perder algun disco, total se reconstruye con los otros.

![[Pasted image 20241130190247.png]]

*Informacion de paridad*: Ayuda a la reconstruccion de data manteniendo la integridad de los bloques.

## Explicar los distintos algoritmos básicos de scheduling de disco. Explicar cómo se comportan en HDD y en SDD.

**FIFO**: La cabeza del disco se mueve a los numeros de cilindros en orden de llegada.
**Shortest Seek Time First**: Se atiende el pedido mas cercano a donde esta la cabeza actualmente. Mejora los tiempos de respuesta pero puede generar inanicion porque si llegan muchas solicitudes de secciones cercanas indefinidamente entonces una seccion lejana se queda sin servicio.
**Elevator**: Ir primero en un sentido y luego en el otro sentido. Cuando va en un sentido atiende los pedidos que estan en esa direccion.
Si llega una solicitud para un cilindro anterior al que acabamos de pasar entonces este tendra que esperar a que cambie la direccion de atencion de pedidos.

Los **SSDs** simplemente usan FIFO porque no tienen movimiento de cabeza. La lectura es uniforme pero la escritura no lo es.

## ¿Qué son los drivers y qué permiten?

Los drivers son software que corren con los mayores privilegios. Estos implementan la API estandarizada para un dispositivo dado. 
La idea es que sean un programa especializado para un dispositivo y nos abstraiga la implementacion de diferentes funciones que el sistema operativo quiere llamar sobre este. 
Estos permiten una traduccion de funciones que usa el kernel a instrucciones del controlador particulares para el diseno del dispositivo. Sin los drivers tendriamos que implementar las funcionalidades a mano para cada dispositivo desde nuestras aplicaciones.

## Explicar diferencias entre un disco magnético y un SSD. ¿Qué problemas tiene un SDD? Hablar de write amplification y borrado.

El disco magnetico tiene una cabeza que se mueve de manera mecanica por todos los cilindros y de esta manera lee las diferentes secciones de este. Esto hace que leer sea muy lento porque estamos literalmente moviendo piezas mecanicas. Por eso en punto santeriores se hizo incapie en estrategias para reducir la busca de informacion.

Los SSDs se acercan mas a la tecnologia de una memoria flash. Son mucho mas rapidos que los discos duros y con los anos se hicieron mas barato per mb. Una de las diferencias es que a medida que avanza el tiempo los NVM disminuyen su calidad de escritura en cuanto a velocidades. Depende de que tan usado este. Esto se debe a un exceso en los ciclos de borrado.

Es necesario borrar la memoria antes de poder escribirla. El proceso de escribir a memoria implica mover la seccion usada de un bloque a alguna ubicacion no usada y luego borrar todo el bloque para poder escribir en la ubicacion deseada.

## ¿Cómo hace un disco para saber si un bloque está libre / si puede ser borrado? Explicar cómo podemos indicarle a un SDD que un bloque está libre (y que puede borrado). (comando TRIM)


## Explicar cómo se puede hacer una recuperación de datos, después de haber borrado un archivo.