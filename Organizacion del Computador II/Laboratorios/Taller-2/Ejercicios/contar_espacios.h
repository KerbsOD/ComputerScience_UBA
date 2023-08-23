#ifndef __CONTAR_ESPACIOS_H__
#define __CONTAR_ESPACIOS_H__

#include <stdint.h>
#include <stddef.h>

/*
    Contar Espacios.

    Recibimos un string por parámetro, y debemos contar la cantidad de espacios que hay en él.

    Tener en cuenta que el puntero puede no ser válido (NULL), o que el string puede ser vacío. Se asume que un puntero no válido tiene longitud 0.
    ¿Cuántos espacios tiene el string vacío?
*/

// Dado un string, retorna su longitud, es decir la cantidad de caracteres que este tiene. No se permite el uso de 'strlen'.
uint32_t longitud_de_string(char* string);

// Dado un string, retorna la cantidad de espacios que hay en él.
uint32_t contar_espacios(char* string);

#endif // __CONTAR_ESPACIOS_H__