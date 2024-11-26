//
// Created by octo on 8/29/24.
//

#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <bits/signum-arch.h>
#include <sys/types.h>
#include <sys/wait.h>

enum { READ, WRITE };
int aPipe[2];
int numero = 0;

void child1Write()
{
    read(aPipe[READ], &numero, sizeof(numero));
    numero = numero + 1;
    write(aPipe[WRITE], &numero, sizeof(numero));
    exit(EXIT_SUCCESS);
}

void child2Write()
{
    read(aPipe[READ], &numero, sizeof(numero));
    numero = numero + 1;
    write(aPipe[WRITE], &numero, sizeof(numero));
    exit(EXIT_SUCCESS);
}

int main(const int argc, const char * argv[])
{

    pipe(aPipe);
    pid_t parentPid = getpid();

    while (numero < 50)
    {
        pid_t childPid_A = fork();
        if (childPid_A == 0)
        {
            signal(SIGUSR1, child1Write);
            while (1)
            {
                pause();
            }
        }

        pid_t childPid_B = fork();
        if (childPid_B == 0)
        {
            signal(SIGUSR2, child1Write);
            while (1)
            {
                pause();
            }
        }

        sleep(1);

        printf("Padre envia a Hijo_1 el valor %d\n", numero);
        write(aPipe[WRITE], &numero, sizeof(numero));
        kill(childPid_A, SIGUSR1);
        waitpid(childPid_A, NULL, 0);

        read(aPipe[READ], &numero, sizeof(numero));
        printf("Hijo_1 envia a Hijo_2 el valor %d\n", numero);
        write(aPipe[WRITE], &numero, sizeof(numero));
        kill(childPid_B, SIGUSR2);
        waitpid(childPid_B, NULL, 0);

        read(aPipe[READ], &numero, sizeof(numero));
        printf("Hijo_2 envia a Padre el valor %d\n", numero);
        numero = numero + 1;
    }
}

// Re hardcodeado pero si la materia no me quiere dar funciones que anden entonces no se que quieren que hagamos.