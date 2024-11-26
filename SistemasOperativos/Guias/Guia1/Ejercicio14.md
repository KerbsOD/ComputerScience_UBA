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
        bool full = send(pid_derecha, &result);
        if (full == false) {
            result = cómputo_muy_difícil_1();
        }
    }
}
void proceso_derecha() {
    while(1) {
        result = cómputo_muy_difícil_2();
        int left_result;
        bool empty = receive(pid_izquierda, &left_result);
        if (empty == false) {
            printf(" %s %s", left_result, result);
        }
    }
}
```

B) Debe tener capacidad de 0.