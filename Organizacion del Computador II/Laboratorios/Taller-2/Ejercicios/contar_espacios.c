#include "contar_espacios.h"
//#include <stdio.h>

uint32_t longitud_de_string(const char* string) {
    if (string == NULL)
        return 0;

    int res = 0;
    while (*string)
    {
        ++res;
        ++string;
    }

    return res;
    }

uint32_t contar_espacios(const char* string) {
    if (string == NULL)
        return 0;

    int res = 0;
    while (*string)
    {
        if (*string == 32)
            ++res;
        ++string;
    }

    return res;
}

// Pueden probar acá su código (recuerden comentarlo antes de ejecutar los tests!)
/*
int main() {

    printf("1. %d\n", contar_espacios("hola como andas?"));

    printf("2. %d\n", contar_espacios("holaaaa orga2"));
}
*/