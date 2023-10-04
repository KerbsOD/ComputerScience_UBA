#ifndef __LISTA_ENLAZADA_H__
#define __LISTA_ENLAZADA_H__


#include <stdint.h>
#include <stddef.h>

// Lista de arreglos de enteros de 32 bits sin signo.
typedef struct nodo_s {
    struct nodo_s* next;   // Siguiente elemento de la lista o NULL si es el final
    uint64_t longitud;     // Longitud del arreglo
    uint32_t* arreglo;     // Arreglo de enteros
} nodo_t;

typedef struct lista_s {
    nodo_t* head;    // Puntero al primer nodo que encabeza la lista
} lista_t;

// ===================== Funciones a implementar =====================

// Crea una lista.
// ¿Cuál sería el equivalente a inicializar una variable de tipo entero con 0, para el caso de una variable de tipo puntero?
lista_t* nueva_lista(void);

// Retorna la longitud de la lista, es decir la cantidad de nodos.
uint32_t longitud(lista_t* lista);

// Retorna el elemento i-ésimo (i es el segundo argumento) de la lista indicada por el primer argumento.
// Precondición: i es un indice válido.
nodo_t* iesimo(lista_t* lista, uint32_t i);

// Imprime por pantalla el tamaño de los arreglos de cada nodo de la lista.
// Si los arrays en cada nodo de la lista tienen una longitud de 10, 20, 30 y 40,
// entonces imprimir_lista debería mostrar algo como:
// "| 10 | -> | 20 | -> | 30 | -> | 40 | -> null"
void imprimir_lista(lista_t*);

// Agrega un nodo al final de la lista.
// El nuevo nodo contendrá al array pasado como segundo argumento con su tamaño indicado por el tercer argumento.
// IMPORTANTE: se deberá almacenar una copia del arreglo pasado por parámetro,
// y dicha copia deberá ser válida durante todo el tiempo de vida de la lista.
void agregar_al_final(lista_t* lista, uint32_t* arreglo, uint64_t longitud);

// Retorna la cantidad total de elementos de todos los arrays contenidos en la lista.
uint64_t cantidad_total_de_elementos(lista_t* lista);

// Retorna 1 si algún array de todos los nodos de la lista contiene al entero pasado por parámetro, 0 en caso contrario.
int lista_contiene_elemento(lista_t* lista, uint32_t elemento_a_buscar);

// Libera la memoria asignada a la lista.
void destruir_lista(lista_t* lista);

#endif // __LISTA_ENLAZADA_H__