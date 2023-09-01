#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "checkpoints.h"

uint32_t sumar_c(uint32_t a,uint32_t b){
	return a + b; 
}
uint32_t restar_c(uint32_t a,uint32_t b){
	return a - b; 
}

int main (void){
	
	// Test 1
	// int resultado = 0.0;
	// int*ptr = &resultado;
	// product_2_f(ptr, 8, 1.5);
	// printf("El resultado es: %d\n", resultado);
	
	// Test 2
	double resultado = 0.0;
	double *ptr = &resultado;
	product_9_f(ptr, 4, 1.5, 1, 1.0, 1, 1.0, 1, 1.0, 1, 1.0, 1, 1.0, 1, 1.0, 1, 1.0, 2, 1.5);
	printf("El resultado es: %f\n", resultado);

	
	
	//product_9_f(ptr, 1, 1.0, 1, 1.0, 1, 1.0, 1, 1.0, 1, 1.0, 1, 1.0, 1, 1.0, 1, 1.0, 1, 1.0);
	return 0;    
}


