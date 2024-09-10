#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

void maggie() {
    printf("Soy Maggie hija de Homero\n");
    exit(EXIT_SUCCESS);
}

void lisa() {
    printf("Soy Lisa hija de Homero\n");
    exit(EXIT_SUCCESS);
}

void bart() {
    printf("Soy Bart hijo de Homero\n");
    exit(EXIT_SUCCESS);
}

void homero() {
    printf("Soy Homero hijo de Abraham\n");
    
    int status;
    
    pid_t pidBart = fork();
    if (pidBart == 0) {
        bart();
    }
    waitpid(pidBart, &status, 0);
    
    pid_t pidLisa = fork();
    if (pidLisa == 0) {
        lisa();
    }
    waitpid(pidLisa, &status, 0);

    pid_t pidMaggie = fork();
    if (pidMaggie == 0) {
        maggie();
    }
    waitpid(pidMaggie, &status, 0);

    exit(EXIT_SUCCESS);
}

void abraham() {
    printf("Soy Abraham\n");
    pid_t pid = fork();
    if (pid == 0) {
        homero();
    }
    exit(EXIT_SUCCESS);
}

int main() {
    abraham();
    return 0;
}