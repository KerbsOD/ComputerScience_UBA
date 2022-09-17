#include "generador.h"
#include "vectores.h"
#include<iostream>
using namespace std;

int main() {
    vector<int> res = interseccion("archivos/conjunto_A.in", "archivos/conjunto_B.in");
    mostrarVector(res);
}
