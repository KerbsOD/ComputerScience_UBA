#include "checkpoints.h"

uint8_t checksum_c(void* array, uint32_t n){
    data_t* data = (data_t*) array;

    for (uint32_t i=0; i<n ;i++){
        for(uint32_t j=0; j<8; j++){
            uint32_t t = ((uint32_t) data[i].a[j] + (uint32_t) data[i].b[j])*8;
            if (t != data[i].c[j])
                return 0;
        }
    }
    return 1;
}
