//
// Created by octo on 8/29/24.
//

#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

enum {READ, WRITE};

void ejecutar_hijo_1(int pipe[])
{
    close(pipe[READ]);
    dup2(pipe[WRITE], STDOUT_FILENO);
    execlp("ls", "ls", "-al", NULL);
    // Cuando llamamos a esta funcion, "ls" toma control del programa
    // y despues de imprimir la data por el pipe lo cierra, por eso no necesitamos cerrar el pipe de escritura
    // en hijo1 pero si en padre.
    // parece que esto suscede para todos los descriptores de archivos. El sistema operativo los cierra autoamticamente
    // cuando usamos syscalls como exec.
}

void ejecutar_hijo_2(int pipe[])
{
    close(pipe[WRITE]);
    dup2(pipe[READ], STDIN_FILENO);
    execlp("wc", "wc", "-l", NULL);
}

int main(int argc, char const *argv[])
{
    int pipe_fd[2];
    pipe(pipe_fd);

    if (fork() == 0) {
        ejecutar_hijo_1(pipe_fd);
    }

    if (fork() == 0) {
        ejecutar_hijo_2(pipe_fd);
    }

    // El padre cierra el fd de escritura
    // Solo así hijo_2 va a recibir EOF cuando hijo_1 termina
    close(pipe_fd[WRITE]);
    // Cerramos el pipe por el lado de hijo 2 pero como sigue abierto para el padre entonces el sistema considera
    // que todoia se puede escribir por lo que pipe[READ] se queda esperando indefinidamente

    // Esperamos que terminen los hijos antes de terminar el padre
    wait(NULL);
    wait(NULL);

    return 0;
}