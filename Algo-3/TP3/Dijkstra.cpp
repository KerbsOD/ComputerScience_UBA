#include<iostream>
#include<vector>
#include<queue>
#include<climits>
using namespace std;
int INF = INT_MAX;

struct Arista {
    int u;  // Origen    
    int v;  // Destino
    int w;  // Peso

    bool operator<(const Arista e) const {
        return w < e.w;
    }
};

struct Nodo {
    int tag;    
    int d;

    bool operator<(const Nodo &u) const {
        return d > u.d;
    }
};


vector<int> Dijkstra(int s, vector<vector<Arista>> &aristas) {    
    /* Declaracion */
    priority_queue<Nodo> nodos;
    vector<int> distancias(aristas.size(), INF);

    /* Inicializacion */
    distancias[s] = 0;
    nodos.push({s, 0});

    /* Procesamiento */
    while (nodos.empty() == false) {
        int u = nodos.top().tag;
        int d = nodos.top().d;
        nodos.pop();

        for (Arista e : aristas[u]) {
            int v = e.v;
            int w = e.w;

            if (distancias[u] + w < distancias[v]) {
                distancias[v] = distancias[u] + w;
                nodos.push({v, distancias[v]});
            }
        }
    }

    /* Devolucion */
    return distancias;
}

/* O(M*Log(N)) */
vector<vector<Arista>> caminosMinimos(int s, int t, vector<vector<Arista>> &aristas) {    
    /* Declaracion */
    vector<vector<Arista>> caminosMinimos(aristas.size());                                          // O(1)
    vector<vector<Arista>> aristasInvertidas(aristas.size());                                       // O(1)
    vector<Arista> aristasArray;                                                    // O(1)

    /* Procesamiento */
    for (int i = 0; i < aristas.size(); i++) {                                      // O(M)
        for (int j = 0; j < aristas[i].size(); j++) {
            Arista actual = aristas[i][j];
            aristasInvertidas[actual.v].push_back({actual.v, actual.u, actual.w});
            aristasArray.push_back(actual);
        }
    }    

    vector<int> caminoMinimoS = Dijkstra(s, aristas);                               // O(M*Log(N))
    vector<int> caminoMinimoT = Dijkstra(t, aristasInvertidas);                     // O(M*Log(N))

    for (Arista e : aristasArray) {                                                 // O(M)
        int u = e.u;
        int v = e.v;

        if (caminoMinimoS[u] + e.w + caminoMinimoT[v] == caminoMinimoS[t]) {
            caminosMinimos[u].push_back(e);
        }
    }

    /* Return */
    return caminosMinimos;
}

int main() {
    vector<vector<Arista>> aristas(5);
    aristas[1].push_back({1,2,3});
    aristas[1].push_back({1,3,4});
    aristas[2].push_back({2,4,4});
    aristas[3].push_back({3,2,18});
    aristas[3].push_back({3,4,3});

    int s = 1;
    int t = 4;

    vector<vector<Arista>> grafoDeCaminosMinimos = caminosMinimos(1, 4, aristas);
}
