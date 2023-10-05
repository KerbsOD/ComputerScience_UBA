#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <ctype.h>
#include <assert.h>
#include <math.h>
#include <stdbool.h>
#include <float.h>

#include "test-utils.h"
#include "checkpoints.h"

#define ARR_LENGTH  4
#define ROLL_LENGTH 10

static uint32_t x[ROLL_LENGTH];
static double   f[ROLL_LENGTH];

void shuffle(uint32_t max){
	for (int i = 0; i < ROLL_LENGTH; i++) {
		x[i] = (uint32_t) rand() % max;
        	f[i] = ((float)rand()/(float)(RAND_MAX)) * max;
	}
}

/**
 * Tests checkpoint 2
 */

TEST(test_alternate_sum_4) {
	for (int i = 0; i < 100; i++) {
		shuffle(1000);
		sprintf(assert_name, "alternate_sum_4(%u, %u, %u, %u)", x[0], x[1], x[2], x[3]);

		TEST_ASSERT_EQUALS(uint32_t, x[0]-x[1]+x[2]-x[3], alternate_sum_4(x[0], x[1], x[2], x[3]));
	}
}

TEST(test_alternate_sum_4_using_c) {
	for (int i = 0; i < 100; i++) {
		shuffle(1000);
		sprintf(assert_name, "alternate_sum_4_using_c(%u, %u, %u, %u)", x[0], x[1], x[2], x[3]);

		TEST_ASSERT_EQUALS(uint32_t, x[0]-x[1]+x[2]-x[3], alternate_sum_4_using_c(x[0], x[1], x[2], x[3]));
	}
}

TEST(test_alternate_sum_4_simplified) {
	for (int i = 0; i < 100; i++) {
		shuffle(1000);
		sprintf(assert_name, "alternate_sum_4_simplified(%u, %u, %u, %u)", x[0], x[1], x[2], x[3]);

		TEST_ASSERT_EQUALS(uint32_t, x[0]-x[1]+x[2]-x[3], alternate_sum_4_simplified(x[0], x[1], x[2], x[3]));
	}
}

TEST(test_alternate_sum_8) {
	for (int i = 0; i < 100; i++) {
		shuffle(1000);
		sprintf(assert_name, "alternate_sum_8(%u, %u, %u, %u, %u, %u, %u, %u)", x[0], x[1], x[2], x[3], x[4], x[5], x[6], x[7]);

		TEST_ASSERT_EQUALS(uint32_t, x[0]-x[1]+x[2]-x[3]+x[4]-x[5]+x[6]-x[7], alternate_sum_8(x[0], x[1], x[2], x[3], x[4], x[5], x[6], x[7]));
	}
}

TEST(test_product_2_f) {
	for (int i = 0; i < 100; i++) {
		shuffle(1000);
		sprintf(assert_name, "alternate_sum_8(&result, %u, %.2f)", x[0], f[0]);

		uint32_t result = -1;
		product_2_f(&result, x[0], f[0]);
		TEST_ASSERT_EQUALS(uint32_t, x[0]*f[0], result);
	}
}


TEST(test_product_9_f) {
	for (int i = 0; i < 100; i++) {
		shuffle(1000);
		sprintf(assert_name, "product_9_f(&result, %u, %.2f, %u, %.2f, %u, %.2f, %u, %.2f, %u, %.2f, %u, %.2f, %u, %.2f, %u, %.2f, %u, %.2f)",
		                     x[0], f[0], x[1], f[1], x[2], f[2], x[3], f[3], x[4], f[4], x[5], f[5], x[6], f[6], x[7], f[7], x[8], f[8]);

        	double expected = f[0] * f[1] * f[2] * f[3] * f[4] * f[5] * f[6] * f[7] * f[8]
        	                * x[0] * x[1] * x[2] * x[3] * x[4] * x[5] * x[6] * x[7] * x[8];
		double result = 1.0/0.0;
        	product_9_f(&result, x[0], f[0], x[1], f[1], x[2], f[2], x[3], f[3], x[4], f[4], x[5], f[5], x[6], f[6], x[7], f[7], x[8], f[8]);
		TEST_ASSERT_EQUALS(double, expected, result);
	}
}

/**
 * Tests checkpoint 3
 */

TEST(test_cantidad_total_de_elementos) {
	nodo_t* array[ARR_LENGTH];

	for (int i = 0; i < 100; i++) {
		shuffle(1000);
		sprintf(assert_name, "cantidad_total_elementos (prueba %d)", i);

		for(int j=0; j<ARR_LENGTH; j++){
			array[j] = calloc(1, sizeof(nodo_t));
			array[j]->longitud = x[j];
		}

		for(int j=0; j<ARR_LENGTH-1; j++){
			array[j]->next = array[j+1];
		}

		lista_t lista;
		lista.head = array[0];

		nodo_t* nodo = lista.head;
		uint32_t result = 0;

		while(nodo != NULL){
			result += nodo->longitud;
			nodo = nodo->next;
		}

		TEST_ASSERT_EQUALS(uint32_t, result, cantidad_total_de_elementos(&lista));

		for(int j=0; j<ARR_LENGTH; j++){
			free(array[j]);
		}
	}
}

