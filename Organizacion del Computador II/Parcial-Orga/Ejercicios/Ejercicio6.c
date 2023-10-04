char* codigoCesar(char* s, int x) {
    char* iteradorContador = s;
    int contador = 0;
    while(*iteradorContador != '\0') {
        contador++;
        iteradorContador++;
    }

    char* iterador = malloc(sizeof(char)*contador);
    char* dir = iterador;

    while (*s != '\0') {
        char number = 65 + ((x+*s) % 91) % 65;
        *iterador = number;
        s++;
        iterador++;
    }

    return dir;
}