// Tests para la función perdio.
// Ver el archovo README.md para ayuda

#include "../ejercicios.h"
#include "../auxiliares.h"
#include "gtest/gtest.h"

using namespace std;

TEST(perdioTEST, perdio){
    tablero t = {{1,0,0},
                 {1,0,0},
                 {0,0,0}};
    jugadas j = {{{0,0},1}};

    ASSERT_TRUE(perdio(t, j));
}

TEST(perdioTEST, noPerdio){
    tablero t = {{1,0,0},
                 {1,0,0},
                 {0,0,0}};
    jugadas j = {{{0,2},0}};

    ASSERT_FALSE(perdio(t, j));
}


TEST(perdioTEST, noPerdioPorNoJugar){
    tablero t = {{1,0,0},
                 {1,0,0},
                 {0,0,0}};
    jugadas j = {};

    ASSERT_FALSE(perdio(t, j));
}

TEST(perdioTEST, gano){
    tablero t = {{1,0,0},
                 {1,0,0},
                 {0,0,0}};

    jugadas j = {{{0,1},2},
                 {{0,2},0},
                 {{1,1},2},
                 {{1,2},0},
                 {{2,0},1},
                 {{2,1},0},
                 {{2,1},0}};

    ASSERT_FALSE(perdio(t, j));
}