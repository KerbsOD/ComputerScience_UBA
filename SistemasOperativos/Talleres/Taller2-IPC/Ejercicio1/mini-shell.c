#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>
#include <string.h>
#include "constants.h"
#include "mini-shell-parser.c"

typedef char*** matrix;

/*
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

void childRoutine(int count, char** argv)
{
	execvp(argv[0],  &argv[0]);
	exit(EXIT_SUCCESS);
}

static int run(matrix progs, size_t count)
{	
	int r, status;
	//Reservo memoria para el arreglo de pids
	//TODO: Guardar el PID de cada proceso hijo creado en children[i]
	pid_t *children = malloc(sizeof(*children) * count);
	for (int i = 0; i < count; i++)
	{
		children[i] = fork();
		if (children[i] == 0)
		{
			childRoutine(progs[i]);
		}
	}

	//TODO: Pensar cuantos procesos necesito
	//TODO: Pensar cuantos pipes necesito.

	//TODO: Para cada proceso hijo:
			//1. Redireccionar los file descriptors adecuados al proceso
			//2. Ejecutar el programa correspondiente

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
	r = 0;
	free(children);

	return r;
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
