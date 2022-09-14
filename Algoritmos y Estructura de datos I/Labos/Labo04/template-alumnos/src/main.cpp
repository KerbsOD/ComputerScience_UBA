#include "generador.h"
#include "vectores.h"
#include<iostream>
using namespace std;

int main() {
    // funcion para generar automaticamente los archivos numericos
    // generarDatosLaboratorio(); // descomentar para crear automaticamente los archivos necesarios en la parte de entrada-salida. Una vez creados, se puede volver a comentar
    //holaModuloVectores(); // función definida en vectores.cpp
    vector<int> v = {2,4,456,8};
    vector<int> v2 = factoresPrimos(1250);

    // Imprimir Vectores
    mostrarVector(v2);
    return 0;
}
