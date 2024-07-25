#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdint.h>
#include "../simd.h"

void Pintar_asm (uint8_t *src, uint8_t *dst, int width, int height,
                      int src_row_size, int dst_row_size);

void Pintar_c (uint8_t *src, uint8_t *dst, int width, int height,
                      int src_row_size, int dst_row_size);

typedef void (Pintar_fn_t) (uint8_t*, uint8_t*, int, int, int, int);


void leer_params_Pintar(configuracion_t *config, int argc, char *argv[]) {

}

void aplicar_Pintar(configuracion_t *config)
{
    Pintar_fn_t *Pintar = SWITCH_C_ASM( config, Pintar_c, Pintar_asm );
    buffer_info_t info = config->src;
    Pintar(info.bytes, config->dst.bytes, info.width, info.height, 
            info.row_size, config->dst.row_size);
}

void liberar_Pintar(configuracion_t *config) {

}

void ayuda_Pintar()
{
    printf ( "       * Pintar\n" );
    printf ( "           Parámetros     : \n"
             "                         no tiene\n");
    printf ( "           Ejemplo de uso : \n"
             "                         Pintar -i c facil.bmp\n" );
}

DEFINIR_FILTRO(Pintar)


