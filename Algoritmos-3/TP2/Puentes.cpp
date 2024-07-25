#include <vector>
#include <iostream>
using namespace std;

/* Estructuras */
struct Arista {
    int NodoA;
    int NodoB;
};
vector<int> nivelDe;
vector<int> mininmoNivelDe;
vector<int> padreDe;
vector<vector<int>> vecinosDe;
vector<Arista> puentes;

void dfs(int v, int padre, int nivel) {
    padreDe[v]        = padre;
    nivelDe[v]        = nivel;
    mininmoNivelDe[v] = nivel;
    
    for (int u : vecinosDe[v]) {
        if (padreDe[u] == -1) {
            dfs(u, v, nivel+1);
            mininmoNivelDe[v] = min(mininmoNivelDe[v], mininmoNivelDe[u]);
        } else if (padreDe[v] != u) {
            mininmoNivelDe[v] = min(mininmoNivelDe[v], nivelDe[u]);
        }
        
        if (mininmoNivelDe[u] > nivelDe[v]) {
            puentes.push_back({v, u});
        }
    }
}

int main () {
    vector<Arista> aristas = {{0,1}, {0, 2}, {0, 4}, {2, 3}, {3, 4}, {3, 5}, {5, 6}};
    int N = 7;
    padreDe        = vector<int>(N, -1);
    vecinosDe      = vector<vector<int>>(N);
    nivelDe        = vector<int>(N, INT_MAX);
    mininmoNivelDe = vector<int>(N, INT_MAX);
    puentes = {};
    for (Arista arista : aristas) {
        vecinosDe[arista.NodoA].push_back(arista.NodoB);
        vecinosDe[arista.NodoB].push_back(arista.NodoA);
    }

    dfs(0, -2, 0);

    for (int i = 0; i < puentes.size(); i++) {
        cout << "(" << puentes[i].NodoA << "," << puentes[i].NodoB << ") es puente" << endl;
    }
}