#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>
#include <math.h>
#include <stdbool.h>
#include <unistd.h>
#define USE_ASM_IMPL 1

/* Payments */
typedef struct
{
    uint8_t monto;              // 1 byte
    uint8_t aprobado;           // 1 byte
    char *pagador;              // 8 bytes
    char *cobrador;             // 8 bytes
} pago_t;

typedef struct
{
    uint8_t cant_aprobados;     // 1 byte
    uint8_t cant_rechazados;    // 1 byte
    pago_t **aprobados;         // 8 bytes
    pago_t **rechazados;        // 8 bytes
} pagoSplitted_t;

/* List */

typedef struct s_listElem
{
    pago_t *data;               // 8 bytes
    struct s_listElem *next;    // 8 bytes
    struct s_listElem *prev;    // 8 bytes
} listElem_t;

typedef struct s_list
{
    struct s_listElem *first;   // 8 bytes
    struct s_listElem *last;    // 8 bytes
} list_t;

list_t *listNew();
void listAddLast(list_t *pList, pago_t *data);
void listDelete(list_t *pList);

uint8_t contar_pagos_aprobados(list_t *pList, char *usuario);
uint8_t contar_pagos_aprobados_asm(list_t *pList, char *usuario);

uint8_t contar_pagos_rechazados(list_t *pList, char *usuario);
uint8_t contar_pagos_rechazados_asm(list_t *pList, char *usuario);

pagoSplitted_t *split_pagos_usuario(list_t *pList, char *usuario);

pagoSplitted_t *split_pagos_usuario_asm(list_t *pList, char *usuario);
