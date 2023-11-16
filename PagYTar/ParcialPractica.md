# (A) Implementar la Syscall exit que al ser llamada por una tarea, inactiva dicha tarea y pone a correr lasiguiente (segun indique el sistema de prioridad utilizado). Mostrar el código.

En isr.asm:

global _isr99
_isr99:
    pushad                             // Pusheamos los registros
    
    call sched_exit_task               // Llamamos a la subrutina para para deshabilitar la tarea. 

    mov word [sched_task_selector], ax // sched_exit me dio en ax la siguiente tarea a ejecutar. La movemos a task_sel
    jmp far [sched_task_offset]        // Saltamos al offset (normalmente 0)

    .fin:
    call tasks_tick                    // Actualizamos las estructuras compartidas ante el tick del reloj
    call tasks_screen_update           // Actualizamos la interfaz
    popad
    iret


En sched.c:
uint16_t shed_exit_task(void) {
    sched_disable_task(current_task)
    return sched_next_task();
}

# (B) ¿Cómo modificarías el punto anterior para que exit (además de lo que hace normalmente) guarde el ID de quién la llamó en el EAX de próxima tarea a ejecutar? Mostrar código.

Pasos de la resolución:
1. Obtener el id de la tarea que llama a la syscall
2. Desactivar la tarea actual
3. Buscar la siguiente tarea a ejecutar
a. Obtener el id
b. Obtener el selector
4. Antes de realizar el cambio de contexto, escribir el id obtenido en el paso 1 en el EAX destino.
Para eso:
a. Obtenemos la TSS de la nueva tarea
b. Buscamos el ESP de la nueva tarea
c. Nos movemos en la pila hasta donde se ubica el EAX (pusheado por pushad antes de
cambiar de contexto)
d. Lo pisamos con el id
5. Seguimos con el cambio de contexto normal

En isr.asm:

extern current_task

global _isr99
_isr99:
    pushad                             // Pusheamos los registros
    
    /* Paso 1 */
   * push dword current_task*          // Pusheamos al stack de nivel 0 el id de la tarea actual

    /* Paso 2 */
    sched_disable_task;                // Deshabilitamos la tarea con el valor pasado al stack

    /* Paso 3.a */ 
    call sched_next_task_id            // En eax tenemos el id de la siguiente tarea
    push eax                           // Pusheamos al stack de nivel 0 el id de la siguiente tarea

    /* Paso 4 */
    call pass_exit_id_to_next_task     // Escribimos el id de la tarea actual en eax de la siguiente tarea
    
    /* Paso 3.b */ 
    call sched_next_task               // Obtenemos el selector de la siguiente tarea

    /* Paso 5 */ 
    mov word [sched_task_selector], ax // sched_exit me dio en ax la siguiente tarea a ejecutar. La movemos a task_sel
    jmp far [sched_task_offset]        // Saltamos al offset (normalmente 0)

    .fin:
    add esp, 8                         // Limpiamos el eax en el stack y el current_task
    call tasks_tick                    // Actualizamos las estructuras compartidas ante el tick del reloj
    call tasks_screen_update           // Actualizamos la interfaz
    popad
    iret


En sched.c:

    uint8_t sched_next_task_id(void) {
        // Buscamos la próxima tarea viva (comenzando en la
        actual)
        int8_t i;
        for (i = (current_task + 1); (i % MAX_TASKS) != current_task; i++) {
            // Si esta tarea está disponible la ejecutamos
            if (sched_tasks[i % MAX_TASKS].state == TASK_RUNNABLE)
                break;
            }
            // Ajustamos i para que esté entre 0 y MAX_TASKS-1
            i = i % MAX_TASKS;
            return i
    }

    void pass_exit_id_to_next_task(uint8_t new_task_id, uint8_t exit_task_id) {
        tss_t new_task_tss = tss_task[new_task_id];
        uint32_t* new_task_esp = (uint32_t*) new_task_tss.esp;
        // como es nivel 0, esta mapeado con identity mapping
        // EAX es el primer registro en pushearse con pushad,
        // por lo tanto le sumo 28 al esp
        *(new_task_esp + 28) = exit_task_id;
        return;
    }

# (C) ¿Y si ahora no es la Syscall exit la que modifica el EAX de nivel 3 de la tarea que va a ser ejecutada luego de la llamada a la Syscall sino la interrupción de reloj? Cómo deberías modificar el código de la interrupción de reloj? Mostrar el código y explicar todo lo que agregues al sistema.

_isr32: ;rutina de atención del reloj
pushad
call pic_finish1
call next_clock
push DWORD [current_task]
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
iret

_isr99: ;syscall exit
pushad
push DWORD [current_task]
call sched_disable_task
call sched_next_task_id
push eax
call pass_exit_id_to_next_task
call sched_next_task
mov word [sched_task_selector], ax
jmp far [sched_task_offset]
.fin:
mov esp, 8
call tasks_tick
call tasks_screen_update
popad
iret

















estas en tarea A
[2:36 PM]
te interrumpe el reloj
[2:36 PM]
guardas los registros importantes en la pila de nivel 0
[2:36 PM]
haces jmp far a una tarea B, y la tarea b continua su ejecucion
[2:37 PM]
eventualmente, tenemos una interrupcion de clock a una tarea N, y el scheduler decide que es turno de la tarea a
[2:37 PM]
A
[2:37 PM]
entonces de vuelta, hacemos un jmp far a la tarea A
[2:37 PM]
y retoma justo despues del jmp far que la hizo saltar a la tarea b
[2:38 PM]
y ahi esta el popad