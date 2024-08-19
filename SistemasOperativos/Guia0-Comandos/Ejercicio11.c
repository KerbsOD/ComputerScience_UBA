//
// Created by octo on 8/18/24.
//

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    char *cuit = argv[1];

    int scalars[] = {5, 4, 3, 2, 7, 6, 5, 4, 3, 2};
    int verifierDigit = 0;
    for(int i = 0; i < 10; i++) {
        int number = cuit[i] - '0';
        verifierDigit += number * scalars[i];
    }

    verifierDigit = verifierDigit % 11;
    verifierDigit = 11 - verifierDigit;
    char verifierDigitToChar = '0' + verifierDigit;

    if (cuit[10] == verifierDigitToChar) {
        printf("El CUIT ingresado es valido");
    } else {
        cuit[10] = verifierDigitToChar;
        printf("El CUIT ingresado no es válido. Su información corregida es %s", cuit);
    }

}