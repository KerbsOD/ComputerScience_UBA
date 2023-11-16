/* ** por compatibilidad se omiten tildes **
================================================================================
 TALLER System Programming - ORGANIZACION DE COMPUTADOR II - FCEN
================================================================================

  Definicion de la tabla de descriptores globales
*/

#include "gdt.h"

/* Aca se inicializa un arreglo de forma estatica
GDT_COUNT es la cantidad de líneas de la GDT y esta definido en defines.h */

gdt_entry_t gdt[GDT_COUNT] = {
    /* Descriptor nulo*/
    /* Offset = 0x00 */
    [GDT_IDX_NULL_DESC] =
        {
            // El descriptor nulo es el primero que debemos definir siempre
            // Cada campo del struct se matchea con el formato que figura en el manual de intel
            // Es una entrada en la GDT.
            .limit_15_0 = 0x0000,
            .base_15_0 = 0x0000,
            .base_23_16 = 0x00,
            .type = 0x0,
            .s = 0x00,
            .dpl = 0x00,
            .p = 0x00,
            .limit_19_16 = 0x00,
            .avl = 0x0,
            .l = 0x0,
            .db = 0x0,
            .g = 0x00,
            .base_31_24 = 0x00,
        },
    /* Completar la GDT: 
      Es conveniente completar antes las constantes definidas en defines.h y valerse
      de las mismas para definir los descriptores acá. Traten en lo posible de usar las 
      macros allí definidas.
      Tomen el descriptor nulo como ejemplo y definan el resto.
     */
    [GDT_IDX_CODE_0] = 
    {
        .limit_15_0  = GDT_LIMIT_LOW(GDT_LIMIT_4KIB(FLAT_SEGM_SIZE)),
        .base_15_0   = GDT_BASE_LOW(0),
        .base_23_16  = GDT_BASE_MID(0),
        .type        = DESC_TYPE_EXECUTE_READ,
        .s           = DESC_CODE_DATA,
        .dpl         = 0x00,
        .p           = 0x01,
        .limit_19_16 = GDT_LIMIT_HIGH(GDT_LIMIT_4KIB(FLAT_SEGM_SIZE)),
        .avl         = 0x1,
        .l           = 0x0,
        .db          = 0x1,
        .g           = 0x1,
        .base_31_24  = GDT_BASE_HIGH(0),
    },
    [GDT_IDX_CODE_3] = 
    {
        .limit_15_0  = GDT_LIMIT_LOW(GDT_LIMIT_4KIB(FLAT_SEGM_SIZE)),
        .base_15_0   = GDT_BASE_LOW(0),
        .base_23_16  = GDT_BASE_MID(0),
        .type        = DESC_TYPE_EXECUTE_READ,
        .s           = DESC_CODE_DATA,
        .dpl         = 0x3,
        .p           = 0x01,
        .limit_19_16 = GDT_LIMIT_HIGH(GDT_LIMIT_4KIB(FLAT_SEGM_SIZE)),
        .avl         = 0x1,
        .l           = 0x0,
        .db          = 0x1,
        .g           = 0x1,
        .base_31_24  = GDT_BASE_HIGH(0),
    },
    [GDT_IDX_DATA_0] = 
    {
        .limit_15_0  = GDT_LIMIT_LOW(GDT_LIMIT_4KIB(FLAT_SEGM_SIZE)),
        .base_15_0   = GDT_BASE_LOW(0),
        .base_23_16  = GDT_BASE_MID(0),
        .type        = DESC_TYPE_READ_WRITE,
        .s           = DESC_CODE_DATA,
        .dpl         = 0x00,
        .p           = 0x01,
        .limit_19_16 = GDT_LIMIT_HIGH(GDT_LIMIT_4KIB(FLAT_SEGM_SIZE)),
        .avl         = 0x1,
        .l           = 0x0,
        .db          = 0x1,
        .g           = 0x1,
        .base_31_24  = GDT_BASE_HIGH(0),
    },
    [GDT_IDX_DATA_3] = 
    {
        .limit_15_0  = GDT_LIMIT_LOW(GDT_LIMIT_4KIB(FLAT_SEGM_SIZE)),
        .base_15_0   = GDT_BASE_LOW(0),
        .base_23_16  = GDT_BASE_MID(0),
        .type        = DESC_TYPE_READ_WRITE,
        .s           = DESC_CODE_DATA,
        .dpl         = 0x3,
        .p           = 0x01,
        .limit_19_16 = GDT_LIMIT_HIGH(GDT_LIMIT_4KIB(FLAT_SEGM_SIZE)),
        .avl         = 0x1,
        .l           = 0x0,
        .db          = 0x1,
        .g           = 0x1,
        .base_31_24  = GDT_BASE_HIGH(0),
    },
    [GDT_IDX_VIDEO] =
    {           
        .limit_15_0 = GDT_LIMIT_LOW(GDT_LIMIT_BYTES(VIDEO_SEGM_SIZE)),
        .base_15_0 = GDT_BASE_LOW(VIDEO),
        .base_23_16 = GDT_BASE_MID(VIDEO),
        .type = DESC_TYPE_READ_WRITE,
        .s = DESC_CODE_DATA,
        .dpl = 0x3,
        .p = 0x1,
        .limit_19_16 = GDT_LIMIT_HIGH(GDT_LIMIT_BYTES(VIDEO_SEGM_SIZE)),
        .avl = 0x0,
        .l = 0x0,
        .db = 0x1,
        .g = 0x0,
        .base_31_24 = GDT_BASE_HIGH(VIDEO),
    }

    
};

// Aca hay una inicializacion estatica de una structura que tiene su primer componente el tamano 
// y en la segunda, la direccion de memoria de la GDT. Observen la notacion que usa. 
gdt_descriptor_t GDT_DESC = {sizeof(gdt) - 1, (uint32_t)&gdt};
