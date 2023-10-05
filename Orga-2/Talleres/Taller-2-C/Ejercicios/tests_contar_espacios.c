#include "contar_espacios.h"
#include <stdio.h>
#include <stdlib.h>

void test_longitud(void) {

    uint32_t len = longitud_de_string(NULL);
    if (len != 0) {
        printf("Fallo en test_longitud NULL\n");
        exit(1);
    }

    len = longitud_de_string("Soy un string");
    if (len != 13) {
        printf("Fallo en test_longitud 2\n");
        exit(1);
    }

    len = longitud_de_string("");
    if (len != 0) {
        printf("Fallo en test_longitud vacío\n");
        exit(1);
    }

    len = longitud_de_string("exactas-uba-/-/-");
    if (len != 16) {
        printf("Fallo en test_longitud 4\n");
        exit(1);
    }

    len = longitud_de_string("un string muy \n muy muy muy \nlargooooooooooooooooooooooooooooooooooooooooooooooooooo");
    if (len != 84) {
        printf("Fallo en test_longitud 5\n");
        exit(1);
    }

}

void test_contar_espacios(void) {

    uint32_t cant_espacios = contar_espacios(NULL);
    if (cant_espacios != 0) {
        printf("Fallo en test_contar_espacios NULL\n");
        exit(1);
    }

    cant_espacios = contar_espacios("orga2 se gu ndo cuatrimestre");
    if (cant_espacios != 4) {
        printf("Fallo en test_contar_espacios 2\n");
        exit(1);
    }

    cant_espacios = contar_espacios("");
    if (cant_espacios != 0) {
        printf("Fallo en test_contar_espacios vacío\n");
        exit(1);
    }

    cant_espacios = contar_espacios("unstringmuylargooooooooooooooooooooooooooooooooooooooooooooooooooo");
    if (cant_espacios != 0) {
        printf("Fallo en test_contar_espacios 4\n");
        exit(1);
    }
}

int main() {

    printf("= Tests de contar_espacios:\n");
	printf("=========================================\n");
    
    test_longitud();

    test_contar_espacios();

	printf("¡Pasaron todos los tests!\n");
    exit(0);
}
