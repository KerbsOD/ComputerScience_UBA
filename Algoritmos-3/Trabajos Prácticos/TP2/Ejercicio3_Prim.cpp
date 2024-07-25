#include<iostream>
#include<cstring>
#include<vector>
#include<climits>
#include<cmath>
#include<queue>
#include<algorithm>
#include <fstream>
#include <string>
using namespace std;


struct Arista {
    int v;
    int D;
    int R;
    float w;

    bool operator<(const Arista &a) const {
        return w < a.w;
    }

    bool operator>(const Arista &a) const {
        return w > a.w;
    }
};
int T, N, M;
vector<pair<int, int>> res;
vector<vector<Arista>> vecinos;
struct RatioTotal {
    float ratio;
    int D;
    int R;
};


RatioTotal Prim(float C) {
    
    /* Inicializacion de variables */
    int D = 0;
    int R = 0;
    float costoTotal = 0.0;
    vector<bool> visited(N+1, false);
    priority_queue<Arista> heap;

    /* Insertamos una arista al azar */
    heap.push({1, 0, 0, 0});

    /* Loopeamos */
    while (heap.empty() == false) {

        /* Elegimos la arista de costo minimo */
        Arista actual = heap.top();
        heap.pop();

        /* Obtenemos el nodo destino de la arista */
        int nodoDestino  = actual.v;

        /* Si no lo visite, lo agrego */        
        if (visited[nodoDestino] == false) {
            visited[nodoDestino] = true;

            D          += actual.D;
            R          += actual.R;
            costoTotal += actual.w;

            for (Arista adyacente : vecinos[nodoDestino]) {
                int nodoAdyacente = adyacente.v;
                if (visited[nodoAdyacente] == false) {
                    adyacente.w = adyacente.D - C*adyacente.R;
                    heap.push(adyacente);
                }
            }
        }
    }
    
    return {costoTotal, D, R};
}

pair<int, int> solucion(int sd, int sr) {
   
    /* Inicializamos las variables */
    pair<int, int> mejorSolucion = {0, 0};
    float ratio                  = 1000;

    /* Iteramos hasta cierta tolerancia */
    while (true) {        
        /* Calculamos la sumatoria */
        RatioTotal agm = Prim(ratio);

        if (fabs(ratio - agm.ratio) < 0.0001) {
            break;
        }

        /* Actualizamos la mejor solucion */
        mejorSolucion = {agm.D, agm.R};
        ratio = agm.ratio;
    }   

    return mejorSolucion;
}

int main () {
    cin >> T;
    res = {};

    while (T > 0) {
        cin >> N >> M;  
        int sumD = 0, sumR = 0;
        vecinos = vector<vector<Arista>>(N+1);
        for (int i = 0; i < M; i++) {
            int u, v, d, r;
            cin >> u >> v >> d >> r;
            vecinos[u].push_back({v, d, r, 0});
            vecinos[v].push_back({u, d, r, 0});
        }
        
        pair<int, int> Distancia_Y_Ratio = solucion(sumD, sumR);
        res.push_back(Distancia_Y_Ratio);

        T--;
    }

    for (auto r : res) {
        cout << r.first << " " << r.second << endl;
    }
}