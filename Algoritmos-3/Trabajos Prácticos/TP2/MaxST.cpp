#include <vector>
#include <cstring>
#include <iostream>
#include <climits>
#include <algorithm>
#include <queue>
using namespace std;


struct Arista {
    int v;
    int u;
    int peso;

    bool operator<(const Arista &a) const {
        return peso < a.peso;
    }

    bool operator>(const Arista &a) const {
        return peso > a.peso;
    }
};


vector<Arista> Prim(int N, vector<vector<Arista>> &vecinos) {
    
    /* Inicializacion de variables */
    vector<Arista> AGM = {};
    vector<bool> visited(N, false);
    priority_queue<Arista, vector<Arista>, greater<Arista> > heap;

    /* Insertamos una arista al azar */
    heap.push(vecinos[0][0]);
    visited[vecinos[0][0].u] = true;

    /* Loopeamos */
    while (heap.empty() == false) {

        /* Elegimos la arista de costo minimo */
        Arista actual = heap.top();
        heap.pop();

        /* Lo separamos en nodo destino y  peso de la arista */
        int nodo = actual.v;
        int peso = actual.peso;

        /* Si no lo visite, lo agrego */        
        if (visited[nodo] == false) {
            visited[nodo] = true;
            AGM.push_back(actual);

            for (Arista adyacente : vecinos[nodo]) {
                int nodoAdyacente = adyacente.v;
                if (visited[nodoAdyacente] == false) {
                    heap.push(adyacente);
                }
            }
        }

    }
    
    return AGM;
}



int main() {
    int N = 11;
    vector<vector<int>> aristas = {{'i', 'j', 0}, {'a', 'e', 1}, {'c', 'i', 1}, {'e', 'f', 1}, {'g', 'h', 1}, {'b', 'd', 2}, {'c', 'j', 2}, {'d', 'e', 2}, 
                                   {'d', 'h', 2}, {'a', 'd', 4}, {'b', 'c', 4}, {'c', 'h', 4}, {'g', 'i', 4}, {'a', 'b', 5}, {'d', 'f', 5}, {'h', 'i', 6}, 
                                   {'f', 'g', 7}, {'d', 'g', 11}};
    vector<vector<Arista>> vecinos(N);
    for (int i = 0; i < aristas.size(); i++) {
        int v = aristas[i][0]-97;
        int u = aristas[i][1]-97;
        int w = aristas[i][2];

        vecinos[v].push_back({u, v, w});
        vecinos[u].push_back({v, u, w});
    }

    vector<Arista> a = Prim(N, vecinos);

    for (auto arista : a) {
        cout << (char)(arista.v+97) << "-" << (char)(arista.u+97) << ": " << arista.peso << endl;
    }
}