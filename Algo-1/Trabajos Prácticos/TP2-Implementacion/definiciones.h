//
// Este archivo contiene todas las definiciones de tipo que vamos a usar 
// en el TP.
//

#pragma once   // esta línea es para que el archivo se incluya una sola vez

#include <vector>

using namespace std;

typedef pair<int,int> pos;
typedef vector<vector<bool>> tablero;
typedef pair<pos, int> jugada;
typedef vector<jugada> jugadas;
typedef vector<pos> banderitas;

// CONSTANTES ÚTILES
#define cVACIA          false
#define cMINA           true
