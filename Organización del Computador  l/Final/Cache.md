# Cache
- Se trata de un banco de _SRAM_ que contiene una copia de los datos e instrucciones que estan en la memoria principal.
- Datos disponibles cuando el procesador los necesita, accediendo a estos de manera **inmediata**.
- Es combinada con una gran cantidad de _DRAM_ que almacena el resto de instrucciones y datos.
- Requiere de hardware adicional que asegure contener los datos mas frecuentemente utilizados por el procesador.

**HIT**: Se accede a un item y este se encuentra en el cache.
**MISS**: Se accede a un item y este no se encuentra en el cache. Si la búsqueda de una instrucción o de un operando en el cache falla, entonces el procesador debe recurrir a la memoria principal. La demora en el acceso hace que el pipeline de instrucciones se atasque (stall).
**HIT-RATE**: cantidad de hits sobre cantidad total de accesos.

![[Pasted image 20230728111739.png]]
 


## Controlador Cache

El controlador de cache trabaja mediante 2 principios.

**Vecindad Temporal**: Si un item es referenciado, es altamente probable que sea referenciado en el futuro.

**Vecindad Espacial**: Si un item es referenciado, es altamente probable que un item cercano sea tambien referenciado.

## Algoritmos de reemplazo de contenido
- **LRU**: Least Recently Used.  
- **LFU**: Least Frecuently Used.  
- **Random**:   
- **FIFO**: First in first out.  

## Coherencia de un cache
Una variable que esta en el cache tambiein esta en la memoria. Ambos valores deben ser iguales. Que pasa cuando el procesador la modifica? hay que mantener la consistencia.

Modos de actuacion:
- **Write Through**: El procesador escribe en la DRAM y el controlador cache refresca el cache con el dato actualizado.
- **Write Through Buffered**: El procesadro actualiza la SRAM cache, luego el controlador cache actualiza la copia en la DRAM.
- **Copy Back**: Se marcan las líneas de la memoria cache cuando el procesador escribe en ellas. Luego en el momento de eliminar esa línea del cache el controlador cache deberá actualizar la copia de DRAM.

## Cache Multinivel
![[Pasted image 20230728122441.png]]

Donde la memoria del cache l2 es mayor a la del cache l1.
La velocidad del cache l1 es mayor a la del cache l2

**Ejemplo del Supermercado**
- Supermercado -> _memoria ram_
- Heladera -> _cache L2_
- Mesa -> _cache L1_
- Procesador -> _la persona que quiere almorzar_

La idea es que en el supermercado (_memoria_) esta todo lo que podemos almorzar. En nuestra heladera guardamos lo que probablemente vamos a almorzar. En nuestra mesa tenemos lo mas probable que vamos a almorzar.

No vamos a ir al supermercado a buscar item por item lo que queremos almorzar. Agarramos un subconjunto de items y los traemos a casa. (_caching_)

Una tipica computadora personal tiene la cache L1 en el procesador y la cache L2 entre el procesador y la ram.




