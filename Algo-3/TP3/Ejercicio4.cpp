#include<iostream>
#include<vector>
#include<queue>
#include<climits>
using namespace std;
int INF = INT_MAX, N, M, x, C;

vector<vector<int>> personasPorCalle;
vector<vector<int>> capacity;
vector<vector<int>> adj;
vector<int> res;

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
            if (parent[next] == -1 && personasPorCalle[cur][next]) {
                parent[next] = cur;
                int new_flow = min(flow, personasPorCalle[cur][next]);
                if (next == t)
                    return new_flow;
                q.push({next, new_flow});
            }
        }
    }

    return 0;
}

int maxflow(int s, int t) {
    int flow = 0;
    vector<int> parent(N+1);
    int new_flow;

    while (new_flow = bfs(s, t, parent)) {
        flow += new_flow;
        int cur = t;
        while (cur != s) {
            int prev = parent[cur];
            personasPorCalle[prev][cur] -= new_flow;
            personasPorCalle[cur][prev] += new_flow;
            cur = prev;
        }
    }

    return flow;
}

int binarySearch(int left, int right, int N, int personas) {
    int maximoFlujoDeHerramientas = 0;
    int herramientasPorPersona = 1;

    while (left <= right) {
        herramientasPorPersona = (left+right)/2;

        /* 
            Necesitamos pasar de capacidad de herramientas por calle a capacidad de personas
            por calle usando una cantidad de herramientas por persona
        */
        for (int i = 1; i < N+1; i++) {
            for (int j = 1; j < N+1; j++) {
                personasPorCalle[i][j] = capacity[i][j]/herramientasPorPersona;
            }
        }

        int maximasPersonas = maxflow(1, N);

        if (maximasPersonas < personas) {
            right = herramientasPorPersona-1;
        } else {
            maximoFlujoDeHerramientas = personas*herramientasPorPersona;
            left = herramientasPorPersona+1;
        }
    }

    return maximoFlujoDeHerramientas;
}

int main() {
  cin >> C;

while (C > 0) { 
  cin >> N >> M >> x;

  /* Inicializamos las cotas de BS y las estructuras */
  int right = 1;
  adj = vector<vector<int>>(N+1);
  capacity = vector<vector<int>>(N+1, vector<int>(N+1, 0));
  personasPorCalle = vector<vector<int>>(N+1, vector<int>(N+1, 0));
  for (int i = 0; i < M; i++) {
    int u, v, c;
    cin >> u >> v >> c;

    if (u == 1) {
      right += c;
    }
    adj[u].push_back(v);
    adj[v].push_back(u);
    capacity[u][v] = c;
  }
  
  int maximaCantidadDeHerramientas = binarySearch(1,right, N, x);
    res.push_back(maximaCantidadDeHerramientas);
    C--;
  }

  for (int i = 0; i < res.size(); i++) {
    cout << res[i] << endl;
  }
}
