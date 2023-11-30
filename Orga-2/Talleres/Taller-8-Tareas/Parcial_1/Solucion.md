# Ejercicio 1

# (A) Implementar la Syscall exit que al ser llamada por una tarea, inactiva dicha tarea y pone a correr la siguiente (segun indique el sistema de prioridad utilizado). Mostrar el código.

Vamos a usar el codigo 64 para esta syscall (porque si). Esta debe:
- Obtener el id de la tarea actual.
- Deshabilitarla con el codigo en sched_disable_task(uint8_t task_id).
- Correr la siguiente tarea.

Primero deberiamos modificar la estructura idt_init() para que inicialice la interrupcion.
void idt_init() {
    IDT_ENTRY3(64);
}

-> Usamos el nivel de privilegio 3 porque queremos que la syscall pueda ser llamada desde tareas.

global _isr64
extern current_task
sched_task_offset:     dd 0
sched_task_selector:   dw 0

_isr64:
    pushad                              // Pusheamos los registros al stack. 
    
    push DWORD [current_task]           // Puseheamos el id actual al stack.
    call sched_disable_task             // Deshabilitamos la tarea con el id pasado por parametro.
    call shed_next_task                 // Obtenemos el selector de la siguiente tarea disponible en eax.
    
    mov [sched_task_selector], ax       // Movemos el valor del selector a la variable sched_task_selector (los selectores ocupan 16 bits, por eso ax)
    jmp far [sched_task_offset]         // Hacemos el cambio de contexto
    
    add esp, 4                          // Limpiamos lo que pusheado al stack.
    popad                               // Popeamos los registros una vez que se vuelva a esta tarea!
    iret                                // Volvemos de la interrupcion.



# (B) ¿Cómo modificarías el punto anterior para que exit (además de lo que hace normalmente) guarde el ID de quién la llamó en el EAX de próxima tarea a ejecutar? Mostrar código.

Podriamos escribir el valor de current task en el eax del pushad que hace la proxima tarea cuando hay una interrupcion de reloj. Asumiendo que la tarea ya fue desalojada.

1. Obtener id actual.
2. Desactivar la tarea actual.
3. Buscar la siguiente tarea.
   1. Obtener el id de la siguiente tarea.
   2. Obtener el selector de la siguiente tarea.
4. Escribir el id obtenido en el paso 1 en el EAX destino
    1. Obtenemos TSS de la nueva tarea
    2. Buscamos el ESP de la nueva tarea
    3. Buscamos EAX en pila (por pushad)
    4. Lo pisamos con el id
5. Seguimos con el cambio de contexto normal

global _isr64
extern current_task
sched_task_offset:     dd 0
sched_task_selector:   dw 0

_isr64:
    pushad                             
    
    /* Paso 1 */ 
    push DWORD [current_task]           // Obtenemos el id de la tarea actual.
    
    /* Paso 2 */
    call sched_disable_task             // Deshabilitamos la tarea con el id pasado por parametro.
    
    /* Paso 3.1 */ 
    call shed_next_task_id              // Obtenemos el id de la siguiente tarea. Se guarda en eax.
    push eax

    /* Paso 4 */ 
    call pass_exit_id_to_next_task      // Ponemos el id de la tarea actual en la nueva. En el stack esta el id actual y el de la siguiente tarea.

    /* Paso 3.2 */                      
    call sched_next_task                // Obtenemos el selector de la siguiente tarea. Se guarda en eax.

    /* Paso 5 */     
    mov [sched_task_selector], ax       // Movemos el valor del selector a la variable sched_task_selector (los selectores ocupan 16 bits, por eso ax)
    jmp far [sched_task_offset]         // Hacemos el cambio de contexto
    
    .fin:
    add esp, 8                          // Limpiamos lo que pusheamos al stack.
    popad                               // Popeamos los registros una vez que se vuelva a esta tarea!
    iret                                // Volvemos de la interrupcion.


