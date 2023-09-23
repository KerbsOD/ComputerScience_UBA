#ifndef CHECKPOINTS
#define CHECKPOINTS

#include <stdint.h>	//contiene la definición de tipos enteros ligados a tamaños int8_t, int16_t, uint8_t,...

typedef struct data_s{
    uint16_t a[8];
    uint16_t b[8];
    uint32_t c[8];
} data_t;

void invertirQW_c(uint64_t* p);
void invertirQW_asm(uint64_t* p);
uint8_t checksum_c(void* array, uint32_t n);
uint8_t checksum_asm(void* array, uint32_t n);

#endif /* CHECKPOINTS */
