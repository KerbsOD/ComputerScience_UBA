#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "checkpoints.h"

int main (void){
	/* Acá pueden realizar sus propias pruebas */
	//checksum_asm()
	uint64_t* p = 32;
	invertirQW_asm(p);
	return 0;    
}


