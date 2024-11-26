//
// Created by octo on 8/29/24.
//

#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main()
{
    pid_t pid;
    pid = fork();
    if (pid == 0)
    {
        write(1, "Soy Julieta\n", 12);
        sleep(1);
        pid = fork();
        if (pid == 0)
        {
            write(1, "Soy Jennifer\n", 14);
            sleep(1);
            exit(EXIT_SUCCESS);
        }
        exit(EXIT_SUCCESS);
    }
    write(1, "Soy Juan\n", 10);
    sleep(1);

    wait4(-1, NULL, 0, NULL);

    pid = fork();
    if (pid == 0)
    {
        write(1, "Soy Jorge\n", 10);
        sleep(1);
        exit(EXIT_SUCCESS);
    }

    exit(EXIT_SUCCESS);
}
