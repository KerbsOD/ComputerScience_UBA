#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "ej1.h"

int main (void){
	
  list_t* list=listNew();
  
  pago_t p1;
  p1.monto=24;
  p1.cobrador="susan";
  p1.pagador="a";
  p1.aprobado=1;

  pago_t p2;
  p2.monto=10;
  p2.cobrador="susan";
  p2.pagador="b";
  p2.aprobado=1;

  pago_t p3;
  p3.monto=10;
  p3.cobrador="susan";
  p3.pagador="c";
  p3.aprobado=1;

  pago_t p4;
  p4.monto=5;
  p4.cobrador="susan";
  p4.pagador="d";
  p4.aprobado=1;

  pago_t p5;
  p5.monto=50;
  p5.cobrador="susan";
  p5.pagador="e";
  p5.aprobado=1;


  pago_t p6;
  p6.monto=50;
  p6.cobrador="susan";
  p6.pagador="f";
  p6.aprobado=1;


  pago_t p7;
  p7.monto=5;
  p7.cobrador="susan";
  p7.pagador="g";
  p7.aprobado=1;

  pago_t p8;
  p8.monto=25;
  p8.cobrador="susan";
  p8.pagador="h";
  p8.aprobado=1;

  pago_t p9;
  p9.monto=25;
  p9.cobrador="susan";
  p9.pagador="i";
  p9.aprobado=1;

  pago_t p10;
  p10.monto=25;
  p10.cobrador="susan";
  p10.pagador="j";
  p10.aprobado=1;


  listAddLast(list,&p1);
  listAddLast(list,&p2);
  listAddLast(list,&p3);
  listAddLast(list,&p4);
  listAddLast(list,&p5);
  listAddLast(list,&p6);
  listAddLast(list,&p7);
  listAddLast(list,&p8);
  listAddLast(list,&p9);
  listAddLast(list,&p10);
  
  // Acá pueden probar su código
  char* nombre = "susan";
  pagoSplitted_t* split = split_pagos_usuario_asm(list, nombre);

  printf("Aprobados: %d\n", split->cant_aprobados);
  printf("Rechazados: %d\n", split->cant_rechazados);
  for (int i = 0; i < split->cant_aprobados; i++) {
    printf("Pagador del aprobado: %s\n",  split->aprobados[i]->pagador);
  }
  for (int i = 0; i < split->cant_rechazados; i++) {
    printf("Pagador del rechazado: %s\n", split->rechazados[i]->pagador);
  }

	return 0;    
}


