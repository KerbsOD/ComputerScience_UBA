#include<iostream>
#include<vector>
#include<climits>
#include<queue>
using namespace std;
int INF = INT_MAX, N, M;
struct Arista {
    int u;
    int v;
    int w;
};
vector<vector<Arista>> aristas;

int dp(int u, int pasadizos) {
    if (u == N || pasadizos > 3) {
        return 0;
    }

    int minimoCoste = INF;
    for (Arista e : aristas[u]) {
        if (e.w == 2) {
            minimoCoste = min(minimoCoste, dp(e.v, pasadizos+1) + 2);
        } else {
            minimoCoste = min(minimoCoste, dp(e.v, pasadizos) + 1);
        }
    }

    return minimoCoste;
}


int main() {
    int T;
    cin >> T;

    while (T > 0) {
        cin >> N >> M;

        aristas = vector<vector<Arista>>(N+1);
        for (int i = 0; i < N; i++) {
            aristas[i].push_back({i, i+1, 1});
        }

        for (int i = 0; i < M; i++) {
            int u, v;
            cin >> u >> v;
            aristas[u].push_back({u,v,2});
        }

        int costoMinimo = dp(0,0);
        cout << costoMinimo << endl;
        T--;
    }
}