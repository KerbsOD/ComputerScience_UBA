# Settings
cmake_minimum_required(VERSION 3.0.0)
project(AgendaV2 VERSION 0.1.0)


# Compila todos los .cpp en la carpeta src y la carpeta test
# IMPORTANTE compilarlos juntos (el test.cpp con los src files de donde vienen las definiciones)
# misCompilables seria mi conjunto de archivos cpp distribuidos por src/ y test/
file(GLOB misCompilables src/*.cpp test/*.cpp)


# Todo lo relacionado a googletest
add_subdirectory(test/googletest)                           # Añadir la carpeta "googletest" para que cmake la vea Y COMPILE GOOGLETEST
include_directories(test/googletest/include)                # Para que podamos usar el "#include <gtest/gtest.h>"
add_executable(Agenda_test ${misCompilables})               # Creamos el .exe donde se ejecutan los test cases.
target_link_libraries(Agenda_test PRIVATE gtest)            # Linkeamos gtest con nuestro .exe

# Agenda_test es el nombre de nuestro .exe
# IMPORTANTE: Para que la extensión "C++ TestMate" encuentre nuestros tests
# estos tienen que tener la palabra clave "test/Test/TEST" y estar dentro de un directorio "build/Build/BUILD"
