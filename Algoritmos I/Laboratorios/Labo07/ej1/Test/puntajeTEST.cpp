#include "gtest/gtest.h"
#include "../puntaje.h"


TEST(Puntaje, PuntajeMenorA10) {
    // setup
    int n = 8;
    //exercise
    int result = puntaje(n);
    // check
    EXPECT_TRUE(result == 6);
}

TEST(Puntaje, PuntajeMayorA10) {
    // setup
    int n = 11;
    //exercise
    int result = puntaje(n);
    // check
    EXPECT_TRUE(result == 1);
}

TEST(Puntaje, PuntajeMenorA10YMultiploDe3) {
    // setup
    int n = 9;
    //exercise
    int result = puntaje(n);
    // check
    EXPECT_TRUE(result == 28);
}

TEST(Puntaje, PuntajeMayorA10YMultiploDe3) {
    // setup
    int n = 12;
    //exercise
    int result = puntaje(n);
    // check
    EXPECT_TRUE(result == 22);
}
