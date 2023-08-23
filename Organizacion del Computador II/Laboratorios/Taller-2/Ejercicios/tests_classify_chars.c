#include "classify_chars.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void test_classify_chars_one(void) {

    classifier_t* mi_arr = malloc(1 * sizeof(classifier_t));
    mi_arr[0] = (classifier_t){.vowels_and_consonants = NULL, .string = "orgados-segundo-cuatri"};

    classify_chars(mi_arr, 1);

    char* vowels = mi_arr[0].vowels_and_consonants[0];
    char* cons   = mi_arr[0].vowels_and_consonants[1];

    char* actual_vowels = "oaoeuouai";
    char* actual_cons   = "rgds-sgnd-ctr";

    if (strcmp(vowels, actual_vowels) != 0) {
        printf("Fallo en test_classify_chars_one\n");
        exit(1);
    }
    if (strcmp(cons, actual_cons) != 0) {
        printf("Fallo en test_classify_chars_one\n");
        exit(1);
    }
    free(mi_arr[0].vowels_and_consonants[0]);
    free(mi_arr[0].vowels_and_consonants[1]);
    free(mi_arr[0].vowels_and_consonants);
    free(mi_arr);
}

void test_classify_chars_two(void) {

    classifier_t* mi_arr = malloc(2 * sizeof(classifier_t));
    mi_arr[0] = (classifier_t){.vowels_and_consonants = NULL, .string = "orgados-segundo-cuatri"};
    mi_arr[1] = (classifier_t){.vowels_and_consonants = NULL, .string = "exactasuubbaa"};

    classify_chars(mi_arr, 2);

    char* array_of_actuals[4] = {"oaoeuouai", "rgds-sgnd-ctr", "eaauuaa", "xctsbb"};

    for (size_t i = 0; i < 2; i++) {
        char* vowels = mi_arr[i].vowels_and_consonants[0];
        char* cons   = mi_arr[i].vowels_and_consonants[1];

        if (strcmp(vowels, array_of_actuals[2*i]) != 0) {
            printf("Fallo en test_classify_chars_two\n");
            exit(1);
        }
        if (strcmp(cons, array_of_actuals[(2*i)+1]) != 0) {
            printf("Fallo en test_classify_chars_two\n");
            exit(1);
        }

    }
    for(size_t i = 0; i < 2; i++) {
        free(mi_arr[i].vowels_and_consonants[0]);
        free(mi_arr[i].vowels_and_consonants[1]);
        free(mi_arr[i].vowels_and_consonants);
    }
    free(mi_arr);
}

void test_classify_chars_five(void) {

    classifier_t* mi_arr = malloc(5 * sizeof(classifier_t));
    mi_arr[0] = (classifier_t){.vowels_and_consonants = NULL, .string = "orgados-segundo-cuatri"};
    mi_arr[1] = (classifier_t){.vowels_and_consonants = NULL, .string = "exactasuubbaa"};
    mi_arr[2] = (classifier_t){.vowels_and_consonants = NULL, .string = "aaaaaa"};
    mi_arr[3] = (classifier_t){.vowels_and_consonants = NULL, .string = "kkkkj"};
    mi_arr[4] = (classifier_t){.vowels_and_consonants = NULL, .string = "ceromasinfinito"};

    classify_chars(mi_arr, 5);

    char* array_of_actuals[10] = {"oaoeuouai", "rgds-sgnd-ctr",
                                  "eaauuaa", "xctsbb",
                                  "aaaaaa", "",
                                  "", "kkkkj",
                                  "eoaiiio", "crmsnfnt" };

    for (size_t i = 0; i < 5; i++) {
        char* vowels = mi_arr[i].vowels_and_consonants[0];
        char* cons   = mi_arr[i].vowels_and_consonants[1];

        if (strcmp(vowels, array_of_actuals[2*i]) != 0) {
            printf("Fallo en test_classify_chars_five\n");
            exit(1);
        }
        if (strcmp(cons, array_of_actuals[(2*i)+1]) != 0) {
            printf("Fallo en test_classify_chars_five\n");
            exit(1);
        }

    }
    for(int i = 0; i < 5; i++) {
        free(mi_arr[i].vowels_and_consonants[0]);
        free(mi_arr[i].vowels_and_consonants[1]);
        free(mi_arr[i].vowels_and_consonants);
    }   
    free(mi_arr);
}

int main() {

    printf("= Tests de classify_chars:\n");
	printf("=========================================\n");
    
    test_classify_chars_one();
    test_classify_chars_two();
    test_classify_chars_five();

	printf("¡Pasaron todos los tests!\n");
    exit(0);
}