/* ************************************************************************* */
/* Organizacion del Computador II                                            */
/*                                                                           */
/*                   Buscador de diferencias en archivos BMP                 */
/*                                                                           */
/*  Ejmplo para obtener la cantidad de pixeles distintos por diferencia      */
/*     bin/diff -v img1.bmp img2.bmp 0 | awk '{print $5}' | sort | uniq -c   */
/*                                                                           */
/* ************************************************************************* */

#include <stdio.h>
#include <stdlib.h>
#include "libbmp.h"

typedef struct s_options {
    char* program_name;
    int value;
    int verbose;
    int image;
    int help;
    int summaryop;
    int* summary;
    char* file1;
    char* file2;
    uint8_t epsilon;
} options;

void print_help(char* name);

int read_options(int argc, char* argv[], options* opt);

uint8_t cmp(uint8_t a, uint8_t b, int c, int r, char* channel, options* opt);

int main(int argc, char* argv[]){
    int i, j;

    // (0) leer parametros
    options opt;
    if (argc == 1) {
        print_help(argv[0]);
        return 0;
    }
    if (read_options(argc, argv, &opt)) {
        printf("ERROR reading parameters\n");
        return 1;
    }
    int len1 = strlen(opt.file1);
    int len2 = strlen(opt.file2);
    if (strcmp(&(opt.file1[len1-4]),".bmp") || strcmp(&(opt.file2[len2-4]),".bmp")) {
        printf("ERROR: nombre del archivo\n");
        return -1;
    }

    // (0.1) siempre armo el summary
    opt.summary = (int*)malloc(sizeof(int)*256);
    for (i=0; i<256; i++) {
        opt.summary[i]=0;
    }

    // (1) leer imagenes
    BMP* bmp1 = bmp_read(opt.file1);
    BMP* bmp2 = bmp_read(opt.file2);
    if (bmp1 == 0 || bmp1 == 0) {
        printf("ERROR: no se puede abrir el archivo\n");
        return -1;
    }

    // (2) check tipo de archivo
    if (((BMPIH*)(bmp1->ih))->biSize != ((BMPIH*)(bmp2->ih))->biSize) {
        printf("ERROR: tipo de archivo diferente\n");
        return -1;
    }

    // (3) check tamaño del archivo
    int w1 = ((BMPIH*)(bmp1->ih))->biWidth;
    int h1 = ((BMPIH*)(bmp1->ih))->biHeight;
    int c1 = ((BMPIH*)(bmp1->ih))->biBitCount;
    int w2 = ((BMPIH*)(bmp2->ih))->biWidth;
    int h2 = ((BMPIH*)(bmp2->ih))->biHeight;
    int c2 = ((BMPIH*)(bmp2->ih))->biBitCount;
    if (w1!=w2 || h1!=h2 || c1!=c2) {
        printf("ERROR: tamaño de archivo diferente\n");
        return -1;
    }
    //printf("%i=%i %i=%i %i=%i\n",w1,w2,h1,h2,c1,c2);
    if (w1 % 4 != 0) {
        // TODO: soportar padding!
        printf("ERROR: padding no soportado\n");
        return -1;
    }

    // (3) check el bit count TODO: only 24 o 32
    if (c1 != 24 && c1 != 32) {
        printf("ERROR: (%i) bitcount distinto de 24 o 32\n", c1);
        return -1;
    }

    // (4) crear imagenes de diferencias
    BMP *bmpDiffR, *bmpDiffG, *bmpDiffB, *bmpDiffA;
    bmpDiffR = bmp_copy(bmp1, 0);
    bmpDiffG = bmp_copy(bmp1, 0);
    bmpDiffB = bmp_copy(bmp1, 0);
    if (c1 == 32) {
        bmpDiffA = bmp_copy(bmp1,0);
    }

    // (5) extraer data
    uint8_t *data1, *data2, *dataR, *dataG, *dataB, *dataA;
    data1 = bmp_data(bmp1);
    data2 = bmp_data(bmp2);
    dataR = bmp_data(bmpDiffR);
    dataG = bmp_data(bmpDiffG);
    dataB = bmp_data(bmpDiffB);
    if (c1 == 32) {
        dataA = bmp_data(bmpDiffA);
    }

    // (6) calcular diferencias
    if (c1 == 32) {
        for(j=0;j<h1;j++) {
            for(i=0;i<w1;i++) {
              int pos = (j*w1+i)*4;

              uint8_t A1 = data1[pos+3];
              uint8_t R1 = data1[pos+2];
              uint8_t G1 = data1[pos+1];
              uint8_t B1 = data1[pos+0];
              uint8_t A2 = data2[pos+3];
              uint8_t R2 = data2[pos+2];
              uint8_t G2 = data2[pos+1];
              uint8_t B2 = data2[pos+0];

              dataR[pos+0] = cmp(R1,R2,i,j,"R",&opt);
              dataR[pos+1] = dataR[pos+0];
              dataR[pos+2] = dataR[pos+0];
              dataR[pos+3] = 255;

              dataG[pos+0] = cmp(G1,G2,i,j,"G",&opt);
              dataG[pos+1] = dataG[pos+0];
              dataG[pos+2] = dataG[pos+0];
              dataG[pos+3] = 255;

              dataB[pos+0] = cmp(B1,B2,i,j,"B",&opt);
              dataB[pos+1] = dataB[pos+0];
              dataB[pos+2] = dataB[pos+0];
              dataB[pos+3] = 255;

              dataA[pos+0] = cmp(A1,A2,i,j,"A",&opt);
              dataA[pos+1] = dataA[pos+0];
              dataA[pos+2] = dataA[pos+0];
              dataA[pos+3] = 255;
            }
        }
    } else if(c1 == 24) {
        for(j=0;j<h1;j++) {
            for(i=0;i<w1;i++) {
                int pos = (j*w1+i)*3;
                uint8_t R1 = data1[pos+2];
                uint8_t G1 = data1[pos+1];
                uint8_t B1 = data1[pos+0];
                uint8_t R2 = data2[pos+2];
                uint8_t G2 = data2[pos+1];
                uint8_t B2 = data2[pos+0];

                dataR[pos+2] = cmp(R1,R2,i,j,"R",&opt);
                dataR[pos+1] = dataR[pos+2];
                dataR[pos+0] = dataR[pos+2];

                dataG[pos+2] = cmp(G1,G2,i,j,"G",&opt);
                dataG[pos+1] = dataG[pos+2];
                dataG[pos+0] = dataG[pos+2];

                dataB[pos+2] = cmp(B1,B2,i,j,"B",&opt);
                dataB[pos+1] = dataB[pos+2];
                dataB[pos+0] = dataB[pos+2];
            }
        }
    }

    // (7) mostrar summary
    if(opt.summaryop) {
        for(i=1;i<256;i++) {
            if(opt.summary[i]!=0) {
                printf("%i\t%i\n", i, opt.summary[i]);
            }
        }
    }

    // (8) guardar resultados
    if(opt.image) {
        char* strX = "diffX.bmp";
        char* fileSto = malloc(strlen(opt.file1) + 5 + 1);
        strcpy(fileSto, opt.file1);
        strcpy(fileSto + len1 - 4, strX);
        fileSto[len1]='R';
        bmp_save(fileSto, bmpDiffR);
        fileSto[len1]='G';
        bmp_save(fileSto, bmpDiffG);
        fileSto[len1]='B';
        bmp_save(fileSto, bmpDiffB);
        fileSto[len1]='A';
        if (c1 == 32) {
            bmp_save(fileSto,bmpDiffA);
        }

        // (8.1) borrar las imagenes
        bmp_delete(bmp1);
        bmp_delete(bmp2);
        bmp_delete(bmpDiffR);
        bmp_delete(bmpDiffG);
        bmp_delete(bmpDiffB);
        if (c1 == 32) {
            bmp_delete(bmpDiffA);
        }
    }

    // (9) retorno error si encontre una diferencia
    for (i = opt.epsilon+1; i < 256; i++) {
        if (opt.summary[i] > 0) {
            return -1;
        }
    }
    return 0;
}

