# Ejercicio 1

# (A) Definir o modificar las estructuras del sistema necesarias para que dicho servicio pueda ser invocado
Primero debemos configurar la entrada en la IDT. En idt_inti(), funcion que se encuentra en idt.c, insertamos IDT_ENTRY3(100). De este manera las tareas pueden llamar a la interrupcion como lo pide el enunciado.
idt_init() {
    IDT_ENTRY3(100);
}

Suponemos que los parametros son cargados a los registros antes del llamado a la syscall. Sabiendo que los registros se conservan cuando cambiamos de nivel de privilegio.

main:
    mov eax, [virt]
    mov ecx, [phy]
    mov edx, [task_sel]
    int 100

# (B) Implementar el servicio

global _isr100

_isr100:
    push edx            // task_sel
    push ecx            // phy
    push eax            // virt
    call funcion

    mov eax, [esp]                    // EAX = [ESP] = EAX = virt
    mov [esp+12], eax                 // [ESP+12] = EIP = virt
    mov [esp+24], TASK_STACK_BASE     // [ESP+24] = ESP = 0x08003000

    add esp, 12
    iret

// EN el iret se va cambbiar el eip y esp.

| SS     |  ESP + 28
| ESP    |  ESP + 24
| EFLAGS |  ESP + 20
| CS     |  ESP + 16
| EIP    |  ESP + 12
| EDX    |  ESP + 8
| ECX    |  ESP + 4
| EAX    |  ESP 

void funcion(uint32_t* virt, uint32_t* phy, uint16_t task_sel) {
    tss_t* current_tss = &tss_tasks[current_task];
    tss_t* other_tss   = getTSSgivenSelector(task_sel);

    uint32_attrs = (MMU_P | MMU_U); // User y Present. No writabble porque es de codigo.

    mmu_map_page(current_tss->cr3, virt, phy, attrs);
    mmu_map_page(other_tss->cr3, virt, phy, attrs);

    other_tss->eip  = virt;
    other_tss->esp  = TASK_STACK_BASE;
    other_tss->cs   = GDT_CODE_3_SEL;
    other_tss->ds   = GDT_DATA_3_SEL;
    other_tss->esp0 = (other_tss->esp0 & 0xFFFFF000) + 0x1000;
   
    // Obtenemos un puntero al esp3 guardado en la pila de nivel 0.
    // Para calcular el offset, recordar que en el handler del timer se hace un pushad.
    uint32_t* other_task_esp3 = other_task_tss->esp0 + 44; // + 44 bytes
    other_task_tss->esp = (*other_task_esp3 & 0xFFFFF000) + 0x1000;
}

tss_t* getTSSgivenSelector(uint16_t task_sel) {
    uint16_t tss_index = task_sel >> 3;
    paddr_t physicalAdress = (gdt[tss_index].base_31_24 << 24) | (gdt[tss_index].base_23_16 << 16) | (gdt[tss_index].base_15_0);
    return (tss_t*)physicalAddress;
}