#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <time.h>

enum {READ, WRITE};

int generate_random_number(){
	return (rand() % 50);
}

void cerrarPipes(int pipes_fd[][2], int numeroHijo, int n)
{
	int pipeLectura = numeroHijo - 1;
	if (numeroHijo == 0)
		pipeLectura = n - 1;

	int pipeEscritura = numeroHijo;

	for (int i = 0; i < n + 1; ++i)
	{
		if (i != pipeLectura)
			close(pipes_fd[i][READ]);

		if (i != pipeEscritura)
		close(pipes_fd[i][WRITE]);
	}
}
void cerrarPipesPrimo(int pipes_fd[][2], int numeroHijo, int n)
{
	int pipeLectura = numeroHijo - 1;
	if (numeroHijo == 0)
		pipeLectura = n - 1;

	int pipeEscritura = numeroHijo;

	for (int i = 0; i < n; ++i)
	{
		if (i != pipeLectura)
			close(pipes_fd[i][READ]);

		if (i != pipeEscritura)
			close(pipes_fd[i][WRITE]);
	}

	close(pipes_fd[n][READ]); // cerramos lectura al padre
}

void primogenito (int pipes_fd[][2], int numeroHijo, int buffer, int n)
{
	cerrarPipesPrimo(pipes_fd, numeroHijo, n);
	int numeroMagico = generate_random_number();

	while (numeroMagico <= buffer)
		numeroMagico = generate_random_number();
	printf("Generé: %d\n", numeroMagico);
	while (buffer < numeroMagico)
	{
		//printf("%d\n", buffer);
		++buffer;
		write(pipes_fd[numeroHijo][WRITE], &buffer, sizeof(buffer));

		if (numeroHijo == 0)
			read(pipes_fd[n-1][READ], &buffer, sizeof(buffer));
		else
			read(pipes_fd[numeroHijo - 1][READ], &buffer, sizeof(buffer));
	}
	write(pipes_fd[n][WRITE], &buffer, sizeof(buffer));
	exit(EXIT_SUCCESS);
}

void hijo (int pipes_fd[][2], int numeroHijo, int n)
{
	cerrarPipes(pipes_fd, numeroHijo, n);
	int numeroAnterior;

	while (1)
	{
		if (numeroHijo == 0)
			read(pipes_fd[n-1][READ], &numeroAnterior, sizeof(numeroAnterior));
		else
			read(pipes_fd[numeroHijo - 1][READ], &numeroAnterior, sizeof(numeroAnterior));
		//printf("%d\n", numeroAnterior);
		++numeroAnterior;
		write(pipes_fd[numeroHijo][WRITE], &numeroAnterior, sizeof(numeroAnterior));
	}
}


int main(int argc, char **argv)
{	
	if (argc != 4){ printf("Uso: anillo <n> <c> <s> \n"); exit(0);}

	//Funcion para cargar nueva semilla para el numero aleatorio
	srand(time(NULL));

	int n = atoi(argv[1]);
	int buffer = atoi(argv[2]);
	int start = atoi(argv[3]);

  	/* COMPLETAR */
    printf("Se crearán %i procesos, se enviará el caracter %i desde proceso %i \n", n, buffer, start);

	int pipes_fd[n + 1][2];
	for (int i = 0; i < n + 1; ++i)
		pipe(pipes_fd[i]);

	pid_t hijos[n];
	for (int i = 0; i < n; ++i)
	{
		hijos[i] = fork();
		if (hijos[i] < 0) exit(EXIT_FAILURE);

		if (hijos[i] == 0)
		{
			if (i == start)
				primogenito(pipes_fd, i, buffer, n);
			else
				hijo(pipes_fd, i, n);
		}
	}

	int resultado;
	read(pipes_fd[n][READ], &resultado, sizeof(resultado));

	printf("Puto resultado: %d\n", resultado);

	for (int i = 0; i < n + 1; ++i)
		close(pipes_fd[i][WRITE]);

	for (int i = 0; i < n; ++i)
		if (i != start)
			kill(hijos[i], SIGKILL);

    /* COMPLETAR */
    
}
