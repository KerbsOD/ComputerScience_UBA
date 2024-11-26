//
// Created by octo on 8/29/24.
//

A) y B)
```c++
typedef struct {
    int STAT; // valores posibles KE_RUNNING, KE_READY, KE_BLOCKED, KE_NEW
    int P_ID; // process ID
    int PC; // valor del PC del proceso al ser desalojado
    int RO; // valor del registro R0 al ser desalojado
    int R1; // valor del registro R15 al ser desalojado
    int R2; // valor del registro R15 al ser desalojado
    int R3; // valor del registro R15 al ser desalojado
    int R4; // valor del registro R15 al ser desalojado
    int R5; // valor del registro R15 al ser desalojado
    int R6; // valor del registro R15 al ser desalojado
    int R7; // valor del registro R15 al ser desalojado
    int R8; // valor del registro R15 al ser desalojado
    int R9; // valor del registro R15 al ser desalojado
    int R10; // valor del registro R15 al ser desalojado
    int R11; // valor del registro R15 al ser desalojado
    int R12; // valor del registro R15 al ser desalojado
    int R13; // valor del registro R15 al ser desalojado
    int R14; // valor del registro R15 al ser desalojado
    int R15; // valor del registro R15 al ser desalojado
    int CPU_TIME; // tiempo de ejecución del proceso
} PCB;

void Ke_context_switch(PCB* pcb_0, PCB* pcb_1)
{
    pcb_0->STAT = KE_READY; 
    pcb_0->CPU_TIME = ke_current_user_time(); 
    pcb_0->PC = PC; // Guardar el IP
    for (int i = 0; i < 16; i++)    // Guardar los registros
    {
        pcb_0->R[i] = R[i];
    }

    pcb_1->STAT = KE_RUNNING;   
    pcb_1->CPU_TIME = 0;
    for (int i = 0; i < 16; i++)    // Cargar los regustros del nuevo
    {
        R[i] = pcb_1->R[i];
    }

    ke_reset_current_user_time();
    set_current_process(pcb_1->P_ID);
    ret();  // Poner el valor del IP del nuevo
}
```



