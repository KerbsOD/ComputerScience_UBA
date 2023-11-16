### Habilitar Paginación
Para habilitar la paginacion debemos prender el bit mas significativo del registro **CR0**
![[Pasted image 20231110001317.png]]
> **Importante:** El procesador debe estar en modo protegido para activar la paginacion.

### Paginas
El tamano de cada pagina es de 4kbytes. Esto implica que en un sistema de 32 bits con 4gb de ram podemos tener hasta $2^{20}$ paginas ($\frac{2^{32}}{2^{12}}$). 
Las paginas son contiguas y alineadas a 4kbytes. O sea, cuando termina una pagina empieza la siguiente. 
Si las paginas son de 4kbytes y estan alineadas a 4kbyts cuando termina una pagina empieza la siguiente, esto implica que los ultimos 12 bits de TODAS las paginas son 0.

**Direccion Base:**  Bits mas significativos de la direccion de la pagina que necesitamos para especificar su direccion base.
**Limite:**  No hace falta. Sabemos que el limite es Direccion Base + 4kbytes.
**Atributos de Acceso:** Bits para determinar permisos y derechos de acceso.

### Niveles
Para no tener que ocupar la memoria con $2^{20}$ paginas (4mb). Usamos un sistema de niveles.

1. *Directorio de Tablas de Paginas: Pagina de 4kbyte. 1024 Descriptores de pagina de 32 bits. Estos descriptores son enrealidad descriptores de tabla*
2. *Tabla de Paginas: 1024 Descriptores de pagina de 32 bits*

> Los primeros 20 bits del CR3 son la **direccion fisica** del Directorio.
> Los primeros 20 bits de cada descriptor de tabla son la **direccion fisica** de la tabla.
> **En paginacion solo necesitamos 20 bits para encontrar una direccion porque todo esta alineado a 4kbytes entonces los ultimos 12 bits de los 32bits son siempre 0**


![[Pasted image 20231110160553.png]]
**Pasos:**
1. Buscar la direccion de la Page Directory de CR3. 
2. Sumarle el offset (primeros 10 bits de Linear address) para encontrar el descriptor de pagina. 
3. Buscar la direccion de la tabla en los primeros 20 bits del descriptor de pagina.
4. Sumarle el offset (segundos 10 bits de Linear adress) para encontrar el descriptor de pagina en la tabla.
5. Buscar la direccion de la pagina en los primeros 20 bits del descriptor de pagina.
6. Sumarle el offset (ultimos 12 bits de linear address) para encontrar la instruccion o dato en la pagina.



**Directorio de Tablas de Paginas:** 
- Es una pagina que solo tiene descriptores de tabla de pagina. Cada descriptor ocupa 32 bits. 4 bytes.
- Si cada descriptor ocupa 4 bytes y cada pagina tiene disponible 4kbytes entonces tenemos **1024** descriptores de tabla de pagina. (4096/4).
- Cada entrada describe una de las 1024 entradas.

**Tablas de Paginas:** 
- Contiene 1024 descriptores de pagina.

-  ![[Pasted image 20231110010509.png]]
Cada tarea tiene su propia estructura de paginas.

### Inicializacion
El metodo permite iniciar una tarea con solo 2 tablas de paginacion.
1. Pagina de 4kbytes para el directorio de tablas de pagina. (**DTP**). En principio solo tendra 1 descriptor de pagina. El siguiente.
2. Pagina de 4kbytes para una tabla de paginas. (**PT**). Puede almacenar hasta 1024 descriptores de paginas.

$\implies$ Solo iniciando 2 tablas de 4kbytes podemos administrar hasta 1024 paginas de 4kbytes c/u. 4Mbytes!

### Direccionamiento
El procesador necesita la direccion fisica en donde se inicia la estructura de Descriptores de Paginas.
**CR3** contiene la direccion del directorio.
- ![[Pasted image 20231110012910.png]]
- ![[Pasted image 20231110012850.png]]
### Translation Lookaside Buffer (TLB)
Consiste en tener un cache donde se guardan las direcciones fisicas y lo unico es variable es la posicion de la instruccion. Sigue la filosofia de vecindad. Si yo agarro una instruccion de una pagina es altamente probable que agarre una en la misma pagina.

![[Pasted image 20231110013133.png]]
### Esctructura
![[Pasted image 20231110013456.png]]
Bits 31-12 representan la direccion de la DPT. Como sabemos las paginas estan alineadas a 4kbytes por lo que los ultimos 12 bits siempre son 0. Por lo tanto no nos importan a la hora de buscar una DPT. Intel aprovecho esto para usar esos 12 bits y poner ciertos atributos.
**PWT** Establece el modo de escritura
**PCD** Establece el tipo de cacheable o no.

##### Estructura de un Descriptor de Tabla
![[Pasted image 20231110013843.png]]

##### Estructura de un Descriptor de Pagina
![[Pasted image 20231110014135.png]]
	- Hay entre 1 y 1024 de estos descriptores por **Page Table** definida en la **Directory Table**
	- Los 12 bits menos significativos son 0. Porque esta alineada a 4 kbytes.




