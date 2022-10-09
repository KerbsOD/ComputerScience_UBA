cmake_minimum_required(VERSION 3.14)
project(laboCiclos)

set(CMAKE_EXE_LINKER_FLAGS "-static-libstdc++")

include_directories(template-alumnos)

add_executable(laboCiclos
        cases.cpp
        cases.h
        ejercicios.cpp
        ejercicios.h
        main.cpp)

