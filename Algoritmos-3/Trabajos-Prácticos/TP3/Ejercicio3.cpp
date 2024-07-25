#include<iostream>
#include<vector>
#include<queue>
#include<climits>
using namespace std;

int INF = INT_MAX;

vector<vector<int>> capacity;
vector<vector<int>> adj;

int bfs(int s, int t, vector<int>& parent) {
    fill(parent.begin(), parent.end(), -1);
    parent[s] = -2;
    queue<pair<int, int>> q;
    q.push({s, INF});

    while (!q.empty()) {
        int cur = q.front().first;
        int flow = q.front().second;
        q.pop();

        for (int next : adj[cur]) {
            if (parent[next] == -1 && capacity[cur][next]) {
                parent[next] = cur;
                int new_flow = min(flow, capacity[cur][next]);
                if (next == t)
                    return new_flow;
                q.push({next, new_flow});
            }
        }
    }

    return 0;
}

int maxflow(int s, int t, int n) {
    int flow = 0;
    vector<int> parent(n);
    int new_flow;

    while (new_flow = bfs(s, t, parent)) {
        flow += new_flow;
        int cur = t;
        while (cur != s) {
            int prev = parent[cur];
            capacity[prev][cur] -= new_flow;
            capacity[cur][prev] += new_flow;
            cur = prev;
        }
    }

    return flow;
}

int main() {
    int c;
    vector<int> res = {};
    
    cin >> c;

    while (c > 0) {
        int N;
        cin >> N;
        
        /* 
            - cadenaDeRotos: Nos sirve para saber si estoy en un casillero roto o una fila de estos. Reduce la cantidad de nodos.
            - tagger: nos ayuda a enumerar los nodos
         */
        bool cadenaDeRotos = false;
        int tagger = 1;

        /* Cargamos el tablero */
        vector<vector<int>>  tablero(N, vector<int>(N, 0));
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                int casillero;
                cin >> casillero;
                tablero[i][j] = casillero;
            }
        }

        /* Populamos la matriz de filas */
        vector<vector<int>>  filas(N, vector<int>(N, 0)); 
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                if (tablero[i][j] == 0) {
                    filas[i][j] = tagger;
                    cadenaDeRotos = false;
                }

                /* Si la casilla esta rota y no estoy en una continuidad de rotas */
                if (tablero[i][j] == 1 && cadenaDeRotos == false) {
                    /* Si no estoy en el borde izquierdo o derecho */
                    if (j != 0 && j != N-1) {
                        tagger++;
                    } else {
                        cadenaDeRotos = true;
                    }
                } 
            }
            tagger++;
            cadenaDeRotos = false;
        }

        /* Populamos la matriz de columnas */
        vector<vector<int>>  columnas(N, vector<int>(N, 0));
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                
                if (tablero[j][i] == 0) {
                    columnas[j][i] = tagger;
                    cadenaDeRotos = false;
                }

                /* Si la casilla esta rota y no estoy en una continuidad de rotas */
                if (tablero[j][i] == 1 && cadenaDeRotos == false) {
                    /* Si no estoy en el borde superior o inferior */
                    if (j != 0 && j != N-1) {
                        tagger++;
                    } else {
                        cadenaDeRotos = true;
                    }
                } 
            }
            tagger++;
            cadenaDeRotos = false;
        }
        
        adj      = vector<vector<int>>(tagger+1);
        capacity = vector<vector<int>>(tagger, vector<int>(tagger+1, 0));
                
        int s = 0;
        int t = tagger+1;

        /* Creamos el grafo bipartito */
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                int u = filas[i][j];
                int v = columnas[i][j];
                adj[u].push_back(v); 
                adj[v].push_back(u); 
                capacity[u][v] = 1;

                /* Conecto un nodo source a todas las filas */
                adj[s].push_back(u);
                capacity[s][u] = 1;

                /* Conecto todas las columnas a un nodo target */
                adj[v].push_back(t);
                capacity[v][t] = 1;
            }
        } 

        /* Calculo MAX-FLOW */
        int mf = maxflow(s,t, tagger);
        res.push_back(mf);

        c--;
    }

    for (int i = 0; i < res.size(); i++) {
        cout << res[i] << endl;
    }
}