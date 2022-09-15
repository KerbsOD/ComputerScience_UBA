#include "generador.h"
#include "vectores.h"
#include<iostream>
using namespace std;

int main() {
    //vector<int> v = {1,2,3,4,54,63};
    //guardarVector(v, "guardarVector.txt");

    vector<int> v = leerVector("elementoMedio.in");
    cout << elementoMedio(v);

    return 0;
}
