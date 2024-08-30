#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>

void ping()
{
    printf("Ping\n");
    fflush(stdout);
}

void pong()
{
    printf("Pong\n");
    fflush(stdout);
}

void childRoutine1()
{
    signal(SIGUSR1, ping);
    while (1)
    {
        pause(); // Wait for signal
    }
}

void childRoutine2()
{
    signal(SIGUSR2, pong);
    while (1)
    {
        pause(); // Wait for signal
    }
}

int main(int argc, char const *argv[])
{
    pid_t childs[2];

    childs[0] = fork();
    if (childs[0] == 0)
    {
        childRoutine1();
    }

    childs[1] = fork();
    if (childs[1] == 0)
    {
        childRoutine2();
    }

    sleep(1); // Sin esto tal vez la senal nunca se registra

    int loops = 0;
    char answer = 0;

    while (loops < 3)
    {
        loops++;
        kill(childs[0], SIGUSR1); // Send SIGTERM to children
        sleep(1);
        kill(childs[1], SIGUSR2); // Send SIGTERM to children
        sleep(1);

        if (loops == 3)
        {
            printf("Quiere finalizar la ejecucion? y/n: ");
            answer = tolower(getchar());
            while (getchar() != '\n');
            if (answer == 'n')
            {
                loops = 0;
            }
        }
    }

    for (int i = 0; i < 2; i++)
    {
        kill(childs[i], SIGKILL);
        waitpid(childs[i], NULL, 0);
    }

    exit(EXIT_SUCCESS);
}
