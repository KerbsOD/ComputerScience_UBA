# Servicio mediante int 100. Recibe (uint32_t virt, uint32_t phy, uint16_t task_sel). El servicio fuerza la ejecucion de codigo comenzando en la direccion fisica phy, mapeado en virt. Tanto la tarea actual como la tarea que sera pasada por parametro (indicada por task-sel) deben realizar la ejecucion de la pagina fisica.

- Realizar los mapeos necesarios
- Modificar los campos nececsarios para que la tarea determinada por task_sel, retome su ejecucion en la posicion establecida la proxima vez que conmute a ella.
- Modificar los campos necesarios par que la tarea actual, retome su ejecucion en la posicion establecida una vez completada la llamada.

1. Agregamos en idt_init():
    IDT_ENTRY3(100)                          // El enunciado pide privilegio de usuario
2. Pasamos los parametros convencion ABI C Linux:
    main:
        mov eax, <virt>
        mov ecx, <phy>
        mov edx, <Task_Sel>
        int 100

3. Estamos en codigo nivel 0 (kernel, handler). Pasamos los parametros a una funcion de c en la interrupcion.

    extern Force_Execute

    _isr100:
        push edx
        push ecx
        push eax
        push esp
        call Force_Execute

        add esp, 16
        iret

    La funcion va a tocar la pila de nivel 0 para que al hacer iret vayamos a la direccion deseada en la pila de nivel 3 reseteada. Le pasamos el esp (nivel 0) a la funcion C para poder calcular los offsets desde un estado conocido.

4. Funcion

    void Force_Execute(uint32_t virt, uint32_t phy, uint16_t task_sel, uint32_t esp0) {
        tss_t* current_task_tss = &tss_tasks[current_task];
        tss_t* other_task_tss   = get_task_tss(task_sel);
        
        uint32_t attrs = MMU_P | MMU_U; // No ponemos MMU_W porque el codigo no puede escribirse.

        mmu_map_page(current_task_tss->cr3, virt, phy, attrs);
        mmu_map_page(other_task_tss->cr3, virt, phy, attrs);

        other_task_tss->cs   = GDT_CODE_3_SEL;
        other_task_tss->ds   = GDT_DATA_3_SEL;
        other_task_tss->eip  = virt;                        // Comenzara desde el instruction pointer que le designamos

        // Para calcular el offset, recordar que en el handler del timer se hace un pushadd
        uint32_t* other_task_esp3 = other_task_tss->esp0+44;
        other_task_tss->esp = (*other_task_esp3 & 0xFFFFF000) + 0x1000;
        other_task_tss->esp0 = (*other_task_tss->esp0 & 0xFFFFF000) + 0x1000;
        
        // ALternativamente:
            - other_task_tss->esp  = TASK_STACK_BASE + 0x1000;
            - other_task_tss->esp0 = KERNEL_STACK_BASE + 0x1000; 

        // 0X1000 porque hay una pagina por stack

        uint32_t* eip3 = esp0+16; // Obtenemos la DIRECCION del instruction pointer de la tarea cuando fue interrumpida del stack0.
        uint32_t* esp3 = esp0+28; // Obtenemos la DIRECCION del stack pointer de la tarea cuando fue interrumpida del stack0.

        *eip3 = virt;
        *esp3 = TASK_STACK_BASE; // (*esp3 & 0xFFFFF000) + 0x1000
    }


    tss_t* get_task_tss(uint16_t task_sel) {
        uint32_t tss_index = task_sel >> 3;
        uint32_t tss_addr  = (gdt[tss_index].base_31_24 << 24) | (gdt[tss_index].base_23_16 << 16) | (gdt[tss_index].base_15_0);

        return tss_addr;
    }