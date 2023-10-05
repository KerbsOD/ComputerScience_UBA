#ifndef __UTILS__H__
#define __UTILS__H__

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#define SAT utils_saturate

uint8_t utils_saturate(int32_t a);


void utils_copyBorders32( uint8_t *src, uint8_t *dst,
                          int width, int height, int row_size,
                          int size);

void utils_paintBorders32( uint8_t *dst,
                           int width, int height, int row_size,
                           int size, uint32_t rgba);

uint8_t* utils_verticalFlip(uint8_t *src, int height, int width);

#endif /* !__UTILS__H__ */

