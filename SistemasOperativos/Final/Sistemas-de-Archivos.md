## ¿Qué es un file descriptor? Nombrar 3 system calls que los afecten.
## ¿Cuándo se revisan los permisos de acceso sobre un archivo? Explicar por qué el file descriptor se crea cuando hacemos un open y no se vuelven a revisar los permisos.
## ¿Qué es un FS y para qué sirve?
## ¿Cuándo es adecuado reservar espacio en disco de manera secuencial? ¿Qué beneficios nos trae? (CD-ROM, ISO-9660)
## ¿Cuál FS nos conviene utilizar para un sistema embebido: FAT o inodos?
## ¿Cuál FS nos conviene utilizar para implementar UNDO (deshacer la última escritura a disco)? ¿Cómo se implementaría en FAT y en inodos?
## ¿Cuál FS nos conviene utilizar para implementar un backup total? ¿Cómo se implementaría en FAT y en inodos?
## ¿Cuál FS nos conviene utilizar para implementar un backup incremental? ¿Cómo se implementaría en FAT y en inodos?
## ¿Cuál FS nos conviene utilizar para implementar snapshot? (Diferenciar el caso en que queramos tomar una snapshot mientras el sistema está corriendo) ¿Cómo se implementaría en FAT y en inodos?
## Explicar las diferencias entre FAT e inodos. Ventajas y desventajas de cada uno.
## ¿FAT implementa algún tipo de seguridad?
## Explicar qué es journaling.
## Describir ext2.
## ¿Qué mantiene un inodo? ¿Cómo es la estructura de directorios?
## ¿Para qué sirven los block groups y los clusters? Motivación para agrupar páginas en bloques, y bloques en grupos de bloques.
## ¿Cuáles son las estructuras más importantes de ext2? Explicar cada una (en particular, hablar del superbloque).
## Explicar cómo se manejan los bloques libres del disco.
## ¿Qué pasa cuando se inicia el sistema luego de haber sido apagado de forma abrupta? Explicar cómo hace el sistema para darse cuenta de si hubo algún error (cuando no hace journaling) y cómo lo arregla. (inconsistencias entre contadores y bitmaps, entre entradas de inodos y bitmaps, entre entradas de directorios y bitmaps)
## Explicar las diferencias (ventajas y desventajas) entre soft links y hard links. ¿Por qué no podemos usar un hard link para referenciar inodos de otro FS, incluso si está basado en inodos?
## Explicar cómo se crean y borran archivos con las estructuras del FS (incluido cómo se modifica el block group). Explicar el caso de borrado en hard links.
## Explicar qué ocurre cuando se borra un archivo en ext3 (y diferencias con ext2).