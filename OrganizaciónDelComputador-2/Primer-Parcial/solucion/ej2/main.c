#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "ej2.h"

int main (void){
	/* Acá pueden realizar sus propias pruebas */
	uint8_t pixeles[16]  = {1,2,3,255,   3,2,1,255,   1,1,1,255,   45,32,56,255};
	// ESPERADO            {2,3,1,0      1,3,2,0      1,1,1,0,     45,32,56, 0}

	uint8_t mezclado[16] = {15,15,15,15, 15,15,15,15, 15,15,15,15, 15,15,15,15};

	mezclarColores(pixeles, mezclado, 16, 1);

	for (int i = 0; i < 16; i++) {
		if (i == 0 || i == 4 || i == 8 || i == 12) {
			printf("Pixel %d:\n [", i/4);
		}
		if (i==3 || i==7 || i==11 || i==15) {
			printf("%d]\n", mezclado[i]);
			printf("\n");
		} else {
			printf("%d, ", mezclado[i]);
		}
	}
	return 0;    
}




