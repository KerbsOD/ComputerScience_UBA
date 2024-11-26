//
// Created by okerbs on 10/6/24.
//
#ifndef AUX_CPP
#define AUX_CPP

#include "auxiliares.hpp"

bool esLetra(char letra)
{
    if (letra < 'A' || (letra > 'Z' && letra < 'a') || letra > 'z')
    {
        return false;
    }
    return true;
}

#endif
