#include "gtest-1.8.1/gtest.h"
#include "../src/Libreta.h"
#include "../src/Truco.h"
#include <map>
#include <cmath>

using namespace std;

// Ejercicio 4
TEST(Aritmetica, suma) {
    int quince = 15;
    int siete  = 7;
    EXPECT_EQ(quince+siete, 22);
}

// Ejercicio 5
TEST(Aritmetica, potencia) {
    float p = pow(10, 2);
    EXPECT_EQ(p, 100);
}

TEST(Aritmetica, potencia_general) {
    for(int i = -5; i <=5; i++) {
        EXPECT_EQ(i*i, pow(i,2));
    }
}

TEST(Diccionario, obtener) {
    map<int, int> m;
    m[5] = 4;
    EXPECT_EQ(m[5], 4);
}

TEST(Diccionario, definir) {
    map<int, int> m;
    if(m.find(4) == m.end()) {
        m[4] = 5;
    }

    if(m.find(4) != m.end()) {
        EXPECT_EQ(m[4], 5);
    }
}

TEST(Truco, inicio) {
    Truco t;
    bool j1 = t.puntaje_j1() == 0;
    bool j2 = t.puntaje_j2() == 0;
    EXPECT_TRUE(j1 == j2);
}

TEST(Truco, buenas) {
    Truco t;
    EXPECT_FALSE(t.buenas(1));
    for(int i = 0; i < 15; i++) {
        t.sumar_punto(1);
    }
    EXPECT_FALSE(t.buenas(1));
    t.sumar_punto(1);
    EXPECT_TRUE(t.buenas(1));

    t.sumar_punto(1);
    t.sumar_punto(1);

    EXPECT_TRUE(t.buenas(1));
}