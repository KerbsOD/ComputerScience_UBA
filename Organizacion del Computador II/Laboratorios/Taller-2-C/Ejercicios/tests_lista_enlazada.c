#include "lista_enlazada.h"
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <string.h>


#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(*(arr)))

void imprimir_array(int* array, size_t cantidad) {
    printf("{ ");
    for (size_t i = 0; i < cantidad; i++) {
        printf("%d ", array[i]);
    }
    printf("}\n");
}

bool arrays_son_iguales(uint32_t* a1, uint64_t longitud, uint32_t* a2, uint64_t longitud2) {
    if (longitud !=longitud2) {
        return false;
    }
    return memcmp(a1, a2, longitud) == 0;
}


void test_agregar_al_final(void) {

    lista_t* mi_lista = nueva_lista();
    uint32_t* array = calloc(10, sizeof(uint32_t));

    nodo_t* head_lista = calloc(1, sizeof(nodo_t));

    for (uint32_t i = 0; i < 10; i++) {
        array[i] = ((100 - i) * 2) + 45;
    }
    head_lista->arreglo = array;
    head_lista->longitud = 10;
    mi_lista->head = head_lista;

    uint32_t arr1[] = {32, 7, 2, 1, 272, 50, 34, 67, 45, 99};
    agregar_al_final(mi_lista, arr1, ARRAY_SIZE(arr1));
    uint32_t arr2[] = {2, 56, 76, 5, 1, 9, 0, 45, 67, 87, 43, 23, 56, 76, 87, 86, 101, 9, 3, 345, 21};
    agregar_al_final(mi_lista, arr2, ARRAY_SIZE(arr2));
    uint32_t arr3[] = {40, 34, 21};
    agregar_al_final(mi_lista, arr3, ARRAY_SIZE(arr3));
    uint32_t arr4[] = {3};
    agregar_al_final(mi_lista, arr4, ARRAY_SIZE(arr4));
    uint32_t arr5[] = {2, 45, 767, 54, 64, 5, 786, 2};
    agregar_al_final(mi_lista, arr5, ARRAY_SIZE(arr5));
    
    bool res = true;
    nodo_t* it = mi_lista->head;
    int j = 0;

    while (it != NULL) {

        if (j == 0) {
            for (size_t i = 0; i < 10; i++) {
                if (it->arreglo[i] != ((100 - i) * 2) + 45) {
                    res = false;
                    break;
                }
            }
        } else if (j == 1) {
                if (!(arrays_son_iguales(it->arreglo, it->longitud, arr1, ARRAY_SIZE(arr1)))) {
                    res = false;
                    break;
                }
        } else if (j == 2) {
                if (!(arrays_son_iguales(it->arreglo, it->longitud, arr2, ARRAY_SIZE(arr2)))) {
                    res = false;
                    break;
                }
        } else if (j == 3) {
                if (!(arrays_son_iguales(it->arreglo, it->longitud, arr3, ARRAY_SIZE(arr3)))) {
                    res = false;
                    break;
                }
        } else if (j == 4) {
                if (!(arrays_son_iguales(it->arreglo, it->longitud, arr4, ARRAY_SIZE(arr4)))) {
                    res = false;
                    break;
                }
        } else if (j == 5) {
                if (!(arrays_son_iguales(it->arreglo, it->longitud, arr5, ARRAY_SIZE(arr5)))) {
                    res = false;
                    break;
                }
        }

        it = it->next;
        j++;
    }

    if (res == false) {
        printf("Fallo en agregar_al_final\n");
        exit(1);
    }

    destruir_lista(mi_lista);
}



