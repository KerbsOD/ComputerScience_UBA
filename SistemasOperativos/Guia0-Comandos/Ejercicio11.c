//
// Created by octo on 8/18/24.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int validCuit(char* cuit, char* anotherCuit) {
    if (strcmp(cuit, anotherCuit) == 0) {
        printf("El CUIT ingresado es valido");
    } else {
        printf("El CUIT ingresado no es válido. Su información corregida es %s", anotherCuit);
    }
}

char* calcularCuit(char* cuit) {
    int scalars[] = {5, 4, 3, 2, 7, 6, 5, 4, 3, 2};
    int verifierDigit = 0;
    char correctCuit[11];

    strcpy(correctCuit, cuit);

    for(int i = 0; i < 10; i++) {
        int number = cuit[i] - '0';
        verifierDigit += number * scalars[i];
    }

    verifierDigit = verifierDigit % 11;
    verifierDigit = 11 - verifierDigit;
    char verifierDigitToChar = '0' + verifierDigit;

    correctCuit[10] = verifierDigitToChar;

    return correctCuit;
}

//int main(int argc, char *argv[]) {
//    char *cuit = argv[1];
//    validCuit(cuit, calcularCuit(cuit));
//}