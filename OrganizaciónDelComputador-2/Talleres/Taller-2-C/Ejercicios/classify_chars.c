#include "classify_chars.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void classify_chars_in_string(char* string, char** vowels_and_cons) {
    char* stringIterator = string;
    char* vowelIterator     = vowels_and_cons[0];
    char* consonantIterator = vowels_and_cons[1];

    while (*stringIterator != '\0') {
        char letter = *stringIterator;
        
        if (letter == 'a' || letter == 'e' || letter == 'i' || letter == 'o' || letter == 'u') {   
            memset(vowelIterator, letter, 1);
            vowelIterator++;
        } 
        else {
            memset(consonantIterator, letter, 1);
            consonantIterator++;
        }

        stringIterator++;
    }
}


void classify_chars(classifier_t* array, uint64_t size_of_array) {
    for (uint64_t i = 0; i < size_of_array; i++) {                                                  
        array[i].vowels_and_consonants    = malloc(2* sizeof(char*)); // Apunta a un array de 2 arrays de chars.vowelsAndConsonants;  
        array[i].vowels_and_consonants[0] = calloc(65, sizeof(char)); // Apunta a un array de 65 chars inicializados en 0.
        array[i].vowels_and_consonants[1] = calloc(65, sizeof(char)); // Apunta a un array de 65 chars inicializados en 0. 

        classify_chars_in_string(array[i].string, array[i].vowels_and_consonants);
    }
}
