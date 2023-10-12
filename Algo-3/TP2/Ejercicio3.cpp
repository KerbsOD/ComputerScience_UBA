#include<iostream>
#include<cstring>
#include<vector>
#include<climits>
#include<queue>
#include<algorithm>
using namespace std;


int T, N, M;
float MIN_C = 0.00001, MAX_C = 1000000;
struct Arista {
    int v;
    int u;
    int D;
    int R;
    int Peso;

    bool operator<(const Arista &a) const {
        return Peso < a.Peso;
    }

    bool operator>(const Arista &a) const {
        return Peso > a.Peso;
    }
};


vector<Arista> Kruskal(int n, vector<Arista> &aristas) {

    /* Inicializamos las variables */
    int nodosConectados  = 0;
    vector<Arista> AGM   = {};
    vector<bool> visited = vector<bool>(n+1, false);
    
    /* Queremos las aristas ordenadas de mayor a menor */
    sort(aristas.begin(), aristas.end(), greater<Arista>());  

    /* Recorremos todas las aristas */
    while (nodosConectados < n) {
        Arista minima = aristas.back();
        aristas.pop_back();

        int v = minima.v;
        int u = minima.u;

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


vector<Arista> conexiones;
void solucion() {
    float MID_C = ( MAX_C + MIN_C ) / 2;
    for (Arista conexion : conexiones) {
        conexion.Peso = conexion.D - MID_C*conexion.R;
    }

    vector<Arista> agm = Kruskal(N, conexiones);
    
}

int main () {
    cin >> T;

    while (T > 0) {
        cin >> N;
        cin >> M;

        for (int i = 0; i < M; i++) {
            int v, u, D, R;
            cin >> v >> u >> D >> R;
            conexiones.push_back({v, u, D, R});
        }   

        T--;
    }   

}


