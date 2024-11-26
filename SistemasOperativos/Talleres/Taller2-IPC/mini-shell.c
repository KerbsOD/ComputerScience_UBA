#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>
#include "mini-shell-parser.c"

typedef char*** matrix;

/*!=
	Explicacion del argumento progs:

	Corresponde con una matriz donde cada fila representa el iesimo programa pasado
	dividido por el pipe. En cada fila esta el nombre del programa 
	en su primera posicion y los parametros en las posiciones restantes.

	Ejemplo: 'du -h /home | head -n 10 | sort -rh'
	
	Representacion:
	[
		['du', '-h', '/home'],
		['head', '-n', '10'],
		['sort', '-rh']
	]

*/
enum {READ, WRITE};
/*
void ejecutar_cmd(const char* cmd, char *arg[])
{
	execvp(cmd, arg);
}

int hijoUnico(char **programa)
{
	ejecutar_cmd(programa[0], programa);
	exit(EXIT_FAILURE);
}

int primerHijo (char **programa, int pipes_fd[][2], int count)
{
	printf("Primer Hijo: %d\n", getpid());

	for (int i = 1; i < count - 1; ++i)
	{
		close(pipes_fd[i][WRITE]);
		close(pipes_fd[i][READ]);
	}

	close(pipes_fd[0][READ]);

	dup2(pipes_fd[0][WRITE], STDOUT_FILENO);

	ejecutar_cmd(programa[0], programa);
	exit(EXIT_FAILURE);
}

int ultimoHijo (char **programa, int pipes_fd[][2], int count)
{
	printf("Ultimo Hijo: %d\n", getpid());

	for (int i = 0; i < count - 2; ++i)
	{
		close(pipes_fd[i][WRITE]);
		close(pipes_fd[i][READ]);
	}
	close(pipes_fd[count - 1][WRITE]);
	dup2(pipes_fd[count - 1][READ], STDIN_FILENO);


	ejecutar_cmd(programa[0], programa);
	exit(EXIT_FAILURE);
}

int hijoMedio (char **programa, int pipes_fd[][2], int count, int numeroHijo)
{
	printf("Hijo %d: %d", numeroHijo, getpid());

	for (int i = 0; i < numeroHijo - 1; ++i)
	{
		close(pipes_fd[i][WRITE]);
		close(pipes_fd[i][READ]);
	}

	for (int i = numeroHijo + 1; i < count; ++i)
	{
		close(pipes_fd[i][WRITE]);
		close(pipes_fd[i][READ]);
	}

	//pipes desde hermano mayor
	close(pipes_fd[numeroHijo - 1][WRITE]);
	dup2(pipes_fd[numeroHijo - 1][READ], STDIN_FILENO);
	//pipes al hermano menor
	close(pipes_fd[numeroHijo][READ]);
	dup2(pipes_fd[numeroHijo][WRITE], STDOUT_FILENO);

	ejecutar_cmd(programa[0], programa);
	exit(EXIT_FAILURE);
}
*/

int hijo(char **programa, int pipes_fd[][2], int count, int numeroHijo)
{
	int nPipes = count - 1;
	int anterior = numeroHijo -1;

	//si no es el primero, entonces tiene un pipe anterior del cual conectar la lectura y cerrar escritura
	if (numeroHijo != 0)
	{
		close(pipes_fd[anterior][WRITE]);
		dup2(pipes_fd[anterior][READ], STDIN_FILENO);
	}

	//si no es el ultimo (nPipes = indice del ultimo hijo), entonces tiene un pipe del cual conectar la escritura
	//y cerrar lectura
	if (numeroHijo != nPipes)
	{
		close(pipes_fd[numeroHijo][READ]);
		dup2(pipes_fd[numeroHijo][WRITE], STDOUT_FILENO);
	}

	//cerramos todos los pipes anteriores al pipe anterior
	for (int i = 0; i < anterior; ++i)
	{
		close(pipes_fd[i][WRITE]);
		close(pipes_fd[i][READ]);
	}

	//cerramos todos los pipes posteriores al pipe del actual
	for (int i = numeroHijo + 1; i < nPipes; ++i)
	{
		close(pipes_fd[i][WRITE]);
		close(pipes_fd[i][READ]);
	}

	/*
	 * cabe destacar que si solo tuvieramos un proceso para correr al primer if no entra, porque es cero; al segundo
	 * tampoco porque nPipes (count -1) tambien es cero; luego en el primer for anterior = -1 por ende no cicla; y por
	 * ultimo el segundo for no corre porque numeroHijo + 1 = 1 > nPipes = 0. Por ende no corremos con el riego de
	 * acceder a memoria que no nos corresponde en pipes_fd
	 */

	//ejecutar_cmd(programa[0], programa);
	execvp(programa[0], programa);

	exit(EXIT_FAILURE);
}

static int run(matrix progs, size_t count)
{
	//Reservo memoria para el arreglo de pids
	//TODO: Guardar el PID de cada proceso hijo creado en children[i]
	pid_t *children = malloc(sizeof(*children) * count);

	//TODO: Pensar cuantos procesos necesito

	//TODO: Pensar cuantos pipes necesito.

	//TODO: Para cada proceso hijo:
			//1. Redireccionar los file descriptors adecuados al proceso
			//2. Ejecutar el programa correspondiente

	int pipes_fd[count-1][2];
	for (int i = 0; i < count - 1; ++i)
		pipe(pipes_fd[i]);

	for (int i = 0; i < count; ++i)
	{
		children[i] = fork();
		if (children[i] < 0)
			exit(EXIT_FAILURE);
		if (children[i] == 0)
		{
			hijo(progs[i], pipes_fd, count, i);
		}
	}

	for (int i = 0; i < count - 1; ++i)
	{
		close(pipes_fd[i][WRITE]);
		close(pipes_fd[i][READ]);
	}

	int status;
	//Espero a los hijos y verifico el estado que terminaron
	for (int i = 0; i < count; i++) {
		waitpid(children[i], &status, 0);

		if (!WIFEXITED(status)) {
			fprintf(stderr, "proceso %d no terminó correctamente [%d]: ",
			    (int)children[i], WIFSIGNALED(status));
			perror("");
			return -1;
		}
	}

	free(children);

	return 0;
}


int main(int argc, char **argv)
{
	if (argc < 2) {
		printf("El programa recibe como parametro de entrada un string con la linea de comandos a ejecutar. \n"); 
		printf("Por ejemplo ./mini-shell 'ls -a | grep anillo'\n");
		return 0;
	}
	int programs_count;
	matrix programs_with_parameters = parse_input(argv, &programs_count);

	printf("status: %d\n", run(programs_with_parameters, programs_count));

	fflush(stdout);
	fflush(stderr);

	return 0;
}
