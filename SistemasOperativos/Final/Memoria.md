## Se nos muestra un árbol de procesos donde cada proceso tiene una serie de page frames asignados. Explicar las siguientes situaciones:
- ¿Por qué todos los procesos de un sistema compartirían una página? (páginas del kernel o bibliotecas compartidas)

Es eficiente que todos los procesos compartan paginas de memoria.

**Paginas de Kernel**: Contiene codigo y estructuras escenciales para el funcionamiento del sistema operativo. Evitamos duplicar el mismo codigo en la memoria de cada proceso. El kernel mapea estas paginas como compartidas en el espacio de direcciones de cada proceso.

**Bibliotecas compartidas**: Las bibliotecas compartidas son fundamentales para evitar la duplicacion de codigo en memoria. Bibliotecas comunes como *libc* son usadas por casi todos los procesos del sistema.
En vez de cargar una copia de la biblioteca para cada proceso, se mantiene una copia en la memoria para que todos la utilicen.

![[Pasted image 20241130161141.png]]
- Hay 3 procesos donde se ve su memoria logica contigua y al lado su page table representando las direcciones fisicas.
- Las direcciones fisicas son direcciones contiguas en una tabla que al final terminan uniendo las fisicas como contiguas.

Generalmente, para ambos casos, se mapean como solo lectura. Si un proceso intenta modificarla se genera un page fault y se asigna una copia privada al proceso.

- ¿Por qué dos procesos específicos podrían compartir una página? (hablar de fork y copy-on-write)
Cuando hacemos un fork queremos un proceso que sea un clon del proceso padre, esto implica mismas variables, estado del stack, etc. Pero si son iguales no hace falta copiar las paginas para el proceso nuevo y tener datos repetidos en la memoria principal. Si alguno de los procesos modifica alguna de las paginas estas se duplican y queda un proceso con los datos originales y otro con los datos modificados. (copy-on-write, copiamos recien cuando hubo una modificacion y no arbitrariamente)


##  ¿Para qué sirve la paginación de la memoria? ¿Qué ventajas tiene sobre utilizar direcciones físicas? Hablar sobre el tamaño de las páginas y cómo se relaciona con el tamaño de los bloques en disco. (hablar de fragmentación interna y fragmentación externa)

1. Sirve para resolver el problema de fragmentacion externa. Uno de los problemas de la memoria es que dependiendo del algoritmo que usemos para asignar memoria (first-fit, best-fit o worst-fit) puede suceder que exista el espacio necesario para agregar un proceso nuevo pero que no sea contiguo impidiendo la carga de este. Con paginacion simplemente le pedimos una pagina libre al kernel y que el proceso la interprete como contigua. De esta manera el limite sera siempre la cantidad de paginas libres con respecto a un proceso nuevo (falta de espacio) y no necesariamente una mala decision de algoritmo de asignacion como antes. Ojo, esta solucion genera fragmentacion interna donde tal vez una pagina solo es usada por una fraccion del proceso por loq ue queda espacio de mas inutilizado.
2. Podemos usar direcciones logicas contiguas que en realidad no son contiguas en memoria fisica. De esta manera si el espacio total libre en memoria es mayor al proceso, tenemos asegurado que nuestro proceso va a poder ser asignado a memoria a diferencia de memoria fisica donde si hay 4gb libres pero son de a bloques contiguos pero separados de 1gb 1gb 2gb y mi proceso es de 3gb no podria asignarlo.
3. El tamano de las paginas y el de los marcos de pagina en disco son iguales. De esta manera podemos tener una capacidad de *memoria swap* donde mandamos paginas de procesos al disco cuando la memoria principal esta llena. Luego si la pagina es requerida por el proceso en ejecucion, se la busca de disco, se la swapea con otra pagina en memoria y se la usa. Es una manera de estandarizar la memoria con el disco y tener una facil interaccion entre ambos. 

La tabla de paginas es un mapa que traduce cada direccion logica del proceso a su correspondiente direccion fisica, permitiendo la ilusion de contiguidad.

Un tamano de pagina mas grande reduce la cantidad de entradas en la tabla de paginas pero aumenta la fragmentacion interna.
Un tamano de pagina mas pequena minimizan la fragmetacion interna pero generan mas overhead en las tablas y mas swaps entre memoria y disco.

## ¿Qué es un page fault y cómo se resuelve?

Un page fault sucede cuando un proceso intenta acceder a una pagina de memoria que no esta actualmente cargada en la memoria principal.
Puede suceder porque la pagina fue movida a disco o todavia no fue cargada a la memoria principal o es una direccion invalida.

1. La mmu detecta que la pagina solicitada no esta en memoria. Interrupcion. (bit de presencia 0)
2. Se verifica si el acceso es valido. Si es valido significa que la pagina esta en el disco. Si no lo es, se genera un seg fault.
3. Se busca la pagina en el area de swap (disco) y se lo carga en un marco de pagina libre en la memoria ram.
4. Se actualiza la tabla de paginas del proceso.
5. Se reanuda el proceso.

## ¿Por qué puede pasar que tengamos muchos procesos en waiting, y cómo podría tratar de arreglarlo si no pudiese agregar memoria?

Podria pasar que los procesos esten esperando a que las paginas que necesitan para continuar su ejecucion sean buscadas del disco y swapeadas por paginas actuales porque no se encontraban en la memoria principal (*thrashing*), tengamos en cuenta que el disco es lento, muy leeeentoooooo. 

Soluciones:
- Reducir la cantidad de procesos activos, posponer su ejecucion. Se pueden suspender procesos menos prioritarios para liberar memoria.
- Cambiar el algoritmo de reemplazo de paginas para usar uno mas adecuado para el trabajo (FIFO, LRU, Clock).
- Cambiar politicas de scheduling como usar Shortest Job First para ayudar a disminuir los tiempos de espera en ciertos escenarios.
- Optimizar procesos para que usen menos memoria.
- Limitar la cantidad de proceso ejecutando simultaneamente.

El principal problema es el **thrashing** causado por la falta de memoria.