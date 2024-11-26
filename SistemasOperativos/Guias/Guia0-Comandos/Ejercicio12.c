//
// Created by octo on 8/19/24.
//

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "Ejercicio11.c"

typedef struct {
    char nombre[20];
    int edad;
    char cuit[12];
} Usuario;

void agregarInformacionUsuario(Usuario **usuario) {
    Usuario *nuevoUsuario = (Usuario*)malloc(sizeof(Usuario));

    printf("Ingrese nombre de persona: \n");
    scanf("%s", nuevoUsuario->nombre);

    printf("Ingrese edad: \n");
    scanf("%d", &nuevoUsuario->edad);

    printf("Ingrese cuit: \n");
    scanf("%s", nuevoUsuario->cuit);

    char* cuitCorrecto = calcularCuit(nuevoUsuario->cuit);
    if (strcmp(nuevoUsuario->cuit, cuitCorrecto) != 0) {
        printf("La información cargada es invalida, por favor, intente de nuevo");
    }

    *usuario = nuevoUsuario;
}

void verInformacionUsuario(Usuario *usuario) {
    if (usuario == NULL) {
        printf("¡Ningún usuario fue cargado a la plataforma todavía!\n");
    } else {
        printf("nombre: %s, edad: %d, cuit: %s", usuario->nombre, usuario->edad, usuario->cuit);
    }
}

int main(int argc, char* argv[]) {
    Usuario *usuario = NULL;
    char comando[50];

    while(1) {
        scanf("%s", comando);
        if (strcmp(comando, "agregarInformacionUsuario") == 0) {
            agregarInformacionUsuario(& usuario);
        }
        if (strcmp(comando, "verInformacionUsuario") == 0) {
            verInformacionUsuario(usuario);
        }
    }
}