## Se nos muestra un árbol de procesos donde cada proceso tiene una serie de page frames asignados. Explicar las siguientes situaciones:
- ¿Por qué todos los procesos de un sistema compartirían una página? (páginas del kernel o bibliotecas compartidas)

Es eficiente que todos los procesos compartan paginas de memoria.

**Paginas de Kernel**: Contiene codigo y estructuras escenciales para el funcionamiento del sistema operativo. Evitamos duplicar el mismo codigo en la memoria de cada proceso. El kernel mapea estas paginas como compartidas en el espacio de direcciones de cada proceso.

**Bibliotecas compartidas**: Las bibliotecas compartidas son fundamentales para evitar la duplicacion de codigo en memoria. Bibliotecas comunes como *libc* son usadas por casi todos los procesos del sistema.
En vez de cargar una copia de la biblioteca para cada proceso, se mantiene una copia en la memoria para que todos la utilicen.

Generalmente, para ambos casos, se mapean como solo lectura. Si un proceso intenta modificarla se genera un page fault y se asigna una copia privada al proceso.

- ¿Por qué dos procesos específicos podrían compartir una página? (hablar de fork y copy-on-write)



##  ¿Para qué sirve la paginación de la memoria? ¿Qué ventajas tiene sobre utilizar direcciones físicas? Hablar sobre el tamaño de las páginas y cómo se relaciona con el tamaño de los bloques en disco. (hablar de fragmentación interna y fragmentación externa)
## ¿Qué es un page fault y cómo se resuelve?
## ¿Por qué puede pasar que tengamos muchos procesos en waiting, y cómo podría tratar de arreglarlo si no pudiese agregar memoria?