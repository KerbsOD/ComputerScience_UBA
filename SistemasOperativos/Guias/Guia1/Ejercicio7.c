//
// Created by octo on 8/29/24.
//

#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

void child(char *argv[])
{
    execvp(argv[1],  &argv[1]);
    exit(EXIT_SUCCESS);
}

int main(int argc, char* argv[])
{
    pid_t pid;
    pid = fork();
    if (pid == 0)
    {
        child(argv);
    }

    waitpid(pid, NULL, 0);
    exit(EXIT_SUCCESS);
}