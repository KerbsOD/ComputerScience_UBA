#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>

void invertirMayusculas(char *palabra) {
    int len = strlen(palabra);
    for (int i = 0; i < len / 2; i++) {
        char temp = palabra[i];
        palabra[i] = palabra[len - i - 1];
        palabra[len - i - 1] = temp;
    }

    for (int i = 0; i < len; i++) {
        palabra[i] = toupper(palabra[i]);
    }
}

int main(int argc, char *argv[]) {
    if (argc != 3) {
        printf("Uso: %s N \"texto\"\n", argv[0]);
        return 1;
    }

    int N = atoi(argv[1]);
    char *texto = argv[2];

    char delimitadores[] = " ,!";
    char *palabra = strtok(texto, delimitadores);

    while (palabra != NULL) {
        if (strlen(palabra) > N) {
            invertirMayusculas(palabra);
        }
        printf("%s ", palabra);
        palabra = strtok(NULL, delimitadores);
    }
    printf("\n");
    return 0;
}