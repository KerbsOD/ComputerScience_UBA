#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>

void signal3_handler1(int sig){
	printf("2: Recibí la señal 3, soy el proceso 1\n"); 
	return;
}

void signal3_handler2(int sig){
	printf("2: Recibí la señal 3, soy el proceso 2\n"); 
	return;
}


void hijo1(){
	signal(3, signal3_handler1);
	char create_message[] = "1: Creado, durmiendo 10 segundos...\n";
	write(1, create_message, sizeof(create_message));
	int q = sleep(10);
	printf("1: Termino mi ejecución faltando %d segundos de sueño", q);
	exit(EXIT_SUCCESS);
}

void hijo2(){
	signal(3, signal3_handler2);
	char create_message[] = "1: Creado, durmiendo 10 segundos...\n";
	write(1, create_message, sizeof(create_message));
	int q = sleep(10);
	printf("1: Termino mi ejecución faltando %d segundos de sueño", q);
	exit(EXIT_SUCCESS);
}

int main(int argc, char const *argv[])
{
	pid_t pid_h1;
	pid_t pid_h2;

	pid_h1 = fork();
	if(pid_h1 == 0) hijo1();

	pid_h2 = fork();
	if(pid_h2 == 0) hijo2();

	int numero; 
	scanf("%d", &numero);
	printf("envío la señal número %d al hijo 1\n", numero); 
	kill(pid_h1, numero);
	printf("envío la señal número %d al hijo 2\n", numero); 
	kill(pid_h2, numero);


	exit(EXIT_SUCCESS);
}