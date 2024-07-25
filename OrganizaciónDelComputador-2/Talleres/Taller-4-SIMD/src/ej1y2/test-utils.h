#pragma once

#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

static size_t test__count = 0;
static size_t test__succeed__count = 0;

#define TEST(name)                                            \
void name##__impl(const char* test__name, bool* test__fallo, char assert_name[1024]); \
void name() {                                                 \
	test__count++;                                        \
	char assert_name[1024] = {0};                         \
	const char* test__name = #name;                       \
	bool test__fallo = false;                             \
	printf("- %s", test__name);                           \
	name##__impl(test__name, &test__fallo, assert_name);  \
	if (!test__fallo) {                                   \
		test__succeed__count++;                       \
		printf(" OK\n");                              \
	}                                                     \
}                                                             \
void name##__impl(const char* test__name, bool* test__fallo, char assert_name[1024])

#define TEST_ASSERT(cond)                                           \
	if (!(cond)) {                                              \
		printf(" FAILED\n");                                \
		if (assert_name[0] == '\0') {                       \
			strcpy(assert_name, #cond);                 \
		}                                                   \
		printf("    al probar %s\n", assert_name);          \
		printf("    fallo en %s:%d\n", __FILE__, __LINE__); \
		printf("        Condición: %s\n", #cond);           \
		*test__fallo = true;                                \
		return;                                             \
	}                                                           \
	assert_name[0] = '\0'

#define TEST_ASSERT_EQUALS(type, expected, got)                     \
	if ((type)(expected) != (type)(got)) {                      \
		char format[1024];                                  \
		printf(" FAILED\n");                                \
		if (assert_name[0] == '\0') {                       \
			strcpy(assert_name, #expected " == " #got); \
		}                                                   \
		printf("    al probar %s\n", assert_name);          \
		printf("    fallo en %s:%d\n", __FILE__, __LINE__); \
		printf("        Esperado: ");                       \
		PRINT_VALUE(type, (type)(expected));                \
		printf("\n");                                       \
		printf("        Recibido: ");                       \
		PRINT_VALUE(type, (type)(got));                     \
		printf("\n");                                       \
		*test__fallo = true;                                \
		                                                    \
	}                                                           \
	assert_name[0] = '\0'

#define TEST_ASSERT_EQUALS_ARRAY(type, expected, got, length)   \
	for (int i=0; i< length; ++i){                              \
        if ((type)(expected[i]) != (type)(got[i])) {            \
            char format[1024];                                  \
            printf(" FAILED\n");                                \
            if (assert_name[0] == '\0') {                       \
                strcpy(assert_name, #expected " == " #got);     \
            }                                                   \
            printf("    al probar %s\n", assert_name);          \
            printf("    fallo en %s:%d\n", __FILE__, __LINE__); \
            printf("        Esperado: ");                       \
            PRINT_VALUE(type, (type)(expected[i]));             \
            printf("\n");                                       \
            printf("        Recibido: ");                       \
            PRINT_VALUE(type, (type)(got[i]));                  \
            printf("\n");                                       \
            *test__fallo = true;                                \
                                                                \
        }                                                       \
    }                                                           \
	assert_name[0] = '\0'

/* Dumb generic printing mechanism */
static void print_int32_t(int32_t v)   { printf("%d",   v); }
static void print_uint64_t(uint64_t v) { printf("%lu",   v); }
static void print_uint8_t(uint8_t v)   { printf("%u",   v); }
static void print_uint32_t(uint32_t v) { printf("%u",   v); }
static void print_string(char* v)      { printf("%s",   v); }
static void print_float(float v)       { printf("%.2f", v); }
static void print_double(double v)     { printf("%.2f", v); }

#define PRINT_VALUE(type, value) _Generic(*((type*)NULL), \
	int32_t:  print_int32_t,         \
        uint8_t:  print_uint8_t,        \
        uint64_t: print_uint64_t, 	  \
	uint32_t: print_uint32_t,        \
	char*:    print_string,          \
	float:    print_float,           \
	double:   print_double           \
)(value)

static inline void tests_end() {
	printf(
		"Pasaron %ld de %ld tests\n",
		test__succeed__count,
		test__count
	);
	if (test__count == test__succeed__count) {
		printf("¡Pasaron todos los tests!\n");
		exit(0);
	} else {
		printf("Fallaron algunos tests.\n");
		exit(1);
	}
}

