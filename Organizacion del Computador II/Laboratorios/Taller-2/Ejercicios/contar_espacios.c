#include "contar_espacios.h"
#include <stdio.h>

uint32_t longitud_de_string(char* string) {
    uint32_t longitud = 0;
    char* iterador = string;

    while (iterador != NULL && *iterador != '\0') {
        longitud++;
        iterador++;
    }

    return longitud;
}

uint32_t contar_espacios(char* string) {
    uint32_t espacios = 0;
    char* iterador = string;

    while (iterador != NULL && *iterador != '\0') {
        if (*iterador == ' ') {
            espacios++;
        }
        iterador++;
    }

    return espacios;
}  


// Pueden probar acá su código (recuerden comentarlo antes de ejecutar los tests!)

// int main() {

//     // printf("1. %d\n", contar_espacios("hola como andas?"));

//     // printf("2. %d\n", contar_espacios("holaaaa orga2"));

//     char vector[3] = {'A', 'B', '\0'};
//     char* ptr = &vector[0];

//     printf("%d", longitud_de_string(ptr));
// }
