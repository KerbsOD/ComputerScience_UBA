#ifndef __VECTOR_H__
#define __VECTOR_H__

#include <stddef.h>
#include <stdint.h>

/*
En este ejercicio implementaremos una estructura de datos que nos permita reemplazar el uso de arrays por algo más seguro, es decir, que verifique que la posición de memoria que se intenta acceder sea válida.
*/

typedef struct vector_s {
	uint64_t size;	// Cantidad de elementos en el vector
    uint64_t capacity;    // Capacidad del vector
	// El array subyacente con los elementos del vector (el tamaño del array estará dado por el campo capacity):
	uint32_t* array;
} vector_t;

// Lo que vemos dentro del struct vector_t es la estructura *interna* de nuestro vector, por lo tanto los usuarios de vector_t no deberían
// usar directamente estos campos [Encapsulamiento de la información].
// El lenguaje no nos provee ninguna herramienta para que dichos campos sean 'privados', este tipo de cuestiones las tenemos que resolver
// 'por convención', por ejemplo, si el cliente/usuario de vector_t quiere conocer la longitud del vector, no debería acceder directamente al campo
// size del struct, sino que nosotros deberíamos proveerle una interfaz que permita, a través de una función conocer la longitud, por ejemplo
//      uint64_t get_size(vector_t*)


// Construye y retorna un nuevo vector vacío con capacity=2.
vector_t* nuevo_vector(void);

// Retorna la cantidad de elementos (válidos) del vector.
uint64_t get_size(vector_t*);

// Agrega un elemento al final del vector.
// Pista: leer el manual de malloc (man malloc en la Terminal) y buscar de qué
// forma se puede modificar el tamaño del bloque de memoria previamente devuelto
// por un llamado a malloc.
// Por ejemplo: si malloc nos devolvió un puntero a un bloque de 16 bytes de
// memoria, investigar de qué manera podemos hacer que ese mismo puntero ahora
// apunte a un bloque de 32 bytes (o cualquier otro tamaño que quisiéramos).
void push_back(vector_t*, uint32_t);

// Retorna el elemento i-ésimo del vector.
// Precondición: vector es válido.
// Devuelve 0 en caso que el índice sea inválido.
uint32_t iesimo(vector_t*, size_t);

// Retorna 1 si dado 2 vectores estos son iguales, es decir si todos sus elementos coinciden. Retorna 0 de otro modo.
int son_iguales(vector_t*, vector_t*);

// Copia el elemento i-ésimo del vector a la memoria apuntada por out.
void copiar_iesimo(vector_t* vector, size_t index, uint32_t* out);

// Dado un array de vectores, devuelve un puntero a aquel con mayor longitud.
// Si hay más de uno con dicha longitud, devuelve el primero. Si el array es
// vacío, devuelve NULL.
vector_t* vector_mas_grande(vector_t**, size_t);

#endif // __VECTOR_H__