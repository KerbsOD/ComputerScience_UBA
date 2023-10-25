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

struct Nodo {
    int tag;
    int tension;
    int recorrido;

    bool operator<(const Nodo &a) const {
        return tension > a.tension;
    }
    bool operator>(const Nodo &a) const {
        return tension < a.tension;
    }

};

int C, N, INF = INT_MAX;
priority_queue<Arista> deltas;
vector<vector<int>> matrizRes;
vector<vector<Arista>> grafo;
vector<vector<vector<int>>> res;

pair<int,int> Dijkstra (int u, int v) {
    vector<int> distancias(N+1, INF);   
    vector<bool> visited(N+1, false); 
    priority_queue<Nodo> nodos;
    distancias[u] = 0;
    int recorrido = 0;
    nodos.push({u, 0, 0});

    while (nodos.empty() == false) {
        Nodo actual = nodos.top();
        nodos.pop();
        visited[actual.tag] = true;
        
        if (actual.tag == v) {
            recorrido = actual.recorrido;
            break;
        }

        for (Arista e : grafo[actual.tag]) {
            if (visited[e.v] == false && distancias[e.v] > distancias[actual.tag]+e.w) {
                distancias[e.v] = distancias[actual.tag]+e.w;
                nodos.push({e.v, distancias[e.v], actual.recorrido+1});
            }
        }
    }
    
    return {distancias[v], recorrido};
}


int main () {
    cin >> C;
    res = {};

    while (C > 0) {
        cin >> N;

        /* Inicializacion de variables */
        deltas     = {};
        grafo      = vector<vector<Arista>>(N+1);
        matrizRes  = vector<vector<int>>(N, vector<int>(N, 0));

        /* Pusheamos los Shortest-Path-Weights (deltas entre todos los pares de nodos) a un heap */
        for (int i = 1; i < N+1; i++) {
            for (int j = 1; j < i; j++) {
                int latencia;
                cin >> latencia;
                deltas.push({i,j,latencia});
            }
        }    

        /* Armamos una clase de "AGM" con los deltas */
        while (deltas.empty() == false) {
            Arista actual = deltas.top();
            deltas.pop();
            int u     = actual.u;
            int v     = actual.v;
            int delta = actual.w;
            
            /* Calculo el camino minimo real de u a v */
            pair<int,int> distancia = Dijkstra(u, v);

            /* 
            Tenemos 3 casos 
                - distancia > delta: La distancia actual, real, de u a v es mayor que lo que deberia ser. Agregamos la arista.
                - distancia = delta: Se cumple la propiedad. No hacemos nada.
                - distancia < delta: La distancia real es menor al delta. Imposible. Terminamos el programa.
            */
            
            if (distancia.first > delta) {
                grafo[u].push_back({u,v,delta});
                grafo[v].push_back({v,u,delta});
                matrizRes[u-1][v-1] = 1;
                matrizRes[v-1][u-1] = 1;
            } else if (distancia.first < delta) {
                matrizRes = vector<vector<int>>(N, vector<int>(N, -1));
                break;
            } else {
                matrizRes[u-1][v-1] = distancia.second;
                matrizRes[v-1][u-1] = distancia.second;
            }
        }

        res.push_back(matrizRes);
        C--;
    }

    for (auto respuesta : res) {
        if (respuesta[0][0] == 0) {
            cout << "POSIBLE" << endl;
            for (int i = 0; i < respuesta.size(); i++) {
                for (int j = 0; j < respuesta[0].size(); j++) {
                    cout << respuesta[i][j] << " ";
                }
                cout << endl;
            }
        } else {
            cout << "IMPOSIBLE" << endl;
        }
    }

}