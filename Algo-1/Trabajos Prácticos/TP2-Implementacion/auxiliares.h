
//
// Este archivo contiene las declaraciones de las funciones auxiliares
// que ustedes necesiten implementar. Tienen que coincidir con el código
// de esas mismas funciones, que estará en auxiliares.cpp
//

#pragma once   // esta línea es para que el archivo se incluya una sola vez

#include "definiciones.h"

bool esAdyacenteValida(int p0, int p1, int i, int j, tablero& t);
bool coordenadaValida(int p, int x, tablero& t);
bool esBanderita (banderitas b, pos p);
bool contienePosicionBanderita(pos p, banderitas& b);
void quitarPosicion(pos p, banderitas& b);
bool tieneUnaMina(tablero& t, pos p);
bool perteneceAJugadas(jugada jugada, jugadas& j);
pos newPos(int x, int y);
bool perteneceACandidatos(pos nuevoCandidato, vector<pos> candidatos);
bool hayPosicionSugerible(jugadas& j, banderitas& b, tablero& t, pos& p);
bool esPosicionSinJugarYSinBanderita(pos p, jugadas& j, banderitas& b, tablero& t);
bool posicionValida(pos p, tablero& t);
bool esAdyacente121(pos p, jugadas& j);
bool es121Horizontal(pos p, jugadas& j);
bool es121Vertical(pos p, jugadas& j);
