cmake_minimum_required(VERSION 3.0.0)
project(labo08 VERSION 0.1.0)

include(CTest)
enable_testing()

set(CMAKE_EXE_LINKER_FLAGS "-static-libstdc++")

add_executable(labo08 main.cpp cases.cpp cases.h ejercicios.cpp ejercicios.h)

set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
include(CPack)
