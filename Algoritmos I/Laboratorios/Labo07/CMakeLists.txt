cmake_minimum_required(VERSION 3.6)
project(LaboTesting)

#set(CMAKE_CXX_STANDARD 11)

add_subdirectory(lib/googletest-master)
include_directories(lib/googletest-master/googletest/include)


set(SOURCE_FILES main.cpp
        ej1/esPrimo.cpp
        ej1/Test/esPrimoTest.cpp
        ej1/puntaje.cpp
        ej1/Test/puntajeTest.cpp
        ej2/llenarTaxis.cpp
        ej2/Test/llenarTaxisTest.cpp
        ej3/electores.cpp
        ej3/Test/electoresTest.cpp
        ej3/baldosasDelPiso.cpp
        ej3/Test/baldosasDelPisoTEST.cpp
        ej3/contandoDragones.cpp
        ej3/Test/contandoDragonesTEST.cpp)

add_executable(LaboTesting ${SOURCE_FILES})

target_link_libraries(LaboTesting gtest gtest_main)
