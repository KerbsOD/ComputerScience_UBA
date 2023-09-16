#include<iostream>
#include<vector>
#include<climits>
using namespace std;
int INF = INT_MAX;
int N, K;
struct Provedurias {
    int costo;              // Costo total (suma del vector de distancias).
    vector<int> distancias; // Distancia a el resto de los puestos.
    vector<int> posiciones; // Posiciones donde se pusieron las provedurias.
};
vector<int> Puestos;
vector<Provedurias> costosBase;
vector<vector<Provedurias>> memoria;

void InicializarCostosBase() {
    for (int i = 0; i < N; i++) {
        int costoTotal = 0;
        for (int j = 0; j < N; j++) {
            int Distancia = abs(Puestos[i] - Puestos[j]);
            costosBase[i].distancias[j] = Distancia;
            costoTotal += Distancia;
        }
        costosBase[i].costo = costoTotal;
        costosBase[i].posiciones.push_back(Puestos[i]);
    }
}

Provedurias ConcatenarPuestos(Provedurias fuente, Provedurias destino, int indiceFuente) {
    if (destino.posiciones.size() != 0) {
        if (destino.posiciones.back() == Puestos[indiceFuente]) {
            return destino;
        }
    }

    int acumulador = 0;
    for (int i = 0; i < N; i++) {
        int minDist = min(fuente.distancias[i], destino.distancias[i]);
        destino.distancias[i] = minDist;
        acumulador += minDist;
    }
    destino.costo = acumulador;
    for (int proveduria : fuente.posiciones) {
        destino.posiciones.push_back(proveduria);
    }

    return destino;
}

Provedurias Choripanes(int i, int k, int j) {
    if (k == K) {
        return costosBase[j];
    }

    if (i == N || k > N-i) {
        return {INF, vector<int>(N, INF), {}};
    }

    if (j != -1) {
        if (memoria[k][j].costo != -1) {
            return memoria[k][j];
        }
    }

    Provedurias noAgrego = Choripanes(i+1, k, j);
    Provedurias agrego   = Choripanes(i+1, k+1, i);

    if (j == -1) {
        Provedurias minimoCosto = agrego;
        if (noAgrego.costo < minimoCosto.costo) {
            minimoCosto = noAgrego;
        }
        return minimoCosto;
    }

    agrego   = ConcatenarPuestos(costosBase[j], agrego, j);
    noAgrego = ConcatenarPuestos(costosBase[j], noAgrego, j);

    Provedurias minimoCosto = agrego;
    if (noAgrego.costo < minimoCosto.costo) {
        minimoCosto = noAgrego;
    }

    memoria[k][j] = minimoCosto;

    return minimoCosto;
}

int main() {
    int T;
    vector<Provedurias> res = {};

    cin >> T;
    for (int i = 0; i < T; i++) {
        Puestos = {};
        cin >> N >> K;
        for (int j = 0; j < N; j++) {
            int puesto;
            cin >> puesto;
            Puestos.push_back(puesto);
        }

        if (K == N) {
            vector<int> todosLosPuestos;
            for (int i = N-1; i >= 0; i--) {
                todosLosPuestos.push_back(Puestos[i]);
            }
            res.push_back({0, {}, todosLosPuestos});
        } else {
            costosBase = vector<Provedurias>(N, {0, vector<int>(N, 0), {}});
            InicializarCostosBase();
            memoria = vector<vector<Provedurias>>(K, vector<Provedurias>(N, {-1, vector<int>(N, INF), {}}));
            Provedurias solucion = Choripanes(0, 0, -1);
            res.push_back(solucion);
        }
    }

    for (auto &resultado: res) {
        cout << resultado.costo << endl;
        for (int i = resultado.posiciones.size() - 1; i >= 0; i--) {
            cout << resultado.posiciones[i] << " ";
        }
        cout << endl;
    }
}

// 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100