#include "lista_enlazada.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>


lista_t* nueva_lista(void) {
    return malloc(sizeof(lista_t));
}

uint32_t longitud(lista_t* lista) {
    nodo_t* actual = lista->head;
    uint32_t res = 0;

    while (actual != NULL)
    {
        ++res;
        actual = actual->next;
    }

    return res;
}

void agregar_al_final(lista_t* lista, uint32_t* arreglo, uint64_t longitud) {
    nodo_t* actual   = lista->head;
    nodo_t* anterior = lista->head;

    while (actual != NULL) {
        anterior = actual;
        actual = actual->next;
    }

    actual = malloc(sizeof(nodo_t));
    actual->next     = NULL;
    actual->longitud = longitud;
    actual->arreglo  = malloc(longitud*sizeof(*arreglo));

    anterior->next = actual;

    for(uint32_t i = 0; i < longitud; i++) {
        actual->arreglo[i] = arreglo[i];
    }
}

nodo_t* iesimo(lista_t* lista, uint32_t i) {
    nodo_t* res = lista->head;

    for (; i > 0; --i)
        res = res->next;

    return res;
}

uint64_t cantidad_total_de_elementos(lista_t* lista) {
    uint64_t res = 0;
    nodo_t* actual = lista->head;

    while (actual != NULL)
    {
        res += actual->longitud;
        actual = actual->next;
    }

    return res;
}

void imprimir_lista(lista_t* lista) {
    nodo_t *actual = lista->head;

    while (actual != NULL)
    {
        printf("| %lu | -> ", actual->longitud);
        actual = actual->next;
    }
    printf("null\n");
}

// Función auxiliar para lista_contiene_elemento
int array_contiene_elemento(const uint32_t* array, uint64_t size_of_array, uint32_t elemento_a_buscar) {
    for (uint64_t i = 0; i < size_of_array; ++i)
        if (array[i] == elemento_a_buscar)
            return 1;
    return 0;
}

int lista_contiene_elemento(lista_t* lista, uint32_t elemento_a_buscar) {
    nodo_t* actual = lista->head;
    while (actual != NULL)
    {
        if (array_contiene_elemento(actual->arreglo, actual->longitud, elemento_a_buscar))
            return 1;
        actual = actual->next;
    }
    return 0;
}


// Devuelve la memoria otorgada para construir la lista indicada por el primer argumento.
// Tener en cuenta que ademas, se debe liberar la memoria correspondiente a cada array de cada elemento de la lista.
void destruir_lista(lista_t* lista) {
    nodo_t* actual = lista->head;

    while (actual != NULL) {
        nodo_t* siguiente = actual->next;
        free(actual->arreglo);
        free(actual);
        actual = siguiente;
    }

    free(lista);
}