
CHECKPOINT 1

1. Se pueden definir 2 niveles. User 1. Supervisor 0.
2. 
    - Los primeros 10 bits indican a que tabla entrar en el directorio de tablas. Los siguientes 10 bits    indican a que pagina de la tabla entrar, los ultimos 12 bits indican la direccion del dato o instruccion. 
    - La direccion logica me ayuda a encontrar directorio->tabla->direccion. En el registro de control se pone la direccion donde comienza el directorio y que propiedades tiene. Si esta desea Page-Write-Through y/o Page-Level Cache Disable.

3. 
    - D: indica si la pagina fue modificada. Cuando hacemos swap de la ram al disco. Se analiza si la pagina fue modificada. Si esta pagina no fue modificada entonces no la guardamos en el disco. (Supongo que se asume que ya estaba en el disco(?))
    - A: Indica si la pagina fue o no accedida. El sistema operativo lo usa para la politica LRU (least recently used)
    - PCD: Bit que indica si es cacheable.
    - PWT: Modo de escritura en el cache.
    - U/S: Privilegio de la pagina.
    - R/W: 0 si no es escribible. 1 si si.
    - P: Pagina presente en la memoria.

4. En ambos casos donde el privilegio del directorio es Supervisor y la tabla usuario o Directorio usuario y la tabla supervisor entonces queda a decision de la flag WP de CR0 (Write protect). Si esta en 1 entonces protege a las paginas read-only de los privilegios de supervisor. 
Por lo tanto: 
- Si WP = 1 y y R/W = 1 entonces se puede escribir.
- Si WP = 1 y y R/W = 0 entonces no se puede escribir.
- Si WP = 0 y y R/W = 1 entonces se puede escribir.
- Si WP = 0 y y R/W = 0 entonces si el privilegio es de Supervisor, se puede escribir, caso contrario no.

5. Una pagina para el directorio. 3 paginas a la tabla.
7. Es un tipo de cache para las paginas. Porque podria llevarnos a cualquier pagina. Posee el directorio y la tabla. bits de control. No se ve afectada.

CHECKPOINT 2

1. 
