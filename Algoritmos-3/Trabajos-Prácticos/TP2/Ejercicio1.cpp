#include<iostream>
#include<vector>
#include<algorithm>
#include<climits>
using namespace std;


/* Generales */
int C, N, M, INF = INT_MAX, cantImportantes;
using Arista = pair<int, int>;
vector<int> padreDe;
vector<Arista> aristas;
vector<vector<int>> vecinosDe;
vector<pair<int, vector<Arista>>> res;


/* Ejercicio */
vector<int> nivelDe;
vector<int> minimoNivelDe;
int puentes;


void dfs(int v, int padre, int nivel, Arista &evitar) {
    padreDe[v]        = padre;
    nivelDe[v]        = nivel;
    minimoNivelDe[v]  = nivel;
    
    for (int u : vecinosDe[v]) {
        if ((v == evitar.first && u == evitar.second) || (v == evitar.second && u == evitar.first)) {
            
        } else {
            if (padreDe[u] == -1) {
                dfs(u, v, nivel+1, evitar);
                minimoNivelDe[v] = min(minimoNivelDe[v], minimoNivelDe[u]);
            } else if (padreDe[v] != u) {
                minimoNivelDe[v] = min(minimoNivelDe[v], nivelDe[u]);
            }
        
            if (minimoNivelDe[u] > nivelDe[v]) {
                puentes++;
            }
        }
    }
}


int main() {
    cin >> C;

    while (C > 0) {
        cin >> N;
        cin >> M;

        aristas = {};
        while (M > 0) {
            int v, u;
            cin >> v;
            cin >> u;
            aristas.push_back({u, v});
            M--;
        }

        vecinosDe     = vector<vector<int>>(N);
        for (Arista arista : aristas) {
            vecinosDe[arista.first].push_back(arista.second);
            vecinosDe[arista.second].push_back(arista.first);
        }        
        
        vector<Arista> importantes = {};

        for (Arista evitar : aristas) {
            padreDe        = vector<int>(N, -1);
            puentes        = 0;
            nivelDe        = vector<int>(N, INT_MAX);
            minimoNivelDe  = vector<int>(N, INT_MAX);
            dfs(0, -2, 0, evitar);

            if (puentes > 0) {
                if (evitar.first > evitar.second) {
                    evitar = {evitar.second, evitar.first};
                }
                importantes.push_back(evitar);
            }
        }        

        sort(importantes.begin(), importantes.end());     
        res.push_back({importantes.size(), importantes});     

        C--;        
    }    

    for (auto respuestas : res) {
        cout << respuestas.first << endl;
        for (Arista a : respuestas.second) {
            cout << a.first << " " << a.second << endl;
        }
    }

}