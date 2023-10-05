#include "vector.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


void test_push_back_y_size(void) {

    vector_t* mi_vector = nuevo_vector();

    push_back(mi_vector, 32);
    push_back(mi_vector, 11);

    if (get_size(mi_vector) != 2) {
        printf("Fallo en test_push_back_y_size\n");
        exit(1);
    }

    push_back(mi_vector, 5);
    push_back(mi_vector, 10);

    if (get_size(mi_vector) != 4) {
        printf("Fallo en test_push_back_y_size\n");
        exit(1);
    }

    push_back(mi_vector, 99);
    push_back(mi_vector, 1);
    push_back(mi_vector, 22);

    if (get_size(mi_vector) != 7) {
        printf("Fallo en test_push_back_y_size\n");
        exit(1);
    }

    free(mi_vector->array);
    free(mi_vector);
}

void test_son_iguales(void) {
    vector_t* mi_vectorA = nuevo_vector();
    push_back(mi_vectorA, 1);
    push_back(mi_vectorA, 2);
    push_back(mi_vectorA, 3);

    vector_t* mi_vectorB = nuevo_vector();
    push_back(mi_vectorB, 1);
    push_back(mi_vectorB, 2);
    push_back(mi_vectorB, 3);

    vector_t* mi_vectorC = nuevo_vector();
    push_back(mi_vectorC, 11);
    push_back(mi_vectorC, 2);
    push_back(mi_vectorC, 3);

    if (son_iguales(mi_vectorA, mi_vectorB) != 1) {
        printf("Fallo en test_son_iguales\n");
        exit(1);
    }
    
    if (son_iguales(mi_vectorA, mi_vectorC) != 0) {
        printf("Fallo en test_son_iguales\n");
        exit(1);
    }
    if (son_iguales(mi_vectorC, mi_vectorB) != 0) {
        printf("Fallo en test_son_iguales\n");
        exit(1);
    }
    

   free(mi_vectorA->array);
   free(mi_vectorB->array);
   free(mi_vectorC->array);
   free(mi_vectorA);
   free(mi_vectorB);
   free(mi_vectorC);
}

void test_iesimo(void) {
    vector_t* mi_vector = nuevo_vector();

    for (size_t i = 0; i < 20; i++) {
        push_back(mi_vector, 2*i);
    }
    
    for (size_t i = 0; i < 20; i++) {
        if (iesimo(mi_vector, i) != 2*i) {
            printf("Fallo en test_iesimo\n");
            exit(1);
        }
    }
    free(mi_vector->array);
    free(mi_vector);
}


void test_copiar_iesimo(void) {

    vector_t* mi_vector = nuevo_vector();

    for (size_t i = 0; i < 20; i++) {
        push_back(mi_vector, (2*i)+7);
    }
    
    uint32_t out = 0;

    for (size_t i = 0; i < 20; i++) {

        out = 0;
        copiar_iesimo(mi_vector, i, &out);

        if (out != (2*i)+7) {
            printf("Fallo en test_copiar_iesimo\n");
            exit(1);
        }
    }
    free(mi_vector->array);
    free(mi_vector);
}

void test_vector_mas_grande(void) {

    vector_t* mi_vectorA = nuevo_vector();
    push_back(mi_vectorA, 3);
    push_back(mi_vectorA, 2);
    push_back(mi_vectorA, 10);
    push_back(mi_vectorA, 3);
    push_back(mi_vectorA, 21);
    push_back(mi_vectorA, 199);

    vector_t* mi_vectorB = nuevo_vector();
    push_back(mi_vectorB, 11);
    push_back(mi_vectorB, 3);
    push_back(mi_vectorB, 30);
    push_back(mi_vectorB, 300);
    push_back(mi_vectorB, 311);
    push_back(mi_vectorB, 31);
    push_back(mi_vectorB, 13);

    vector_t* mi_vectorC = nuevo_vector();
    push_back(mi_vectorC, 11);
    push_back(mi_vectorC, 2);
    push_back(mi_vectorC, 3);

    vector_t* mi_vectorD = nuevo_vector();
    push_back(mi_vectorD, 111);
    push_back(mi_vectorD, 222);

    vector_t** array_de_vectores = malloc(4 * sizeof(vector_t*));
    array_de_vectores[0] = mi_vectorA;
    array_de_vectores[1] = mi_vectorB;
    array_de_vectores[2] = mi_vectorC;
    array_de_vectores[3] = mi_vectorD;
    vector_t* vector_grande = vector_mas_grande(array_de_vectores, 4);

    if (vector_grande != mi_vectorB) {
        printf("Fallo en test_vector_mas_grande\n");
        exit(1);
    }

    free(mi_vectorA->array);
    free(mi_vectorB->array);
    free(mi_vectorC->array);
    free(mi_vectorD->array);
    free(mi_vectorA);
    free(mi_vectorB);
    free(mi_vectorC);
    free(mi_vectorD);
    free(array_de_vectores);
    
}

int main() {

    printf("= Tests de vector:\n");
	printf("=========================================\n");
    
    test_push_back_y_size();
    test_son_iguales();
    test_iesimo();
    test_copiar_iesimo();
    test_vector_mas_grande();

	printf("¡Pasaron todos los tests!\n");
    exit(0);


}