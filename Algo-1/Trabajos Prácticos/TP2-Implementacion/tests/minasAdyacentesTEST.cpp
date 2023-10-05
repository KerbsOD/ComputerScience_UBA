// Tests para la función minasAdyacentes.
// Ver el archivo README.md para ayuda

#include "../ejercicios.h"
#include "../auxiliares.h"
#include "../definiciones.h"
#include "gtest/gtest.h"

using namespace std;

TEST(minasAdyacentesTEST, bordeIzquierdo){
    tablero t = {{1,0,0},
                 {1,0,0},
                 {0,0,0}};
    pos p;
    p.first = 2;
    p.second = 0;

    int minas = minasAdyacentes(t, p);
    ASSERT_TRUE(minas == 1);
}

TEST(minasAdyacentesTEST, unElemento){
    tablero t = {{1}};
    pos p;
    p.first = 0;
    p.second = 0;

    int minas = minasAdyacentes(t, p);
    ASSERT_TRUE(minas == 0);
}

TEST(minasAdyacentesTEST, bordeDerecho){
    tablero t = {{1,0,0},
                 {1,1,0},
                 {0,0,0}};
    pos p;
    p.first = 2;
    p.second = 2;

    int minas = minasAdyacentes(t, p);
    ASSERT_TRUE(minas == 1);
}

TEST(minasAdyacentesTEST, sobreMina){
    tablero t = {{1,0,1},
                 {1,1,0},
                 {0,0,0}};
    pos p;
    p.first = 1;
    p.second = 1;

    int minas = minasAdyacentes(t, p);
    ASSERT_TRUE(minas == 3);
}

TEST(minasAdyacentesTEST, primeraPosicion){
    tablero t = {{1,0,1},
                 {1,1,0},
                 {0,0,0}};
    pos p;
    p.first = 0;
    p.second = 1;

    int minas = minasAdyacentes(t, p);
    ASSERT_TRUE(minas == 4);
}

TEST(minasAdyacentesTEST, ultimaPosicion){
    tablero t = {{1,0,1},
                 {1,1,0},
                 {0,0,0}};
    pos p;
    p.first = 2;
    p.second = 2;

    int minas = minasAdyacentes(t, p);
    ASSERT_TRUE(minas == 1);
}