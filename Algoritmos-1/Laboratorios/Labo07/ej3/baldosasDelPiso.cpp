
// Tener en cuenta que queremos baldosas de la medida BxB y no podemos usar 1 baldosa para 2 espacios diferentes.
int baldosasDelPiso(int M, int N, int B) {

    int filas = M / B;
    int columnas = N / B;

    if(M % B != 0) {
        filas++;
    }

    if(N % B != 0) {
        columnas++;
    }

    return (columnas*filas);
}
