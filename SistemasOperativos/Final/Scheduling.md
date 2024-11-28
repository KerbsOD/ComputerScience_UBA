## Describir los objetivos que pueden tener las políticas de scheduling (fairness, carga del sistema, etc.).

**Fairness**: Queremos que cada proceso reciba una dosis justa de CPU.

**Eficiencia**: Maximizar el uso del CPU.

**Throughput**: Maximizar el numero de procesos terminados por unidad de tiempo.

**Carga del sistema**: Minimizar la cantidad de procesos en *Ready*.

**Tiempo de respuesta**: Miinimizar el tiempo de respuesta percibido por los usuarios.

**Latencia**: Minimizar el tiempo requerido para que un proceso de resultado.

**Tiempo de ejecucion**: Minimizar el tiempo *total* que le toma a un proceso ejecutar completamente.

## ¿Qué objetivo prioriza SJF y por qué no se usa en la práctica?

Esta orientado a maximizar el Throughput donde la idea es maximizar el numero de procesos terminaods por unidad de tiempo dandole prioridad a los proceso que tienen un tiempo estimado en terminar menor.

![[Pasted image 20241128184122.png]]
![[Pasted image 20241128184133.png]]
**P1**: Tiene waiting time de 3ms.
**P2**: Tiene waiting time de 16ms.
**P3**: Tiene waiting time de 9ms.
**P4**: Tiene waiting time de 0ms.

Por lo tanto el tiempo de espera promedio es de (3ms + 16ms + 9ms + 0ms) / 4 = 7ms

No se usa en la practica porque no hay manera de predecir cuanta rafaga de cpu va a ser necesitada por un proceso para completarse.

Puede ser con desalojo o voluntario. Si un proceso nuevo llega y necesita menor rafaga que lo restante del procoeso actual entonces si es con desalojo se ejecuta el nuevo y si es voluntario se termina de ejecutar el viejo.

## ¿Cómo funciona el scheduling con múltiples colas?



##  ¿Hay algún problema con que las prioridades fueran fijas?
##  Hablar sobre la afinidad de un procesador. ¿Qué información extra tenemos que tener en la PCB para mantener afinidad en un sistema multicore?
##  Explicar el problema de inversión de prioridades.
