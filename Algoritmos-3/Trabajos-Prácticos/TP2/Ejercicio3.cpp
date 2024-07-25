#include<iostream>
#include<cstring>
#include<vector>
#include<climits>
#include<cmath>
#include<queue>
#include<algorithm>
#include<fstream>
#include<string>
using namespace std;
struct CostoDyR {
    float costo;
    int   D;
    int   R;
};
int T, N, M;
vector<pair<int, int>> res;
vector<int> u;
vector<int> v;
vector<int> D;
vector<int> R;
vector<float> W;
vector<vector<int>> numeroDeArista;
vector<bool> visited;
vector<vector<CostoDyR>> adyacencia;
vector<CostoDyR> minimoPesoParaCadaNodo;

void solucion(int sd, int sr) {
    float high  = (float)sd;
    float low   = (float)sr / 1.0;
    float ratio;
    int Dist;
    int Reps;
    
    while (high-low > 0.0001) {
        float mid = (high+low) / 2.0;
        visited   = vector<bool>(N+1, false);
        ratio     = 0.0;
        Dist      = 0;
        Reps      = 0;

        /* Calculo los pesos para cada Arista y populamos la matriz de adyacencia*/
        for (int i = 0; i < M; i++) {
            W[i] = (float)D[i] - mid*(float)R[i];
            adyacencia[u[i]][v[i]] = {W[i], D[i], R[i]};
            adyacencia[v[i]][u[i]] = {W[i], D[i], R[i]};
        }
        
        /* Empezamos por el nodo 1 */
        for (int i = 1; i < N+1; i++) {
            minimoPesoParaCadaNodo[i] = adyacencia[1][i];
        }
        visited[1] = true;

        for (int i = 2; i < N+1; i++) {
            int nodoMinimoPeso = 0;
            CostoDyR minimoPeso = {MAXFLOAT, 0, 0};
            int numArista = -1;

            for (int j = 1; j < N+1; j++) {
                if (visited[j] == false && minimoPesoParaCadaNodo[j].costo < minimoPeso.costo) {
                    minimoPeso = minimoPesoParaCadaNodo[j];
                    nodoMinimoPeso = j;
                }
            }

            ratio += minimoPeso.costo;
            Dist  += minimoPeso.D;
            Reps  += minimoPeso.R;
            visited[nodoMinimoPeso] = true;

            for (int j = 1; j < N+1; j++) {
                if (adyacencia[nodoMinimoPeso][j].costo < minimoPesoParaCadaNodo[j].costo) {
                    minimoPesoParaCadaNodo[j] = adyacencia[nodoMinimoPeso][j];
                }
            }            
        }

        if (ratio <= 0) {
            high = mid;
        } else {
            low  = mid;
        }
    }

    res.push_back({Dist, Reps});
}


int main () {
    cin >> T;
    res = {};

    while (T > 0) {
        cin >> N >> M;
        int sd=0, sr=0;
        
        /* Para cada arista tenemos su u, v, D, R, W */
        u                      = vector<int>(M, -1);
        v                      = vector<int>(M, -1);
        D                      = vector<int>(M, -1);
        R                      = vector<int>(M, -1);
        W                      = vector<float>(M, -1);
        numeroDeArista         = vector<vector<int>>(N+1, vector<int>(N+1, -1));
        adyacencia             = vector<vector<CostoDyR>>(N+1, vector<CostoDyR>(N+1, {MAXFLOAT, 0, 0}));
        minimoPesoParaCadaNodo = vector<CostoDyR>(N+1, {MAXFLOAT, 0, 0});

        /* Inicializamos las variables */
        for (int i = 0; i < M; i++) {
            int orig, dest, dist, rep;
            cin >> orig >> dest >> dist >> rep;
            
            sd += dist;
            sr += rep;
            
            u[i] = orig;
            v[i] = dest;
            D[i] = dist;
            R[i] = rep;
            W[i] = MAXFLOAT;
            numeroDeArista[orig][dest] = i;
            numeroDeArista[dest][orig] = i;
        }
        solucion(sd, sr);
        T--;
    }

    for (auto r : res) {
        cout << r.first << " " << r.second << endl;
    }
}