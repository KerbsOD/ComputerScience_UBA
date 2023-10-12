#include <vector>
#include <cstring>
#include <iostream>
#include <climits>
#include <algorithm>
#include <queue>
using namespace std;


struct Arista {
    int nodoA;
    int nodoB;
    int peso;

    bool operator<(const Arista &a) const {
        return peso < a.peso;
    }

    bool operator>(const Arista &a) const {
        return peso > a.peso;
    }
};

vector<Arista> Kruskal(int N, vector<Arista> &aristas) {

    /* Inicializamos las variables */
    int nodosConectados  = 0;
    vector<Arista> AGM   = {};
    vector<bool> visited = vector<bool>(N+1, false);
    
    /* Queremos las aristas ordenadas de mayor a menor */
    sort(aristas.begin(), aristas.end(), greater<Arista>());  

    /* Recorremos todas las aristas */
    while (nodosConectados < N) {
        Arista minima = aristas.back();
        aristas.pop_back();

        int v = minima.nodoA;
        int u = minima.nodoB;

        /* Agregamos los 2 nodos si es que ambos no fueron visitados */
        if (visited[v] == false && visited[u] == false) {
            visited[v] = true;
            visited[u] = true;
            nodosConectados += 2;
            AGM.push_back(minima);
        }

        /* Agregamos el primer nodo si este no fue visitado */
        if (visited[v] == false) {
            visited[v] = true;
            nodosConectados += 1;
            AGM.push_back(minima);
        }
        
        /* Agregamos el segundo nodo si este no fue visitado */
        if (visited[u] == false) {
            visited[u] = true;
            nodosConectados += 1;
            AGM.push_back(minima);
        }
    }    

    return AGM;
}


int main() {
    int N = 3;
    vector<Arista> aristas = {{1, 2, 0}, {1, 3, 2}, {2, 3, 1}};
    vector<Arista> a = Kruskal(N, aristas);

    for (auto ar : a) {
        cout << ar.nodoA << "-" << ar.nodoB << ": " << ar.peso << endl;
    }
}