#include "../baldosasDelPiso.h"
#include "gtest/gtest.h"

TEST(Baldosas, MyNDivisiblesPorB) {
    // setup
    int M = 3, N = 9, B = 3;
    //exercise
    int result = baldosasDelPiso(M, N, B);
    // check
    EXPECT_TRUE(result == 3);
}

TEST(Baldosas, MDivisiblesPorB) {
    // setup
    int M = 4, N = 7, B = 2;
    //exercise
    int result = baldosasDelPiso(M, N, B);
    // check
    EXPECT_TRUE(result == 8);
}

TEST(Baldosas, NDivisiblesPorB) {
    // setup
    int M = 4, N = 9, B = 3;
    //exercise
    int result = baldosasDelPiso(M, N, B);
    // check
    EXPECT_TRUE(result == 6);
}

TEST(Baldosas, NingunoDivideB) {
    // setup
    int M = 4, N = 8, B = 3;
    //exercise
    int result = baldosasDelPiso(M, N, B);
    // check
    EXPECT_TRUE(result == 6);
}
