#include <iostream>
#include "gtest/gtest.h"
#include "ejercicios.h"


int main(int argc, char **argv) {
    std::cout << "Implementando GTest!!" << std::endl;

    std::cout << "------- TIEMPO EMPLEADO -------" << "\n";
    tiempos();
    tiempos2();
    std::cout << "\n";


    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
