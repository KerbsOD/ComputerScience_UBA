#include <iostream>
#include <vector>
#include "fstream"

using namespace std;

void holaModuloVectores();

//Ejercicio
bool divide(vector<int> v, int a);
// Dados un vector v y un int a, decide si a divide a todos los numeros de v.

//Ejercicio
int mayor(vector<int> v);
// Dado un vector v, devuelve el valor maximo encontrado.

//Ejercicio
vector<int> reverso(vector<int> v);
// Dado un vector v, devuelve el reverso.

//Ejercicio
vector<int> rotar(vector<int> v, int k);
// Dado un vector v y un entero k, rotar k posiciones los elementos de v.
// [1,2,3,4,5,6] rotado 2, deberia dar [3,4,5,6,1,2].

//Ejercicio
vector<int> factoresPrimos(int n);
// Dado un entero devuelve un vector con los factores primos del mismo

//Ejercicio
void mostrarVector(vector<int> v);
// Dado un vector de enteros muestra por la salida estándar, el vector
// Ejemplo: si el vector es <1, 2, 5, 65> se debe mostrar en pantalla [1, 2, 5, 65]

// Y aca van todos los otros headers de los ejercicios del laboratorio

vector<int> leerVector(string nombreArchivo);
void guardarVector(vector<int> v, string nombreArchivo);
int elementoMedio(vector<int>v);
void cantApariciones(string nombreArchivo);
bool pertenece(int x, vector<int> v);
void cantidadAparicionesDePalabra(string nombreArchivo, string palabra);
vector<string> leerVectorString(string nombreArchivo);
void promedio(string nombreArchivoIn1, string nombreArchivoIn2, string nombreArchivoOut);
void mostrarVectorFloat(vector<float> v);
void guardarVectorF(vector<float> v, string nombreArchivo);
void ordenarSecuencias(string nombreArchivoIn1, string nombreArchivoIn2, string nombreArchivoOut);
vector<int> interseccion(string Archivo1, string Archivo2);