// #include<iostream>
// #include<vector>
// #include<algorithm>
// #include<climits>
// #include<queue>
// using namespace std;

// struct Esquina {
//     int x;
//     int y;
//     int w;
// };
// int N, M, C;
// queue<Esquina> recorrido;
// vector<vector<bool>> visitadas;
// vector<vector<int>> calles;
// Esquina hospital, paciente, ambulancia;                
// bool hayCamino;
// vector<pair<int, int>> res;

// void irIzquierda(Esquina &actual, queue<Esquina> &recorrido, vector<vector<bool>> &visitadas, vector<vector<int>> &calles) {
//     if (actual.y - 1 >= 0 && visitadas[actual.x][actual.y-1] == false && (calles[actual.x][actual.y-1] == 0 || actual.w+1 < calles[actual.x][actual.y-1])) {
//         visitadas[actual.x][actual.y-1] = true;
//         Esquina izquierda = {actual.x, actual.y-1, actual.w+1};
//         recorrido.push(izquierda);
//     }   
// }

// void irDerecha(Esquina &actual, queue<Esquina> &recorrido, vector<vector<bool>> &visitadas, vector<vector<int>> &calles) {
//     if (actual.y + 1 < M && visitadas[actual.x][actual.y+1] == false && (calles[actual.x][actual.y+1] == 0 || actual.w+1 < calles[actual.x][actual.y+1])) {
//         visitadas[actual.x][actual.y+1] = true;
//         Esquina derecha = {actual.x, actual.y+1, actual.w+1};
//         recorrido.push(derecha);
//     }   
// }

// void irArriba(Esquina &actual, queue<Esquina> &recorrido, vector<vector<bool>> &visitadas, vector<vector<int>> &calles) {
//     if (actual.x - 1 >= 0 && visitadas[actual.x-1][actual.y] == false && (calles[actual.x-1][actual.y] == 0 || actual.w+1 < calles[actual.x-1][actual.y])) {
//         visitadas[actual.x-1][actual.y] = true;
//         Esquina arriba = {actual.x-1, actual.y, actual.w+1};
//         recorrido.push(arriba);
//     }  
// }

// void irAbajo(Esquina &actual, queue<Esquina> &recorrido, vector<vector<bool>> &visitadas, vector<vector<int>> &calles) {
//     if (actual.x + 1 < N && visitadas[actual.x+1][actual.y] == false && (calles[actual.x+1][actual.y] == 0 || actual.w+1 < calles[actual.x+1][actual.y])) {
//         visitadas[actual.x+1][actual.y] = true;
//         Esquina abajo = {actual.x+1, actual.y, actual.w+1};
//         recorrido.push(abajo);
//     }     
// }

// void bfs() {
//     hayCamino = true;

//     /* Buscar paciente */
//     visitadas = vector<vector<bool>>(N, vector<bool>(M, false));
//     recorrido = queue<Esquina>();
//     recorrido.push(hospital);
//     visitadas[hospital.x][hospital.y] = true;

//     while (hayCamino) {
//         Esquina actual = recorrido.front();
//         recorrido.pop();

//         if (actual.x == paciente.x && actual.y == paciente.y) {
//             paciente   = actual;
//             ambulancia = actual;
//             break;
//         }
        
//         irAbajo(actual, recorrido, visitadas, calles);
//         irArriba(actual, recorrido, visitadas, calles);
//         irDerecha(actual, recorrido, visitadas, calles);
//         irIzquierda(actual, recorrido, visitadas, calles);

//         if (recorrido.empty()) {
//             hayCamino = false;
//         }
//     }


//     /* Volver al hosiptal */
//     visitadas = vector<vector<bool>>(N, vector<bool>(M, false));
//     recorrido = queue<Esquina>();
//     recorrido.push(ambulancia);
//     visitadas[ambulancia.x][ambulancia.y] = true;
    
//     while (hayCamino) {
//         Esquina actual = recorrido.front();
//         recorrido.pop();

//         if (actual.x == hospital.x && actual.y == hospital.y) {
//             ambulancia = actual;
//             break;
//         }
        
//         irAbajo(actual, recorrido, visitadas, calles);
//         irArriba(actual, recorrido, visitadas, calles);
//         irDerecha(actual, recorrido, visitadas, calles);
//         irIzquierda(actual, recorrido, visitadas, calles);

//         if (recorrido.empty()) {
//             hayCamino = false;
//         }
//     }
// }

// int main() {
//     /* Por invariante del ejercicio nunca va a haber una manifestacion en el hosiptal y en el paciente */
//     cin >> C;
//     while (C > 0) {
//         cin >> N;
//         cin >> M;
//         calles = vector<vector<int>>(N, vector<int>(M, 0));
//         for (int i = 0; i < N; i++) {
//             for (int j = 0; j < M; j++) {
//                 int a;
//                 cin >> a;
//                 calles[i][j] = a;
//             }
//         }

//         int x, y;
//         cin >> x >> y;
//         hospital = {x, y, 0};

//         cin >> x >> y;
//         paciente = {x, y, 0};

//         ambulancia = hospital;

//         bfs();

//         if (hayCamino) {
//             res.push_back({paciente.w, ambulancia.w});
//         } else {
//             res.push_back({-1, -1});
//         }
        
//         C--;
//     }

//     for (auto minutos : res) {
//         if (minutos.first == -1 && minutos.second == -1) {
//             cout << "IMPOSIBLE" << endl;
//         } else {
//             cout << minutos.first << " " << minutos.second << endl;
//         }
//     }    
// }



#include <iostream>
#include <vector>
#include <queue>

using namespace std;

const int dx[] = {-1, 1, 0, 0};
const int dy[] = {0, 0, -1, 1};
vector<pair<int, int>> res;

struct Node {
    int x;
    int y;
    int t;
};

int N,M;
std::queue<Node> q;
vector<vector<int>> matriz;
vector<vector<bool>> visited;

int bfs(Node& v, Node& target, int start_time) {
    q.push(v);
    visited = vector<vector<bool>>(N,
            vector<bool>(M,
                         false));
    visited[v.x][v.y] = true;

    while (!q.empty()) {
        Node v1 = q.front();
        int nT = v1.t + 1;
        q.pop();

        if (v1.x == target.x && v1.y == target.y)
            return nT - 1 + start_time;

        for (int i = 0; i < 4; ++i) {
            int xx = v1.x + dx[i];
            int yy = v1.y + dy[i];

            if (xx < 0 or yy < 0 or xx >= matriz.size() or yy >= matriz[0].size())
                continue;
            if(visited[xx][yy])
                continue;
            if(nT+start_time >= matriz[xx][yy] && matriz[xx][yy] != 0)
                continue;

            visited[xx][yy] = true;
            Node n = {xx, yy, nT};
            q.push(n);
        }
    }

    return -1;
}

int main() {
    int t;
    cin >> t;
    while (t > 0) {
        cin >> N >> M;
        int p;

        matriz = vector<vector<int>>(N, vector<int>(M));
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < M; j++) {
                cin >> p;
                matriz[i][j] = p;
            }
        }

        // ---- Cords -----
        int x, y;
        cin >> x >> y;
        Node hospital = {x, y, 0};
        cin >> x >> y;
        Node persona  = {x, y, 0};

        int path_1 = bfs(hospital, persona,0);
        q = queue<Node>();

        int path_2 = bfs(persona, hospital,path_1);
        res.emplace_back(path_1, path_2);
        t--;
    }

    for (auto r : res) {
        if (r.first == -1 or r.second == -1) {
            cout << "IMPOSIBLE" << endl;
        } else {
            cout << r.first << " " << r.second << endl;
        }
    }
}