TEST(test_cantidad_total_de_elementos_packed) {
	packed_nodo_t* array[ARR_LENGTH];

	for (int i = 0; i < 100; i++) {
		shuffle(1000);
		sprintf(assert_name, "cantidad_total_elementos_packed (prueba %d)", i);

		for(int j=0; j<ARR_LENGTH; j++){
			array[j] = calloc(1, sizeof(packed_nodo_t));
			array[j]->longitud = x[j];
		}

		for(int j=0; j<ARR_LENGTH-1; j++){
			array[j]->next = array[j+1];
		}

		packed_lista_t lista;
		lista.head = array[0];

		packed_nodo_t* nodo = lista.head;
		uint32_t result = 0;

		while(nodo != NULL){
			result += nodo->longitud;
			nodo = nodo->next;
		}

		TEST_ASSERT_EQUALS(uint32_t, result, cantidad_total_de_elementos_packed(&lista));

		for(int j=0; j<ARR_LENGTH; j++){
			free(array[j]);
		}
	}
}


/**
 * Tests checkpoint 4
 */

TEST(test_strLen) {
	TEST_ASSERT_EQUALS(uint32_t,  0, strLen(""));
	TEST_ASSERT_EQUALS(uint32_t,  3, strLen("sar"));
	TEST_ASSERT_EQUALS(uint32_t,  2, strLen("23"));
	TEST_ASSERT_EQUALS(uint32_t,  4, strLen("taaa"));
	TEST_ASSERT_EQUALS(uint32_t,  3, strLen("tbb"));
	TEST_ASSERT_EQUALS(uint32_t,  3, strLen("tix"));
	TEST_ASSERT_EQUALS(uint32_t,  5, strLen("taaab"));
	TEST_ASSERT_EQUALS(uint32_t,  4, strLen("taa0"));
	TEST_ASSERT_EQUALS(uint32_t,  3, strLen("tbb"));
	TEST_ASSERT_EQUALS(uint32_t, 11, strLen("Hola mundo!"));
	TEST_ASSERT_EQUALS(uint32_t,  9, strLen("Astronomo"));
	TEST_ASSERT_EQUALS(uint32_t, 10, strLen("Astrognomo"));
	TEST_ASSERT_EQUALS(uint32_t, 19, strLen("Campeones del mundo"));
}

TEST(test_strClone_string_normal) {
	char* a = "Omega 4";
	char* ac = strClone(a);
	TEST_ASSERT(a != ac);
	strcpy(assert_name, "ac == \"Omega 4\"");
	TEST_ASSERT(ac[0] == 'O' && ac[1] == 'm' && ac[2] == 'e' && ac[3] == 'g' && ac[4] == 'a' && ac[5] == ' ' && ac[6] == '4' && ac[7] == '\0');

	strDelete(ac);
}

TEST(test_strClone_string_vacio) {
	char* n = "";
	char* nc = strClone(n);
	TEST_ASSERT(n != nc);
	strcpy(assert_name, "ac == \"\"");
	TEST_ASSERT(nc[0] == '\0');

	strDelete(nc);
}

TEST(test_strCmp_las_cadenas_que_son_iguales_son_iguales) {
	// Esta cadena vive en la pila
	char cadena[] = "Orga 2!";
	TEST_ASSERT_EQUALS(int32_t, 0, strCmp("Orga 2!", cadena));
	TEST_ASSERT_EQUALS(int32_t, 0, strCmp(cadena,    "Orga 2!"));
	TEST_ASSERT_EQUALS(int32_t, 0, strCmp("Omega 4", "Omega 4"));
	TEST_ASSERT_EQUALS(int32_t, 0, strCmp("",        ""));
	TEST_ASSERT_EQUALS(int32_t, 0, strCmp("Palaven", "Palaven"));
	TEST_ASSERT_EQUALS(int32_t, 0, strCmp("Feros",   "Feros"));
}

TEST(test_strCmp_vacio_es_menor_a_todo) {
	// Esta cadena vive en la pila
	char cadena[] = "Orga 2!";
	TEST_ASSERT_EQUALS(int32_t, 1, strCmp("", cadena));
	TEST_ASSERT_EQUALS(int32_t, 1, strCmp("", "Omega 4"));
	TEST_ASSERT_EQUALS(int32_t, 1, strCmp("", "Feros"));
	TEST_ASSERT_EQUALS(int32_t, 1, strCmp("", "Palaven"));
}

