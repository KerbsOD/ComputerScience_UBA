//
// Created by octo on 8/29/24.
//

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char const *argv[]){
    int dato = 0;
    pid_t pid = fork();
    //si no hay error, pid vale 0 para el hijo
    //y el valor del process id del hijo para el padre
    if (pid == -1) exit(EXIT_FAILURE);
    //si es -1, hubo un error
    if (pid == 0) {
        for (int i=0; i< 3; i++) {
            dato++;
            printf("Dato hijo: %d\n", dato);
        }
    }
    else {
        for (int i=0; i< 3; i++) {
            printf("Dato padre: %d\n", dato);
        }
    }
    exit(EXIT_SUCCESS); //cada uno finaliza su proceso
}

/* ¿Son iguales los resultados mostrados de la variable dato para el padre y para el hijo? ¿Qué está
sucediendo?
No son iguales, cada proceso tiene la variable dato en la misma direccion de memoria relativa pero en diferentes partes
del sistema. Se copio la memoria pero no es una referencia.
Hijo: Actualiza SU variable dato y la imprime en pantalla en cada iteracion.
Padre: Imprime su variable hijo 3 veces.
*/