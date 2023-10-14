#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <ctype.h>
#include <assert.h>
#include <errno.h>
#include "ej2.h"


#define H 20
#define W 12

static bgra_t a[H][W];
static bgra_t b[H][W];
static bgra_t c[H][W];



void shuffle(uint32_t max){
	for (int i = 0; i < H; i++) {
        for (int j = 0; j < W; j++){
            uint8_t n= (uint8_t) rand() % max;
            a[i][j].r = n;
            a[i][j].g = n+1;
            a[i][j].b = n+2;
            a[i][j].a = 255;
            
            b[i][j].r = n;
            b[i][j].g = n-1;
            b[i][j].b = n-2;
            a[i][j].a = 255;
                
            c[i][j].r = (uint8_t) rand() % max;
            c[i][j].g = (uint8_t) rand() % max;
            c[i][j].b = (uint8_t) rand() % max;
            a[i][j].a = 255;
        }
	}
}

#define RUN(filename, action) pfile=fopen(filename,"a"); action; fclose(pfile);
#define NL(filename) pfile=fopen(filename,"a"); fprintf(pfile,"\n"); fclose(pfile);

char *filename_ej2 =  "salida.propios.ej2.txt";
void test_ej2(char* filename);


int main() {
	srand(0);
    remove(filename_ej2);
	test_ej2(filename_ej2);
	return 0;
}


uint32_t shuffle_int(uint32_t min, uint32_t max){
	return (uint32_t) (rand() % (max + 1)) + min;
}

void test_ej2(char* filename) {

    uint8_t *res = malloc(H*W*4);
    
    void (*func_mezclarColores)( uint8_t *, uint8_t *, uint32_t , 
                               uint32_t );
    if (USE_ASM_IMPL){
        func_mezclarColores = mezclarColores;
    }else{
        func_mezclarColores = mezclarColores_c;
    }

    FILE* pfile;
    shuffle(INT32_MAX);
    RUN(filename, fprintf(pfile, "== Ejercicio 2 ==\n");) NL(filename)
    RUN(filename, fprintf(pfile, "== Creciente ==\n");) NL(filename)


    func_mezclarColores((uint8_t*)a,(uint8_t*)res,W,H);

    for(int i=0;i<W;++i){
        for(int j=0;j<H;++j){
            RUN(filename, fprintf(pfile, "%3d ",res[i*W +j]);)
        }
        NL(filename)
    }


    RUN(filename, fprintf(pfile, "\n== Random ==\n");) NL(filename)

    func_mezclarColores((uint8_t*)c,(uint8_t*)res,W,H);

    for(int i=0;i<W;++i){
        for(int j=0;j<H;++j){
            RUN(filename, fprintf(pfile, "%3d ",res[i*W +j]);)
        }
        NL(filename)
    }

    RUN(filename, fprintf(pfile, "\n== Decreciente==\n");) NL(filename)

    func_mezclarColores((uint8_t*)c,(uint8_t*)res,W,H);

    for(int i=0;i<W;++i){
        for(int j=0;j<H;++j){
            RUN(filename, fprintf(pfile, "%3d ",res[i*W +j]);)
        }
        NL(filename)
    }



    free(res);
}

