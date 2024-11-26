//
// Created by octo on 8/29/24.
//

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

enum{READ, WRITE};

int calcular(int numero)
{
    sleep(5);
    return (numero * 8312) % 67;
}

int dameNumero(pid_t pid)
{
    return pid % 47;
}

void informarResultado(int numero, int resultado)
{
    printf("El numero es: %d\n", numero);
    printf("El resultado es: %d\n", resultado);
}

void grandSonRoutine(int numero, pid_t parentpid, int pipes[][2], int index)
{
    int cuenta = calcular(numero);
    write(pipes[index][WRITE], &cuenta, sizeof(cuenta));
    kill(parentpid, SIGUSR1);
    exit(EXIT_SUCCESS);
}

void ejecutarHijo (int i, int pipes[][2]) {
    pid_t current_pid = getpid();
    int numero;
    read(pipes[i][READ], &numero, sizeof(numero));

    signal(SIGUSR1, NULL);
    sleep(1);

    pid_t pid = fork();
    if (pid == 0)
    {
        grandSonRoutine(numero, current_pid, pipes, i);
    }

    pause();
    int resultado;
    read(pipes[i][READ], &resultado, sizeof(resultado));
    informarResultado(numero, resultado);
    exit(EXIT_SUCCESS);
}
int main(int argc, char* argv[]){
    if (argc< 2) {
        printf ("Debe ejecutar con la cantidad de hijos como parametro\n");
        return 0; }
    int N = atoi(argv[1]);
    int pipes[N*2][2];
    for ( int i=0; i< N*2; i++){
        pipe(pipes[i]); }
    for (int i=0; i< N; i++) {
        int pid = fork () ;
        if (pid==0) {
            ejecutarHijo(i,pipes);
            return 0;
        } else {
            int numero = dameNumero(pid) ;
            write(pipes[i][WRITE], &numero, sizeof(numero)); } }
    int cantidadTerminados = 0;
    char hijoTermino [N];
    while (cantidadTerminados < N) {
        for ( int i=0; i< N; i++) {
            if (hijoTermino[i]) {
                continue; }
            char termino = 0;
            write(pipes[i][WRITE], &termino, sizeof(termino));
            read(pipes[N+i][READ], &termino, sizeof(termino));
            if (termino) {
                int numero;
                int resultado ;
                read(pipes[N+i][READ], &numero, sizeof(numero));
                read(pipes[N+i][READ], &resultado, sizeof(resultado));
                informarResultado(numero, resultado);
                hijoTermino[i] = 1;
                cantidadTerminados++; } } }
    wait(NULL) ;
    return 0;
}