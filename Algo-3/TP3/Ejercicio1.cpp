#include<iostream>
#include<vector>
#include<climits>
#include<queue>
using namespace std;

struct Arista {
    int v;
    int w;
};

struct Pasadiso {
    int desde;
    int hasta;
    int cobertura;

    bool operator<(const Pasadiso &a) const {
        return cobertura < a.cobertura;
    }
    
    bool operator>(const Pasadiso &a) const {
        return cobertura > a.cobertura;
    }
};

int INF = INT_MAX;
vector<int> res;
vector<int> minimoCosto;
vector<vector<Arista>> aristas;
priority_queue<Pasadiso> pasadisos;

int main () {
    int C, N, M;
    cin >> C;
   
    while (C>0) {
        cin >> N >> M;

        /* Inicializacion de estructuras */
        minimoCosto = vector<int>(N+1, INF);
        aristas     = vector<vector<Arista>>(N+1);
        pasadisos   = {};

        /* Inicializamos los Muros */
        for (int i = 0; i < N; i++) {
            aristas[i].push_back({i+1, 1});
        }

        /* Pusheamos al heap los pasadisos */
        for (int i = 0; i < M; i++) {
            int pasadisoDesde, pasadisoHasta;
            cin >> pasadisoDesde >> pasadisoHasta;
            
            if (pasadisoDesde > pasadisoHasta) {
                pasadisos.push({pasadisoHasta, pasadisoDesde, pasadisoDesde-pasadisoHasta});
            } else {
                pasadisos.push({pasadisoDesde, pasadisoHasta, pasadisoHasta-pasadisoDesde});
            }
        }

        /* Pusheamos a las aristas los 3 pasadisos mas largos */
        int pasadizosRestantes = 3;
        while (pasadisos.empty() == false && pasadizosRestantes > 0) {
            Pasadiso actual = pasadisos.top();
            pasadisos.pop();
            aristas[actual.desde].push_back({actual.hasta, 2});
            pasadizosRestantes--;
        }

        /* Corremos SSSP */
        minimoCosto[0] = 0;
        for (int u = 0; u < N+1; u++) {
            for (Arista e : aristas[u]) {
                if (minimoCosto[e.v] > minimoCosto[u]+e.w) {
                    minimoCosto[e.v] = minimoCosto[u]+e.w;
                }
            }
        }
        
        res.push_back(minimoCosto[N]);
        C--;
    }

    for (int i = 0; i < res.size(); i++) {
        cout << res[i] << endl;
    }
}

