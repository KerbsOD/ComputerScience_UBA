# Ejercicio 1
- Registro ECX reservado en cada tarea.
- El ECX de cada tarea sera actualizado (incrementado) cada vez que la tarea sea ejecutada luego de una interrupcion de reloj.
- Servicio "fuiLlamadaMasVeces". Puede ser llamado por una tarea para preguntar si su ECX es mayor que el de otra tarea.
- En edi nos pasan el ID de la tarea con la que queremos comparar.
- Devuelve el resultado en eax (true o false)

# (A) Describir que entradas estan presentes en la GDT indicando los campos que consideran relevantes 
En la gdt, ademas de los descriptores vistos en el taller, tenemos los descriptores de tss de nuestras tareas. Estas entradas cuentan con la direccion del directorio de paginacion para la tarea. Nivel de privilegio de la tarea, esto nos sirve para definir tareas de nivel de privilegio 0 o nivel de privilegio 3. El bit B que nos sirve para el anidamiento de tareas.
En la gdt vamos a encontrar De 1 a 4 las entradas de los segmentos y datos nivel 0 y 3. 
La entrada correspondiente a la tss de initial task y la entrada correspondiente a la tss de idle.

# (B) Describir  que deben modificar respecto del sistema del taller para que el valor UTC se actualice correctamente en los ecx de cada tarea.
Primero y principal, al iniciar la tss de las tareas debemos inicializar ecx con el valor 0. Luego debemos modificar la interrupcion de reloj para que esta modifique el ecx de la tarea cuando esta vuelve a su ejecucion. Cuando se hace el jmp far se cambia el contexto y el eip de la tarea actual se queda debajo de del jmp. Luego cuanodo se vuelve a la tarea actual, hacemos el call tasks_tick, call tasks_screen_update y popad. Luego del popad incrementamos el ecx. Entonces en la proxima interrupcion de reloj se guardara en pushad el ecx modificado!

global _isr32
sched_task_selector
sched_task_offset

_isr32:
    pushad
    
    call pic_finish1
    call next_clock
    
    call sched_next_task
    cmp ax, 0
    je .fin

    str bx
    cmp ax, bx
    je .fin

    mov word [sched_task_selector], ax
    jmp far [sched_task_offset]

    .fin:
    call tasks_tick
    call tasks_screen_update
    popad

    inc ecx
    iret
