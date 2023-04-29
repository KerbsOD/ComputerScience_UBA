// Tests para la función jugarPlus.
// Ver el archovo README.md para ayuda

#include "../ejercicios.h"
#include "../auxiliares.h"
#include "gtest/gtest.h"

using namespace std;

bool mismosElementos(jugadas s, jugadas t){

    int contar = 0;

    for(int i = 0; i < s.size(); i++){
        for(int j = 0; j < t.size(); j++){
            if(s[i] == t[j]){
                contar++;
            }
        }
    }

    bool iguales = s.size() == t.size();

    return (contar == s.size() && iguales);
}

TEST(jugarPlusTEST, EsquinaIzquierda) {
    tablero t = {{0, 0, 0},
                 {0, 0, 0},
                 {0, 1, 1}};
    jugadas j = {
    };

    pos p = {0, 0};

    banderitas b = {};

    jugarPlus(t, b, p, j);

    jugadas j1 = {
            {{0,0}, 0},
            {{0,1}, 0},
            {{0,2}, 0},
            {{1,0}, 1},
            {{1,1}, 2},
            {{1,2}, 2}
    };


    ASSERT_TRUE(mismosElementos(j, j1));
}

TEST(jugarPlusTEST, casillasJugadasNoSeAdivinan) {
    tablero t = {{0, 0, 0},
                 {0, 0, 0},
                 {0, 1, 1}};
    jugadas j = { {{2,0}, 1},
                  {{1,0}, 1},
                  {{1,1}, 2},
                  {{1,2}, 2},
    };

    pos p = {0, 0};

    banderitas b = {};

    jugarPlus(t, b, p, j);

    jugadas j1 = {
            {{2,0}, 1},
            {{1,0}, 1},
            {{1,1}, 2},
            {{1,2}, 2},
            {{0,1}, 0},
            {{0,2}, 0},
            {{0,0}, 0},

    };


    ASSERT_TRUE(mismosElementos(j, j1));
}

TEST(jugarPlusTEST, lateralDerecho) {
    tablero t = {{1, 0, 0},
                 {1, 0, 0},
                 {1, 0, 0}};
    jugadas j = {};

    pos p = {1, 2};

    banderitas b = {};

    jugarPlus(t, b, p, j);

    jugadas j1 = { {{0,1}, 2},
                   {{0,2}, 0},
                   {{1,1}, 3},
                   {{1,2}, 0},
                   {{2,1}, 2},
                   {{2,2}, 0}
                   };

    ASSERT_TRUE(mismosElementos(j, j1));
}

TEST(jugarPlusTEST, lateralIzquierda) {
    tablero t = {{0, 0, 1},
                 {0, 0, 1},
                 {0, 0, 1}};
    jugadas j = {};

    pos p = {1, 0};

    banderitas b = {};

    jugarPlus(t, b, p, j);

    jugadas j1 = {{{0,0}, 0},
                  {{0,1}, 2},
                  {{1,0}, 0},
                  {{1,1}, 3},
                  {{2,0}, 0},
                  {{2,1}, 2},
                  };

    ASSERT_TRUE(mismosElementos(j, j1));
}

TEST(jugarPlusTEST, jugarUnaPosicionQueTengaMinasAdyacentes) {
    tablero t = {{1, 1, 0},
                 {0, 1, 0},
                 {0, 0, 0}};
    jugadas j = {
    };

    pos p = {2, 2};

    banderitas b = {};

    jugarPlus(t, b, p, j);

    jugadas j1 = {
            {{2,2}, 1},
    };

    ASSERT_TRUE(mismosElementos(j, j1));
}

TEST(jugarPlusTEST, EsquinaDerecha) {
    tablero t = {{1, 1, 0},
                 {0, 0, 0},
                 {0, 0, 0}};
    jugadas j = {};

    pos p = {2, 2};

    banderitas b = {};

    jugarPlus(t, b, p, j);

    jugadas j1 = {
            {{2,2}, 0},
            {{2,1}, 0},
            {{2,0}, 0},
            {{1,0}, 2},
            {{1,1}, 2},
            {{1,2}, 1}
    };

    ASSERT_TRUE(mismosElementos(j, j1));
}

TEST(jugarPlusTEST, jugarUnaPosicionPerdidaPierdeYNoRevelaNada) {
    tablero t = {{1, 1, 0},
                 {0, 0, 0},
                 {0, 0, 1}};
    jugadas j = {
    };

    pos p = {2, 2};

    banderitas b = {};

    jugarPlus(t, b, p, j);

    jugadas j1 = {
            {{2,2}, 0},
    };

    ASSERT_EQ(j, j1);
}

TEST(jugarPlusTEST, tenerBanderitaEvitaDespejarCasilla) {
    tablero t = {{1, 1, 0},
                 {0, 0, 0},
                 {0, 0, 0}};
    jugadas j = {};

    pos p = {2, 2};

    banderitas b = {{1,1}};

    jugarPlus(t, b, p, j);

    jugadas j1 = {
            {{2,2}, 0},
            {{2,1}, 0},
            {{2,0}, 0},
            {{1,0}, 2},
            {{1,2}, 1}
    };

    ASSERT_TRUE(mismosElementos(j, j1));
}
