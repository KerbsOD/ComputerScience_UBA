#ifndef __CLASSIFY_CHARS_H__
#define __CLASSIFY_CHARS_H__

#include <stddef.h>
#include <stdint.h>

typedef struct classifier_s {
    char** vowels_and_consonants;
	char* string;
} classifier_t;

/*
    La función deberá configurar el campo vowels_and_consonants como corresponde.
    Esto es: Que en el primer array (indicado por vowels_and_consonants[0]) queden
    todas las vocales del string, y en el segundo (vowels_and_consonants[1]) las consonantes.
*/
void classify_chars(classifier_t* array, uint64_t size_of_array);

#endif // __CLASSIFY_CHARS_H__