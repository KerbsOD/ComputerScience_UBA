#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdint.h>
#include "../simd.h"
#include "../helper/utils.h"

void Pintar_c(
    uint8_t *src,
    uint8_t *dst,
    int width,
    int height,
    int src_row_size,
    int dst_row_size)
{
    bgra_t (*dst_matrix)[(dst_row_size+3)/4] = (bgra_t (*)[(dst_row_size+3)/4]) dst;

    // Offset
    for (int i = 2; i < height-2; i++) {
        for (int j = 2; j < width-2; j++) {
            dst_matrix[i][j].b = 255;
            dst_matrix[i][j].g = 255;
            dst_matrix[i][j].r = 255;
            dst_matrix[i][j].a = 255;
        }
    }
    utils_paintBorders32(dst, width, height, src_row_size, 2, 0xFF000000);
}
