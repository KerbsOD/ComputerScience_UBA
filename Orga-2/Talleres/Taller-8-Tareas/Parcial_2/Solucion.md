# Ejercicio 1

# Consigna
- 5 tareas en ejecucion de nivel usuario.
- 6ta tarea de nivel kernel.
- Cualquiera de las 5 tareas puede realizar una cuenta y enviar el resultado a la 6ta tarea para que lo utilice de manera INMEDIATA.
- La tarea que realice la cuenta guardara el resultado en su EAX.
- La tarea que realice la cuenta le cedera tiempo de ejecucion que le queda a la tarea que va a procesar el resultado. (la 6ta recibira el resultado en eax)
- La tarea que hizo la cuenta NO VOLVERA A SER EJECUTADA hasta que la 6ta no haya terminado de utilizar el resultado de la operacion realizada.
- Queremos syscall

# (A) Definir o modificar las estructuras del sistema necesarias para que dicho servicio pueda ser invocado.
En tss.c deberiamos crear una funcion tss_create_user_task similar a la ya definida pero para tareas de nivel 0. Pues necesitamos que tenga cs = GDT_CODE_0_SEL y ds = GDT_DATA_0_SEL. Tambien necesitamos que una funcion en mmu.c similar a mmu_init_task_dir pero para inicializar la estructura de paginacion para tareas de nivel 0. Asumiendo que creamos todas esta funciones parecidas a las originales pero para la 6ta tarea de nivel 0.
Supongamos que nuestra syscall es tiene el numero 64. En idt_init() debemos agregar IDT_ENTRY3(64). Asi la syscall puede ser llamada por tareas de nivel usuario.

# (B) Implementar la syscall que llamaran las tareas
Primero vamos por pasos, cual es el proceso.
1. Como los registros se conservan al cambiar de nivel de privilegio, guardamos en el stack el resultado.
2. Llamamos a la rutina que habilita la tarea 6, deshabilita la actual y procesa todo.
3. Limpiamos el stack del resultado pusheado.
4. Saltamos a la tarea 6
5. Limpiamos el stack del popad
6. return


global _isr64
extern current_task
extern habilitar_tarea_6
extern tarea6_ID
extern sched_next_task
extern tarea_Desalojada                 // Cuando terminemos de procesar tarea6, esta nos ayudara a recuperar la que se desalojo.

sched_task_offset:     dd 0
sched_task_selector:   dw 0

_isr64:
    pushad
    
    push eax
    call habilitar_tarea_6
    add esp, 4                          // Limpiamos el stack del eax
    
    push [tarea6_ID]                    // Obtenemos el ID de la tarea 6
    call sched_next_task                // Llamamos a sched_next_task pero la modificada, abajo esta el codigo. Esta recibe un id y devuelve el sel.

    mov word [sched_task_selector], ax  // Cargamos el selector en sched_task_selector
    jmp far [task_6_offset]             // Saltamos a la tarea

    popad
    iret

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

void habilitar_tarea_6(uint32_t resultado) {
    sched_disable_task(current_task);
    sched_enable_task(tarea6_ID);

    tss_t* task6_tss = tss_tasks[tarea6_ID];
    
    task6_tss->eax = resultado;

    tarea_desalojada = current_task;
}

Consideraciones
- tarea_desalojada es una variable globbal que tenemos para saber que tarea fue la desalojada al llamar la syscall, nos ayuda a volver a habilitar la tarea que fue inhabilitada cuando se hizo la syscall.
- tarea6_ID es una variabble global que nos ayuda a acceder a la tss en tss_tasks.
- sched_next_task nos da el selector para el jmp far

# (C) Dar el pseudo-codigo de la tarea que procesa resultados
// Una vez procesado el dato debemos deshabilitarla y seguir con la siguiente tarea.
Tarea 6 {
    while (true) {
        variables bla bla
        procesa el dato

        sched_enable_task(tarea_desalojada);
        sched_disable_task(tarea6_ID);
        cambiar_tarea();
    }
}

global cambiar_tarea
sched_task_offset:     dd 0
sched_task_selector:   dw 0

cambiar_tarea:
    pushad
    call sched_next_task

    mov word [sched_task_selector], ax
    jmp far [sched_task_offset]

    popad
    ret

Una vez que se hace el jmp far, el contexto de tarea6 se queda en esta funcion. Luego si es llamada por otra tarea B el contexto comenzara por aca
hacienod el popad, ret y empezando el loop nuevamente. Por eso el loop es muy importante.
La tarea PUEDE USAR EL SCHEDULER PORQUE TIENE PRIVILEGIO 0.

# (D) Mostrar un pseudo-codigo de la funcion sched-next_task para que funcione de acuerdo a las necesidades de este sistema. Responder Que problemas podrian surgir dadas las modificaciones al sistema? Como lo solucionarias?

Como no fue necesario implementar la finalizacion de tareas, no hay nada que cambiar en sched_next_task
Supongamos que una tarea A llama a la syscall. Luego si otra tarea llama a la syscall tendriamos un conflicto porque despues de atender a la tarea b se pierde para siempre el id de A.


# Ejercicio 2
- Tenemos el cr3 de la tarea
- Direccion fisica de la pagina a desalojar
- Decidir si la pagina debe ser escrita a disco o no

1. Acceder a la pagina comparando, para todas las paginas virtuales del cr3, si su bit D esta activado y si la direccion physica es la misma.

uint8_t Escribir_a_Disco(int32_t cr3, paddr_t phy) {
    pd_entry_t* PageDirectory = CR3_TO_PAGE_DIR(cr3);
    uint8_t res = 0; // False

    for (int i = 0; i < 1024; i++) {
        pt_entry_t* PageTable = (pt_entry_t*)PageDirectory[i];

        if (((PageTable->attrs) & MMU_P) == 1) {
            res |= chequeo_pt(PageTable, phy);
        }
    }

    return res;
}

uint8_t chequeo_pt(pt_entry_t* PageTable, paddr_t phy) {
    uint8_t res = 0;

    for (int i = 0; i < 1024; i++) {
        if (((PageTable[i]->attrs) && MMU_P) == 1) {
            if (((PageTable[i]->page) << 12) == (phy & 0xFFFFF000)) {
                if ((PageTable[i]->attrs & MMU_D) == 1) {
                    res = 1;
                }
            }
        }
    }

    return res;
}

- Dado el cr3 podemos:
    1. Obtener la direccion fisica del page directory. CR3 & 0xFFFFF000
    2. Iterar sobre las tablas. Si la tabla esta presente. Chequeamos sus paginas.
    3. En PageTable tenemos attrs y page. Para cada pagina en la page table. Si:
       1. La pagina esta presente (PageTable[i]->attrs & MMU_P == 1)
       2. La direccion fisica de la pagina es igual a la direccion que queremos (recordar que en la estructura de pt_entry_t 31-20 son attrs y del 19-0 son la direccion fisica). Tenemos que desplazarla a los 20 mas significativos. PageTable[i]->page << 12.
       3. Tiene el bit Dirty activado 

Entonces es la que buscamos.