uint8_t cmp(uint8_t a, uint8_t b, int c, int r, char* channel, options* opt) {
    int diff = (int)abs(((int)a)-((int)b));
    opt->summary[diff]++;
    if (opt->verbose && diff > opt->epsilon) {
        printf("%i\t%i\t%s\t=\t%i\n", r, c, channel, diff);
    }
    if (opt->value) {
        return (uint8_t)((256-diff) & 0xff);
    }
    if (diff > opt->epsilon) {
        return 255;
    }
    return 0;
}

void print_help(char* name) {
    printf ( "Uso: %s <opciones> <archivo_1> <archivo_2> <epsilon>\n", name );
    printf ( "Ejemplo de uso:\n" );
    printf ( "    %s -i -a lena_a.bmp lena_b.bmp 5\n", name );
    printf ( "\n" );
    printf ( "    Verifica pixel a pixel que la diferencia entre lena_a.bmp y  \n" );
    printf ( "    lena_b.bmp no supere el valor 5. Con -i genera una imágen por canal \n" );
    printf ( "    a partir de las diferencias. Coloca un pixel blanco donde    \n" );
    printf ( "    haya diferencias y uno negro donde no. Si se usa -a entonces \n" );
    printf ( "    indica en gris el valor de la diferencia, donde negro es sin \n" );
    printf ( "    diferencias y blanco es diferencia en 1.\n" );
    printf ( "\n" );
    printf ( "    -h, --help       Imprime esta ayuda\n" );
    printf ( "    -a, --value      En vez de marcar en blanco sobre negro las diferencias,\n"
	         "                     lo hace en escala de grises\n" );
    printf ( "    -v, --verbose    Ejecuta en verbose mostrando las diferencias\n" );
    printf ( "    -s, --summary    Muestra un resumen de diferencias\n" );
    printf ( "    -i, --image      Genera una imagen de diferencias por cada canal\n"
	         "                     en el directorio destino\n" );
}

int read_options(int argc, char* argv[], options* opt) {
    opt->program_name = argv[0];
    opt->verbose = 0;
    opt->value = 0;
    opt->help = 0;
    opt->file1 = 0;
    opt->file2 = 0;
    opt->image = 0;
    opt->summaryop = 0;
    int i, optionals = 0;
    for (i=1; i < argc; i++) {
        if (!strcmp(argv[i], "-h") || !strcmp(argv[i], "--help")) {
            opt->help = 1;
            optionals++;
        }
        if (!strcmp(argv[i], "-v") || !strcmp(argv[i], "--verbose")) {
            opt->verbose = 1;
            optionals++;
        }
        if (!strcmp(argv[i], "-a") || !strcmp(argv[i], "--value")) {
            opt->value = 1;
            optionals++;
        }
        if (!strcmp(argv[i], "-i") || !strcmp(argv[i], "--image")) {
            opt->image = 1;
            optionals++;
        }
        if (!strcmp(argv[i], "-s") || !strcmp(argv[i], "--summary")) {
            opt->summaryop = 1;
            optionals++;
        }
    }
    if (argc - 1 - optionals != 3) {
        return 1;
    }
    opt->epsilon = atoi(argv[argc-1]);
    opt->file1 = argv[argc-2];
    opt->file2 = argv[argc-3];
    return 0;
}
