#include "../electores.h"
#include "gtest/gtest.h"

TEST(Electoral, FechasInvalidas) {
    // setup
    int Year = 1999, Month = 13, Day = 24;
    //exercise
    int result = validarVotante(Year, Month, Day);
    // check
    EXPECT_TRUE(result == 4);
}

TEST(Electoral, VotoOpcional) {
    // setup
    int Year = 2005, Month = 11, Day = 12;
    //exercise
    int result = validarVotante(Year, Month, Day);
    // check
    EXPECT_TRUE(result == 1);
}

TEST(Electoral, NoVota) {
    // setup
    int Year = 2007, Month = 11, Day = 12;
    //exercise
    int result = validarVotante(Year, Month, Day);
    // check
    EXPECT_TRUE(result == 0);
}

TEST(Electoral, VotoObligatorio) {
    // setup
    int Year = 2001, Month = 12, Day = 18;
    //exercise
    int result = validarVotante(Year, Month, Day);
    // check
    EXPECT_TRUE(result == 2);
}

TEST(Electoral, VotoOpcionalMayor) {
    // setup
    int Year = 1950, Month = 11, Day = 12;
    //exercise
    int result = validarVotante(Year, Month, Day);
    // check
    EXPECT_TRUE(result == 3);
}
