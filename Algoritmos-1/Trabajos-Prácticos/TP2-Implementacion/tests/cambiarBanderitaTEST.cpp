// Tests para la función cambiarBanderita.
// Ver el archovo README.md para ayuda


#include "../ejercicios.h"
#include "../auxiliares.h"
#include "gtest/gtest.h"

using namespace std;

TEST(cambiarBanderitaTEST, sacarBanderita){
    tablero t = {{1,0,0},
                 {1,0,0},
                 {0,0,0}};
    jugadas j = {{{2,0},1},{{1,2},0}};
    banderitas b = {{1,0}, {0,0}, {2, 2}};
    pos p;
    p.first = 1;
    p.second = 0;
    banderitas b1 = {{0,0}, {2, 2}};
    cambiarBanderita(t,j,p,b);
    ASSERT_EQ(b1, b);
}

TEST(cambiarBanderitaTEST, plantarBanderita){
    tablero t = {{1,0,0},
                 {1,0,0},
                 {0,0,0}};
    jugadas j = {{{2,0},1},{{1,2},0}};
    banderitas b = {{1,0}, {0,0}, {2, 2}};
    pos p;
    p.first = 1;
    p.second = 1;
    banderitas b1 = {{1,0}, {0,0}, {2, 2}, {1, 1}};
    cambiarBanderita(t,j,p,b);
    ASSERT_EQ(b1, b);
}





