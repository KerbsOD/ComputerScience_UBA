

void bfs() {
    hayCamino = true;

    /* Buscar paciente */
    visitadas = vector<vector<bool>>(N, vector<bool>(M, false));
    recorrido = queue<Esquina>();
    recorrido.push(hospital);
    visitadas[hospital.x][hospital.y] = true;

    while (hayCamino) {
        Esquina actual = recorrido.front();
        recorrido.pop();

        if (actual.x == paciente.x && actual.y == paciente.y) {
            paciente   = actual;
            ambulancia = actual;
            break;
        }
        
        irAbajo(actual, recorrido, visitadas, calles);
        irArriba(actual, recorrido, visitadas, calles);
        irDerecha(actual, recorrido, visitadas, calles);
        irIzquierda(actual, recorrido, visitadas, calles);

        if (recorrido.empty()) {
            hayCamino = false;
        }
    }
}
