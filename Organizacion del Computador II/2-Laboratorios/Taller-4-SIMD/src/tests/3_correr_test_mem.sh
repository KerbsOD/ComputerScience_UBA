#!/bin/bash

# Este script ejecuta su implementacion y chequea memoria

DATADIR=./data
TESTINDIR=$DATADIR/imagenes_a_testear
CATEDRADIR=$DATADIR/resultados_catedra
ALUMNOSDIR=$DATADIR/resultados_nuestros

IMAGENES=(NoCountryForOldMen.bmp Wargames.bmp)
SIZESMEM=(128x75 64x37 32x18 32x18)

SIMDCAT=./simdcatedra
SIMDALU=../build/simd

# Colores
ROJO="\e[31m"
VERDE="\e[32m"
AZUL="\e[94m"
DEFAULT="\e[39m"

img0=${IMAGENES[0]}
img0=${img0%%.*}
img1=${IMAGENES[1]}
img1=${img1%%.*}

VALGRINDFLAGS="--error-exitcode=1 --leak-check=full -q"

#$1 : Programa Ejecutable
#$2 : Filtro
#$3 : Implementacion Ejecutar
#$4 : Archivos de Entrada
#$5 : Parametros del filtro
function run_test {
    echo -e "dale con... $VERDE $2 $DEFAULT"
    valgrind $VALGRINDFLAGS $1 $2 -i $3 -o $ALUMNOSDIR $4 $5
    if [ $? -ne 0 ]; then
      echo -e "$ROJO ERROR DE MEMORIA";
      echo -e "$AZUL Corregir errores en $2. Ver de probar la imagen $3, que se rompe.";
      echo -e "$AZUL Correr nuevamente $DEFAULT valgrind --leak-check=full $1 $2 -i $3 -o $ALUMNOSDIR $4 $5";
      ret=-1; return;
    fi
    ret=0; return;
}

for imp in asm; do

  # Pintar
  for s in ${SIZESMEM[*]}; do
    run_test "$SIMDALU" "Pintar" "$imp" "$TESTINDIR/$img1.$s.bmp" ""
    if [ $ret -ne 0 ]; then exit -1; fi
  done

  # temperature
  for s in ${SIZESMEM[*]}; do
    run_test "$SIMDALU" "temperature" "$imp" "$TESTINDIR/$img1.$s.bmp" ""
    if [ $ret -ne 0 ]; then exit -1; fi
  done
  
done

echo ""
echo -e "$VERDE Felicitaciones los test de MEMORIA finalizaron correctamente $DEFAULT"

