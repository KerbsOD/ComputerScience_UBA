#include<iostream>
#include<vector>
#include<climits>
#include<queue>
#include<algorithm>
using namespace std;

struct Arista {
    int u;
    int v;
    int w;

    bool operator<(const Arista &a) const {
        return w > a.w;
    }

    bool operator>(const Arista &a) const {
        return w < a.w;
    }
};
int INF = INT_MAX;

int Dijkstra (int u, int v, int N, vector<vector<Arista>> &listaDeAdyacencia) {
    vector<bool> visited(N+1, false);

}


int main () {
    int C, N;
    cin >> C;

    while (C > 0) {
        cin >> N;

        /* Inicializacion de variables */
        vector<vector<int>> matrizCostos(N+1, vector<int>(N+1,0));
        vector<vector<int>> nuevoGrafo(N+1, vector<int>(N+1, 0));
        priority_queue<Arista> aristasPorDelta = {};
        vector<vector<Arista>> listaAdyacencia(N+1);

        /* Pusheamos los Shortest-Path-Weights a un heap */
        for (int i = 1; i < N+1; i++) {
            for (int j = 1; j < i; j++) {
                int latencia;
                cin >> latencia;
                matrizCostos[i][j] = latencia;
                matrizCostos[j][i] = latencia;
                aristasPorDelta.push({i,j,latencia});
            }
        }    

        /* Armamos una clase de "AGM" */
        while (aristasPorDelta.empty() == false) {
            Arista actual = aristasPorDelta.top();
            aristasPorDelta.pop();
            int u     = actual.u;
            int v     = actual.v;
            int delta = actual.w;
            
            /* Calculo el camino minimo de u a v */
            int distancia = Dijkstra(u, v, N, listaAdyacencia);
            
            /* Si la minima distancia actual es menor que la del input. False */
            if (distancia < delta) {
                // return imposible
            } else if (distancia > delta) {
                nuevoGrafo[u][v]++;
                nuevoGrafo[v][u]++;
            }

        }
        
        C--;
    }
}