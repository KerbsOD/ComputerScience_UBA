#include "vector.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

vector_t* nuevo_vector(void) {
    vector_t* nuevo = malloc(sizeof(vector_t));
    nuevo->size = 0;
    nuevo->capacity = 2;
    nuevo->array = malloc(nuevo->capacity * sizeof(*nuevo->array));
    return nuevo;
}

// Implementacion de Octo de nuevo vector (me gusta como se lee xd. Mas simple uwu)
// vector_t* nuevo_vector(void) {
//     vector_t* nuevo = malloc(sizeof(vector_t));
//     nuevo->size = 0;
//     nuevo->capacity = 2;
//     nuevo->array = malloc(2 * sizeof(uint32_t));
//     return nuevo;
// }

uint64_t get_size(vector_t* vector) {
    return vector->size;
}

void push_back(vector_t* vector, uint32_t elemento) {
    if (vector->size == vector->capacity)
    {
        vector->capacity *= 2;
        uint32_t* nuevoArray = malloc(vector->capacity * sizeof(vector->array));
        memcpy(nuevoArray, vector->array, (vector->capacity/2) * sizeof(*vector->array));
        free(vector->array);
        vector->array = nuevoArray;
    }

    vector->array[vector->size] = elemento;
    vector->size++;
}

// Implementacion de Octo con realloc
// void push_back(vector_t* vector, uint32_t elemento) {
//     if (vector->size == vector->capacity) {
//         vector->capacity *= 2;
//         vector->array = realloc(vector->array, vector->capacity * sizeof(*vector->array));
//     }    

//     vector->array[vector->size] = elemento;
//     vector->size++;
// }

int son_iguales(vector_t* v1, vector_t* v2) {
    if (v1->size != v2->size)
        return 0;

    for (uint64_t i = 0; i < v1->size; ++i)
        if (v1->array[i] != v2->array[i])
            return 0;

    return 1;
}


uint32_t iesimo(vector_t* vector, size_t index) {
    if (index >= vector->size)
        return 0;
    else
        return vector->array[index];
}


void copiar_iesimo(vector_t* vector, size_t index, uint32_t* out){
    *out = iesimo(vector,index);
}


// Dado un array de vectores, devuelve un puntero a aquel con mayor longitud.
// vector_t* vector_mas_grande(vector_t** array_de_vectores, size_t longitud_del_array) {
//     vector_t* res = array_de_vectores[0];
//     for (uint64_t i = 0; i < (sizeof(array_de_vectores) / sizeof(*array_de_vectores)); ++i)
//         if (array_de_vectores[i]->size > res->size)
//             res = array_de_vectores[i];
//     return res;
// }

// Nueva Implementacion de Octo. (funciona)
vector_t* vector_mas_grande(vector_t** array_de_vectores, size_t longitud_del_array) {
    vector_t* res = array_de_vectores[0];
    
    for (uint64_t i = 0; i < longitud_del_array; i++) {
        if (array_de_vectores[i]->size > res->size) {
            res = array_de_vectores[i];
        }
    }
    return res;
}