void test_cantidad_total_de_elementos(void) {
    lista_t* mi_lista = nueva_lista();
    //uint32_t* array = malloc(sizeof(uint32_t) * 12);
    uint32_t* array = calloc(12, sizeof(uint32_t));
    //nodo_t* head_lista = malloc(sizeof(nodo_t));
    nodo_t* head_lista = calloc(1, sizeof(nodo_t));
    for (size_t i = 0; i < 12; i++) {
        array[i] = i;
    }
    head_lista->arreglo = array;                      
    head_lista->longitud = 12;
    head_lista->next = NULL;
    mi_lista->head = head_lista;
    uint32_t arr1[3] = {32, 7, 2};
    agregar_al_final(mi_lista, arr1, ARRAY_SIZE(arr1));
    uint32_t arr2[2] = {2, 56};
    agregar_al_final(mi_lista, arr2, ARRAY_SIZE(arr2));
    uint32_t arr3[4] = {40, 34, 21, 16};
    agregar_al_final(mi_lista, arr3, ARRAY_SIZE(arr3));
    uint32_t arr4[2] = {3, 8};
    agregar_al_final(mi_lista, arr4, ARRAY_SIZE(arr4));
    uint32_t arr5[1] = {2};
    agregar_al_final(mi_lista, arr5, ARRAY_SIZE(arr5));

    uint64_t suma = cantidad_total_de_elementos(mi_lista);

    if (suma != 24) {
        printf("Fallo en cantidad_total_de_elementos\n");
        exit(1);
    }

    uint32_t arr6[6] = {6, 3, 4, 7, 3, 1};
    agregar_al_final(mi_lista, arr6, ARRAY_SIZE(arr6));

    suma = cantidad_total_de_elementos(mi_lista);

    if (suma != 30) {
        printf("Fallo en cantidad_total_de_elementos\n");
        exit(1);
    }

    destruir_lista(mi_lista);

}

void test_lista_contiene_elemento(void) {

    lista_t* mi_lista = nueva_lista();
    //uint32_t* array = malloc(sizeof(uint32_t) * 12);
    uint32_t* array = calloc(12, sizeof(uint32_t));
    nodo_t* head_lista = calloc(1, sizeof(nodo_t));
    //nodo_t* head_lista = malloc(sizeof(nodo_t));
    for (size_t i = 0; i < 12; i++) {
        array[i] = i;
    }
    head_lista->arreglo = array;                      
    head_lista->longitud = 12;
    head_lista->next = NULL;
    mi_lista->head = head_lista;

    uint32_t arr1[3] = {32, 7, 2};
    agregar_al_final(mi_lista, arr1, ARRAY_SIZE(arr1));
    uint32_t arr2[2] = {2, 56};
    agregar_al_final(mi_lista, arr2, ARRAY_SIZE(arr2));
    uint32_t arr3[4] = {40, 34, 21, 16};
    agregar_al_final(mi_lista, arr3, ARRAY_SIZE(arr3));
    uint32_t arr4[2] = {3, 8};
    agregar_al_final(mi_lista, arr4, ARRAY_SIZE(arr4));
    uint32_t arr5[1] = {2};
    agregar_al_final(mi_lista, arr5, ARRAY_SIZE(arr5));

    int result1 = lista_contiene_elemento(mi_lista, 32);
    if (result1 != 1) {
        printf("Fallo en lista_contiene_elemento\n");
        exit(1);
    }
    int result2 = lista_contiene_elemento(mi_lista, 2);
    if (result2 != 1) {
        printf("Fallo en lista_contiene_elemento\n");
        exit(1);
    }
    int result3 = lista_contiene_elemento(mi_lista, 100);
    if (result3 != 0) {
        printf("Fallo en lista_contiene_elemento\n");
        exit(1);
    }
    int result4 = lista_contiene_elemento(mi_lista, 88);
    if (result4 != 0) {
        printf("Fallo en lista_contiene_elemento\n");
        exit(1);
    }
    int result5 = lista_contiene_elemento(mi_lista, 99);
    if (result5 != 0) {
        printf("Fallo en lista_contiene_elemento\n");
        exit(1);
    }
    int result6 = lista_contiene_elemento(mi_lista, 56);
    if (result6 != 1) {
        printf("Fallo en lista_contiene_elemento\n");
        exit(1);
    }

    destruir_lista(mi_lista);
}

void testear_todas_las_funciones() {
    test_agregar_al_final();
    test_cantidad_total_de_elementos();
    test_lista_contiene_elemento();
}


int main(void) {
	printf("= Tests de lista_enlazada:\n");
	printf("=========================================\n");
    
    testear_todas_las_funciones();

	printf("¡Pasaron todos los tests!\n");
    exit(0);
	
}