TEST(test_strCmp_hay_cadenas_menores_a_otras) {
	// Esta cadena vive en la pila
	char cadena[] = "Orga 2!";
	TEST_ASSERT_EQUALS(int32_t, 1, strCmp("Omega 4",    cadena));
	TEST_ASSERT_EQUALS(int32_t, 1, strCmp(cadena,       "Orga 3?"));
	TEST_ASSERT_EQUALS(int32_t, 1, strCmp("Feros",      "Omega 4"));
	TEST_ASSERT_EQUALS(int32_t, 1, strCmp("Feros",      "Palaven"));
	TEST_ASSERT_EQUALS(int32_t, 1, strCmp("Omega 4",    "Palaven"));
	TEST_ASSERT_EQUALS(int32_t, 1, strCmp("Astrognomo", "Astronomo")); // Obviamente, porque un astro-gnomo va a ser más chiquitito
}

TEST(test_strCmp_todo_es_mayor_a_vacio) {
	// Esta cadena vive en la pila
	char cadena[] = "Orga 2!";
	TEST_ASSERT_EQUALS(int32_t, -1, strCmp(cadena,    ""));
	TEST_ASSERT_EQUALS(int32_t, -1, strCmp("Omega 4", ""));
	TEST_ASSERT_EQUALS(int32_t, -1, strCmp("Feros",   ""));
	TEST_ASSERT_EQUALS(int32_t, -1, strCmp("Palaven", ""));
}


TEST(test_strCmp_hay_cadenas_mayores_a_otras) {
	// Esta cadena vive en la pila
	char cadena[] = "Orga 2!";
	TEST_ASSERT_EQUALS(int32_t, -1, strCmp(cadena,      "Omega 4"));
	TEST_ASSERT_EQUALS(int32_t, -1, strCmp("Orga 3?",   cadena));
	TEST_ASSERT_EQUALS(int32_t, -1, strCmp("Omega 4",   "Feros"));
	TEST_ASSERT_EQUALS(int32_t, -1, strCmp("Palaven",   "Feros"));
	TEST_ASSERT_EQUALS(int32_t, -1, strCmp("Palaven",   "Omega 4"));
	TEST_ASSERT_EQUALS(int32_t, -1, strCmp("Astronomo", "Astrognomo")); // Obviamente, porque un astro-gnomo va a ser más chiquitito
}

TEST(test_strCmp_stress_test) {
	char* cadenas[9] = {"sar","23","taaa","tbb","tix", "taaab", "taa0", "tbb", ""};
	int32_t resultados[9][9] = {
		{  0, -1,  1,  1,  1,  1,  1,  1, -1 },
		{  1,  0,  1,  1,  1,  1,  1,  1, -1 },
		{ -1, -1,  0,  1,  1,  1, -1,  1, -1 },
		{ -1, -1, -1,  0,  1, -1, -1,  0, -1 },
		{ -1, -1, -1, -1,  0, -1, -1, -1, -1 },
		{ -1, -1, -1,  1,  1,  0, -1,  1, -1 },
		{ -1, -1,  1,  1,  1,  1,  0,  1, -1 },
		{ -1, -1, -1,  0,  1, -1, -1,  0, -1 },
		{  1,  1,  1,  1,  1,  1,  1,  1,  0 },
	};

	for (int i = 0; i < 9; i++) {
		for (int j = 0; j < 9; j++) {
			sprintf(assert_name, "strCmp(\"%s\", \"%s\")", cadenas[i], cadenas[j]);
			TEST_ASSERT_EQUALS(int32_t, resultados[i][j], strCmp(cadenas[i], cadenas[j]));
		}
	}
}

int main() {
	srand(0);

	printf("= Checkpoint 2\n");
	printf("==============\n");
	test_alternate_sum_4();
	test_alternate_sum_4_using_c();
	test_alternate_sum_4_simplified();
	test_alternate_sum_8();
	test_product_2_f();
	test_product_9_f();
	printf("\n");

	printf("= Checkpoint 3\n");
	printf("==============\n");
	test_cantidad_total_de_elementos();
	test_cantidad_total_de_elementos_packed();
	printf("\n");

	printf("= Checkpoint 4\n");
	printf("==============\n");
	test_strLen();
	test_strClone_string_normal();
	test_strClone_string_vacio();
	test_strCmp_las_cadenas_que_son_iguales_son_iguales();
	test_strCmp_vacio_es_menor_a_todo();
	test_strCmp_hay_cadenas_menores_a_otras();
	test_strCmp_todo_es_mayor_a_vacio();
	test_strCmp_hay_cadenas_mayores_a_otras();
	test_strCmp_stress_test();
	printf("\n");

	tests_end();
	return 0;
}
