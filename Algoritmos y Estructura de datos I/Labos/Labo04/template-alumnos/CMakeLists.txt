cmake_minimum_required(VERSION 3.23)
project(template_alumnos)

set(CMAKE_CXX_STANDARD 14)

# Para que compilen los vectores
set(CMAKE_EXE_LINKER_FLAGS "-static-libstdc++")

# Incluir Source
include_directories(src)

add_executable(template_alumnos src/vectores.cpp src/vectores.h src/main.cpp)
