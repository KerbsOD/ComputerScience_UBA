#include <iostream>
#include "cases.h"


using namespace std;

int main()
{
    int exitos = 0;
    int total = 10;
    
    
    cout << endl << "=====Test 01=====" << endl;
    exitos += test01_estaOrdenado() ? 1 : 0;
    cout << "Exitos acumulados: " << exitos << endl; 
    cout << endl << "=====Test 02=====" << endl;
    exitos += test02_esPrimo() ? 1 : 0;
    cout << "Exitos acumulados: " << exitos << endl; 
    cout << endl << "=====Test 03=====" << endl;
    exitos += test03_pertenece() ? 1 : 0;
    cout << "Exitos acumulados: " << exitos << endl; 
    cout << endl << "=====Test 04=====" << endl;
    exitos += test04_desvioEstandar() ? 1 : 0;
    cout << "Exitos acumulados: " << exitos << endl; 
    cout << endl << "=====Test 05=====" << endl;
    exitos += test05_fibonacci() ? 1 : 0;
    cout << "Exitos acumulados: " << exitos << endl; 
    cout << endl << "=====Test 06=====" << endl;
    exitos += test06_maximoComunDivisor() ? 1 : 0;
    cout << "Exitos acumulados: " << exitos << endl; 
    cout << endl << "=====Test 07=====" << endl;
    exitos += test07_sumaDoble() ? 1 : 0;
    cout << "Exitos acumulados: " << exitos << endl; 
    cout << endl << "=====Test 08=====" << endl;
    exitos += test08_cantPalabras() ? 1 : 0;
    cout << "Exitos acumulados: " << exitos << endl; 
    cout << endl << "=====Test 09=====" << endl;
    exitos += test09_valorMedio() ? 1 : 0;
    cout << "Exitos acumulados: " << exitos << endl; 
    cout << endl << "=====Test 10=====" << endl;
    exitos += test10_fraccion() ? 1 : 0;

    cout << "# Ejercicios correctos:" << exitos << endl;
    cout << "# Ejercicios incorrectos: " << total - exitos << endl;
}


