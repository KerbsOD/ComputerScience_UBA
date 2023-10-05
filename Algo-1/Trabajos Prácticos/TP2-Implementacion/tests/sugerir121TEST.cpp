// Tests para la función sugerir121.
// Ver el archovo README.md para ayuda

#include "../ejercicios.h"
#include "../auxiliares.h"
#include "gtest/gtest.h"

using namespace std;

TEST(sugerir121TEST, hay121Horizontal) {
    tablero t = {{0, 0, 0},
                 {1, 0, 1},
                 {0, 0, 1}};
    jugadas j = { {{0,0}, 1},
                  {{0,1}, 2},
                  {{0,2}, 1}
    };

    pos p = {0, 0};

    banderitas b = {};

    sugerirAutomatico121(t, b, j, p);

    pos p1 = {1,1};

    ASSERT_EQ(p, p1);
}

TEST(sugerir121TEST, hay121Horizontal2) {
    tablero t = {{0, 0, 1},
                 {1, 0, 1},
                 {0, 0, 0}};
    jugadas j = { {{0,0}, 1},
                  {{0,1}, 2},
                  {{0,2}, 1}
    };

    pos p = {0, 0};

    banderitas b = {};

    sugerirAutomatico121(t, b, j, p);

    pos p1 = {1,1};

    ASSERT_EQ(p, p1);
}

TEST(sugerir121TEST, hay121Vertical) {
    tablero t = {{0, 1, 0},
                 {0, 0, 1},
                 {0, 1, 1}};
    jugadas j = { {{0,0}, 1},
                  {{1,0}, 2},
                  {{2,0}, 1}
    };

    pos p = {0, 0};

    banderitas b = {};

    sugerirAutomatico121(t, b, j, p);

    pos p1 = {1,1};

    ASSERT_EQ(p, p1);
}

TEST(sugerir121TEST, hay121Vertical2) {
    tablero t = {{1, 0, 0},
                 {0, 0, 0},
                 {1, 0, 0}};

    jugadas j = { {{0,1}, 1},
                  {{1,1}, 2},
                  {{2,1}, 1}
    };

    pos p = {1, 2};

    banderitas b = {{1,2}};

    sugerirAutomatico121(t, b, j, p);

    pos p1 = {1,0};

    ASSERT_EQ(p, p1);
}

TEST(sugerir121TEST, noHay121) {
    tablero t = {{0, 0, 0},
                 {1, 1, 1},
                 {0, 0, 1}};

    jugadas j = {{{0, 0}, 2},
                 {{0, 1}, 3},
                 {{0, 2}, 2}};

    pos p = {0, 0};

    banderitas b = {};

    bool hay = sugerirAutomatico121(t, b, j, p);

    ASSERT_FALSE(hay);
}

TEST(sugerir121TEST, jugadasVacias) {
    tablero t = {{0, 0, 0},
                 {1, 1, 1},
                 {0, 0, 1}};

    jugadas j = {};

    pos p = {0, 0};

    banderitas b = {};

    bool hay = sugerirAutomatico121(t, b, j, p);

    ASSERT_FALSE(hay);
}

TEST(sugerir121TEST, hay121PeroEstaEnBanderitas) {
    tablero t = {{0, 0, 0},
                 {1, 0, 1},
                 {0, 0, 1}};

    jugadas j = {{{0, 0}, 1},
                 {{0, 1}, 2},
                 {{0, 2}, 1}};

    pos p = {0, 0};

    banderitas b = {{1,1}};

    bool hay = sugerirAutomatico121(t, b, j, p);

    ASSERT_FALSE(hay);
}

TEST(sugerir121TEST, unElemento) {
    tablero t = {{0}};

    jugadas j = {};

    pos p = {0, 0};

    banderitas b = {};

    bool hay = sugerirAutomatico121(t, b, j, p);

    ASSERT_FALSE(hay);
}


TEST(sugerir121TEST, esPosicionLibrePeroNoEs121) {
    tablero t = {{0, 0, 0},
                 {0, 0, 0},
                 {1, 0, 1}};

    jugadas j = {{{0, 0}, 1},
                 {{0, 1}, 2},
                 {{0, 2}, 1}};

    pos p = {0, 0};

    banderitas b = {{1,1}};

    bool hay = sugerirAutomatico121(t, b, j, p);

    ASSERT_FALSE(hay);
}
