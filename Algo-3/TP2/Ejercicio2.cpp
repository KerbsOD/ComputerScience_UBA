#include<iostream>
#include<vector>
#include<algorithm>
#include<climits>
#include<queue>
using namespace std;

struct Esquina {
    int x;
    int y;
    int w;
};
int N, M, C;
queue<Esquina> recorrido;
vector<vector<bool>> visitadas;
vector<vector<int>> calles;
Esquina hospital, paciente, ambulancia;                
bool hayCamino;
vector<pair<int, int>> res;

void irIzquierda(Esquina &actual, queue<Esquina> &recorrido, vector<vector<bool>> &visitadas, vector<vector<int>> &calles) {
    if (actual.y - 1 >= 0 && visitadas[actual.x][actual.y-1] == false && (calles[actual.x][actual.y-1] == 0 || actual.w+1 < calles[actual.x][actual.y-1])) {
        visitadas[actual.x][actual.y-1] = true;
        Esquina izquierda = {actual.x, actual.y-1, actual.w+1};
        recorrido.push(izquierda);
    }   
}

void irDerecha(Esquina &actual, queue<Esquina> &recorrido, vector<vector<bool>> &visitadas, vector<vector<int>> &calles) {
    if (actual.y + 1 < M && visitadas[actual.x][actual.y+1] == false && (calles[actual.x][actual.y+1] == 0 || actual.w+1 < calles[actual.x][actual.y+1])) {
        visitadas[actual.x][actual.y+1] = true;
        Esquina derecha = {actual.x, actual.y+1, actual.w+1};
        recorrido.push(derecha);
    }   
}

void irArriba(Esquina &actual, queue<Esquina> &recorrido, vector<vector<bool>> &visitadas, vector<vector<int>> &calles) {
    if (actual.x - 1 >= 0 && visitadas[actual.x-1][actual.y] == false && (calles[actual.x-1][actual.y] == 0 || actual.w+1 < calles[actual.x-1][actual.y])) {
        visitadas[actual.x-1][actual.y] = true;
        Esquina arriba = {actual.x-1, actual.y, actual.w+1};
        recorrido.push(arriba);
    }  
}

void irAbajo(Esquina &actual, queue<Esquina> &recorrido, vector<vector<bool>> &visitadas, vector<vector<int>> &calles) {
    if (actual.x + 1 < N && visitadas[actual.x+1][actual.y] == false && (calles[actual.x+1][actual.y] == 0 || actual.w+1 < calles[actual.x+1][actual.y])) {
        visitadas[actual.x+1][actual.y] = true;
        Esquina abajo = {actual.x+1, actual.y, actual.w+1};
        recorrido.push(abajo);
    }     
}

void bfs() {
    hayCamino = true;


    /* Buscar paciente */
    visitadas = vector<vector<bool>>(N, vector<bool>(M, false));
    recorrido = queue<Esquina>();
    recorrido.push(hospital);
    visitadas[hospital.x][hospital.y] = true;

    while (hayCamino) {
        Esquina actual = recorrido.front();
        recorrido.pop();

        if (actual.x == paciente.x && actual.y == paciente.y) {
            paciente   = actual;
            ambulancia = actual;
            break;
        }
        
        irAbajo(actual, recorrido, visitadas, calles);
        irArriba(actual, recorrido, visitadas, calles);
        irDerecha(actual, recorrido, visitadas, calles);
        irIzquierda(actual, recorrido, visitadas, calles);

        if (recorrido.empty()) {
            hayCamino = false;
        }
    }


    /* Volver al hosiptal */
    visitadas = vector<vector<bool>>(N, vector<bool>(M, false));
    recorrido = queue<Esquina>();
    recorrido.push(ambulancia);
    visitadas[ambulancia.x][ambulancia.y] = true;
    
    while (hayCamino) {
        Esquina actual = recorrido.front();
        recorrido.pop();

        if (actual.x == hospital.x && actual.y == hospital.y) {
            ambulancia = actual;
            break;
        }
        
        irAbajo(actual, recorrido, visitadas, calles);
        irArriba(actual, recorrido, visitadas, calles);
        irDerecha(actual, recorrido, visitadas, calles);
        irIzquierda(actual, recorrido, visitadas, calles);

        if (recorrido.empty()) {
            hayCamino = false;
        }
    }
}

int main() {
    /* Por invariante del ejercicio nunca va a haber una manifestacion en el hosiptal y en el paciente */
    cin >> C;
    while (C > 0) {
        cin >> N;
        cin >> M;
        calles = vector<vector<int>>(N, vector<int>(M, 0));
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < M; j++) {
                int a;
                cin >> a;
                calles[i][j] = a;
            }
        }

        int x, y;
        cin >> x >> y;
        hospital = {x, y, 0};

        cin >> x >> y;
        paciente = {x, y, 0};

        ambulancia = hospital;

        bfs();

        if (hayCamino) {
            res.push_back({paciente.w, ambulancia.w});
        } else {
            res.push_back({-1, -1});
        }
        
        C--;
    }

    for (auto minutos : res) {
        if (minutos.first == -1 && minutos.second == -1) {
            cout << "IMPOSIBLE" << endl;
        } else {
            cout << minutos.first << " " << minutos.second << endl;
        }
    }    
}



