//
// Created by octo on 8/29/24.
//

```C++
#include <stdio.h>

void computo_muy_dificil_1()
{

}

void computo_muy_dificil_2()
{

}

int result;
void proceso_izquierda() {
    result = 0;
    while (1) {
        bsend(pid_derecha, result);
        result = cómputo_muy_difícil_1();
    }
}
void proceso_derecha() {
    while(1) {
        result = cómputo_muy_difícil_2();
        int left_result = breceive(pid_izquierda);
        printf(" %s %s", left_result, result);
    }
}
```

No se puede porque la primera unidad de computo se bloquea para proceso izquierdo
esperando que proceso derecho termine el computo_muy_dificil_2(). Cuanto este
termina, se recibe el mensaje pid izquierdo, por lo que se desbloquea el bsend del
proceso izquierdo y recien ahi se computa computo_muy_dificil_1(). O sea, los computos
se van a hacer en bloques diferentes en la primera iteracion. No como se quiere
en la tabla.

B) Que el envio y recibimiento de mensajes sea no bloqueante.
