// Tests para la función gano.
// Ver el archovo README.md para ayuda

#include "../ejercicios.h"
#include "../auxiliares.h"
#include "gtest/gtest.h"

using namespace std;


TEST(ganoTEST, gano) {
    tablero t = {{1, 1, 0},
                 {1, 0, 0},
                 {0, 0, 0}};
    jugadas j = {
            {{0, 2}, 1},
            {{1, 1}, 3},
            {{1, 2}, 1},
            {{2, 0}, 1},
            {{2, 1}, 1},
            {{2, 2}, 0},
    };

    ASSERT_TRUE(gano(t, j));
}

TEST(ganoTEST, todaviaNoGano) {
    tablero t = {{1, 1, 0},
                 {1, 0, 0},
                 {0, 0, 0}};
    jugadas j = {
            {{0, 2}, 1},
            {{1, 2}, 1},
            {{2, 2}, 1},
            {{1, 1}, 1},
            {{2, 0}, 1},
    };

    ASSERT_FALSE(gano(t, j));
}

TEST(ganoTEST, noGanoPorquePerdio) {
    tablero t = {{1, 1, 0},
                 {1, 0, 0},
                 {0, 0, 0}};
    jugadas j = {
            {{0, 2}, 1},
            {{1, 2}, 1},
            {{2, 2}, 1},
            {{1, 1}, 1},
            {{2, 0}, 1},
            {{2, 1}, 1},
            {{0, 0}, 1},
    };

    ASSERT_FALSE(gano(t, j));
}