uint8_t sched_next_task_id() {
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

uint16_t sched_next_task(uint8_t task_id){
    // Si la tarea que encontramos es ejecutable entonces vamos a correrla.
    if (sched_tasks[i].state == TASK_RUNNABLE){
        current_task = i;
        return sched_tasks[i].selector;
    }
    
    // En el peor de los casos no hay ninguna
    tarea viva. Usemos la idle como selector.
    return GDT_IDX_TASK_IDLE << 3;
}

void pass_exit_id_to_next_task(uint8_t exit_task_id, uint8_t new_task_id) {
    tss_t new_task_tss = tss_tasks[new_task_id];
    
    uint32_t* new_task_esp = (uint32_t*) new_task_tss.esp;
    
    // como es nivel 0, esta mapeado con identity mapping EAX es el primer registro en pushearse con pushad, por lo tanto le sumo 28 al esp
    
    *(new_task_esp + 28) = exit_task_id;
    return;
}

Pushad: 

| eax | esp + 32
| ecx | esp + 28
| edx | esp + 24
| ebx | esp + 20
| esp | esp + 16
| ebp | esp + 8
| esi | esp + 4
| edi | <- esp despues del pushad



# (C) ¿Y si ahora no es la Syscall exit la que modifica el EAX de nivel 3 de la tarea que va a ser ejecutada luego de la llamada a la Syscall sino la interrupción de reloj? Cómo deberías modificar el código de la interrupción de reloj? Mostrar el código y explicar todo lo que agregues al sistema.

Como no especifica que hay que deshabilitarla simplemente agregamos la llamada a la funcion "call pass_exit_id_to_next_task" 

_isr32: ;rutina de atención del reloj
    pushad
    call pic_finish1
    call next_clock
    
    push DWORD [current_task]
    call shed_next_task_id
    push eax
    call pass_exit_id_to_next_task
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

# Ejercicio 2

# (A) ¿Qué excepción ocurre cuándo un procesador x86 intenta ejecutar una instrucción no soportada?
Ocurre una #UD (excepcion 6). Invalid Opcode Exception.

# (B) Realice un diagrama de pila que muestre el estado de la pila del kernel luego de que una aplicación de usuario intentó ejecutar RSTLOOP.
Como es una tarea la que intento ejecutar el opcode y esto genero una excepcion entonces la pila del kernel se vera de la siguiente manera.

| SS     | esp + 16
| ESP    | esp + 12 
| EFLAGS | esp + 8
| CS     | esp + 4
| EIP    | <- ESP
 
(esta excepcion no deja error code)

# (C) ¿Qué dirección de retorno se encuentra en la pila al atender la excepción?
Se encuentra el CS:EIP. La direccion donde se genero la excepcion.

# (D) Describa una posible implementación de RSTLOOP utilizando el mecanismo descrito en (a) y (b).
   - El mecanismo propuesto sólo debe actuar cuándo la instrucción no soportada es RSTLOOP.
   - Si la instrucción que generó la excepción no es RSTLOOP la tarea debe ser deshabilitada y la ejecución debe saltar a la tarea idle.
   - Si la instrucción que generó la excepción es RSTLOOP adecúe la dirección de retorno de manera que permita a la tarea continuar la ejecución sin problemas.

1. Accedemos a la pila y guardamos en eax el eip. eax = [esp] = eip.
2. En eax guardamos el opcode guardado en eip. eax = [eax] = [eip] = opcode.
3. Comparamos el opcode con 0x0F0B
   1. Si son iguales entonces pongo ecx en 0 y le sumo 2 al eip en la pila. De esta manera salta a la siguiente instruccion. 0x0F0B = 2 bytes.
   2. Si no son iguales entonces:
      1. Obtenemos el id de la tarea actual.
      2. Deshabbilitamos la tarea actual.
      3. Saltamos a la tarea idle.

# (E) ¿Qué ocurriría si no se adecuara la dirección de retorno luego de simular RSTLOOP?
Se trataria de ejecutar el opcode, iria a la excepcion 6 y la tarea actual se quedaria loopeando siempre aca.

# (F) Detalle los cambios a las estructuras del sistema visto en el taller que haría para realizar la implementación descrita en (d).
Solo modificamos 

# (G) Muestre código para la rutina de atención de interrupciones descrita en (d) y todo otro cambio de comportamiento que haya visto necesario.

global _isr6
extern current_task
extern sched_disable_task

_isr6:
    mov eax, [esp]      // eax = eip
    mov ax, [eax]       // ax  = [eip]

    cmp ax, 0x0F0B      // Comparamos el opcode de la excepcion con 0x0F0B
    je .isRSTLOOP       // Saltamos 

    push DWORD [current_task]
    call sched_disable_task

    add esp, 4
    jmp (12<<3):0

    .isRSTLOOP:
    mov ecx, 0
    add DWORD [esp], 2
    iret