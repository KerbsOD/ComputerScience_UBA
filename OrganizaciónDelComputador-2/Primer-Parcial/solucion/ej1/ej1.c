#include "ej1.h"

list_t* listNew(){
  list_t* l = (list_t*) malloc(sizeof(list_t));
  l->first=NULL;
  l->last=NULL;
  return l;
}

void listAddLast(list_t* pList, pago_t* data){
    listElem_t* new_elem= (listElem_t*) malloc(sizeof(listElem_t));
    new_elem->data=data;
    new_elem->next=NULL;
    new_elem->prev=NULL;
    if(pList->first==NULL){
        pList->first=new_elem;
        pList->last=new_elem;
    } else {
        pList->last->next=new_elem;
        new_elem->prev=pList->last;
        pList->last=new_elem;
    }
}


void listDelete(list_t* pList){
    listElem_t* actual= (pList->first);
    listElem_t* next;
    while(actual != NULL){
        next=actual->next;
        free(actual);
        actual=next;
    }
    free(pList);
}

uint8_t contar_pagos_aprobados(list_t* pList, char* usuario){
    listElem_t* first = pList->first;
    uint8_t contador  = 0;

    while (first != NULL) {
        if (strcmp(first->data->cobrador, usuario) == 0) {
            if (first->data->aprobado != 0) {
                contador++;
            }
        }
        first = first->next;
    }

    return contador;
}

uint8_t contar_pagos_rechazados(list_t* pList, char* usuario){
    listElem_t* first = pList->first;
    uint8_t contador  = 0;

    while (first != NULL) {
        if (strcmp(first->data->cobrador, usuario) == 0) {
            if (first->data->aprobado == 0) {
                contador++;
            }
        }
        first = first->next;
    }

    return contador;
}

pagoSplitted_t* split_pagos_usuario(list_t* pList, char* usuario){
    uint8_t cant_aprobados  = contar_pagos_aprobados(pList, usuario);
    uint8_t cant_rechazados = contar_pagos_rechazados(pList, usuario);

    pago_t** aprobados  = malloc(sizeof(pago_t*)*cant_aprobados);
    pago_t** rechazados = malloc(sizeof(pago_t*)*cant_rechazados);

    pago_t** punteroAprobados  = aprobados;
    pago_t** punteroRechazados = rechazados;    

    listElem_t* first = pList->first;

    while (first != NULL) {
        if (strcmp(first->data->cobrador, usuario) == 0) {
            if (first->data->aprobado != 0) {
                *aprobados = first->data;
                aprobados++;
            } else {
                *rechazados = first->data;
                rechazados++;
            }
        }
        first = first->next;
    }

    pagoSplitted_t* pagos  = malloc(sizeof(pagoSplitted_t));
    pagos->cant_aprobados  = cant_aprobados;
    pagos->cant_rechazados = cant_rechazados;
    pagos->aprobados       = punteroAprobados;
    pagos->rechazados      = punteroRechazados;

    return pagos;
}