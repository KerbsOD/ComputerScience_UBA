//
// Created by octo on 8/20/24.
//

#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <sys/wait.h>

int N, J, K;
pid_t children[10];

void lanzarNumero()
{
    srand(time(NULL));
    const int numero = rand()%(N);
    if (numero == J)
    {
        printf("Que lastima pero adios! (PID: %d) \n", getpid());
        exit(EXIT_SUCCESS);
    }
}

void childrenRoutine()
{
    signal(SIGTERM, lanzarNumero);
    while(1)
    {
        pause();
    }
}

void initializeChildren()
{
    for (int i = 0; i < N; i++)
    {
        children[i] = fork();
        if (children[i] == 0)
        {
            childrenRoutine();
        }
        printf("Created child %d with pid %d \n", i, children[i]);
    }
}

void cleanFromChildren()
{
    const pid_t childPid = wait(NULL);
    for (int i = 0; i < N; i++) {
        if (children[i] == childPid) {
            printf("Eliminated child %d with pid %d \n", i, children[i]);
            children[i] = 0;
        }
    }
}

void sendSignalToEachChild(const int aSignal)
{
    for (int i = 0; i < N; i++)
    {
        if (children[i] != 0)
        {

            printf("Sending signal to child %d with pid %d \n", i, children[i]);
            kill(children[i], aSignal);
            sleep(1);
        }
    }
}

void notificarGanadores()
{
    printf("Ganadores: \n");
    for (int i = 0; i < N; i++)
    {
        if (children[i] != 0)
        {
            printf("Index: %d, PID: %d \n", i, children[i]);
            kill(children[i], SIGKILL);
        }
    }
}

int main(const int argc, const char *argv[])
{
    N = atoi(argv[1]);
    J = atoi(argv[2]);
    K = atoi(argv[3]);

    initializeChildren();

    signal(SIGCHLD, cleanFromChildren);
    for (int i = 0; i < K; i++)
    {
        sendSignalToEachChild(SIGTERM);
    }

    notificarGanadores();
    exit(EXIT_SUCCESS);
}
