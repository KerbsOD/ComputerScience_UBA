#include<iostream>
#include<vector>
#include<climits>
using namespace std;
int INF = UINT_MAX;
int N, K;
struct Provedurias {
    int costo;              // Costo total (suma del vector de distancias).
    vector<int> distancias; // Distancia a el resto de los puestos.
    vector<int> posiciones; // Posiciones donde se pusieron las provedurias.
};
vector<int> Puestos;
vector<vector<Provedurias>> memoria;

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
