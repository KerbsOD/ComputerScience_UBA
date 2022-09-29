cmake_minimum_required(VERSION 3.23)
project(Labo05)

set(CMAKE_CXX_STANDARD 14)

include_directories(src)
include_directories(cmake-build-debug/datos)

add_executable(Labo05
        src/cases.cpp
        src/cases.h
        src/ejercicios.cpp
        src/ejercicios.h
        src/main.cpp)
