#include "gtest/gtest.h"
#include "../llenarTaxis.h"


//---------------LLENAR TAXIS 1---------------//

TEST(LlenarTaxis, T1_MismaCantidadDeGrupos) {
    // setup
    int g1 = 1, g2 = 1, g3 = 1;
    //exercise
    int result = llenarTaxis1(g1, g2, g3);
    // check
    EXPECT_TRUE(result == 2);
}

TEST(LlenarTaxis, T1_Grupo2Par) {
    // setup
    int g1 = 1, g2 = 2, g3 = 1;
    //exercise
    int result = llenarTaxis1(g1, g2, g3);
    // check
    EXPECT_TRUE(result == 2);
}

TEST(LlenarTaxis, T1_Grupo2ImparA) {
    // setup
    int g1 = 1, g2 = 1, g3 = 3;
    //exercise
    int result = llenarTaxis1(g1, g2, g3);
    // check
    EXPECT_TRUE(result == 4);
}

TEST(LlenarTaxis, T1_Grupo2ImparB) {
    // setup
    int g1 = 1, g2 = 1, g3 = 1;
    //exercise
    int result = llenarTaxis1(g1, g2, g3);
    // check
    EXPECT_TRUE(result == 2);
}


//---------------LLENAR TAXIS 2---------------//

TEST(LlenarTaxis, T2_MismaCantidadDeGrupos) {
    // setup
    int g1 = 1, g2 = 1, g3 = 1;
    //exercise
    int result = llenarTaxis2(g1, g2, g3);
    // check
    EXPECT_TRUE(result == 2);
}

TEST(LlenarTaxis, T2_Grupo2Par) {
    // setup
    int g1 = 1, g2 = 2, g3 = 1;
    //exercise
    int result = llenarTaxis2(g1, g2, g3);
    // check
    EXPECT_TRUE(result == 2);
}

TEST(LlenarTaxis, T2_Grupo2ImparA) {
    // setup
    int g1 = 1, g2 = 1, g3 = 3;
    //exercise
    int result = llenarTaxis2(g1, g2, g3);
    // check
    EXPECT_TRUE(result == 4);
}

TEST(LlenarTaxis, T2_Grupo2ImparB) {
    // setup
    int g1 = 1, g2 = 1, g3 = 1;
    //exercise
    int result = llenarTaxis2(g1, g2, g3);
    // check
    EXPECT_TRUE(result == 2);
}


//---------------LLENAR TAXIS 3---------------//

TEST(LlenarTaxis, T3_MismaCantidadDeGrupos) {
    // setup
    int g1 = 1, g2 = 1, g3 = 1;
    //exercise
    int result = llenarTaxis3(g1, g2, g3);
    // check
    EXPECT_TRUE(result == 2);
}

TEST(LlenarTaxis, T3_Grupo2Par) {
    // setup
    int g1 = 1, g2 = 2, g3 = 1;
    //exercise
    int result = llenarTaxis3(g1, g2, g3);
    // check
    EXPECT_TRUE(result == 2);
}

TEST(LlenarTaxis, T3_Grupo2ImparA) {
    // setup
    int g1 = 1, g2 = 1, g3 = 3;
    //exercise
    int result = llenarTaxis3(g1, g2, g3);
    // check
    EXPECT_TRUE(result == 4);
}

TEST(LlenarTaxis, T3_Grupo2ImparB) {
    // setup
    int g1 = 1, g2 = 1, g3 = 1;
    //exercise
    int result = llenarTaxis3(g1, g2, g3);
    // check
    EXPECT_TRUE(result == 2);
}





