#include<iostream>
#include<vector>
#include<climits>
#include<cmath>
using namespace std;
#define MINFLOAT  -10000000000000.0
#define n 10000
#define m 100000

struct CostoDyR {
    float costo;
    int   D;
    int   R;
};
int T, N, M;
vector<pair<int, int>> res;
int   u[m], v[m], D[m], R[m];
float W[m];
bool  visited[n];
CostoDyR adyacencia[n][n], maximoPesoParaCadaNodo[n];

void solucion(int sumD, int sumC) {
    float high  = sumD;
    float low   = 0.0001;
    float ratio = 1.0;
    int Dist;
    int Reps;
    
    while (high-low > 0.00001 && fabs(ratio) > 0.00001) {
        float mid = (high+low) / 2.0;
        ratio     = 0.0;
        Dist      = 0;
        Reps      = 0;

        /* Inicializo adyacencia */
        for (int i = 1; i < N+1; i++) {
            for (int j = 1; j < N+1; j++) {
                adyacencia[i][j] = {MINFLOAT, 0, 0};
            }
        }

        /* Inicializo maximoPeso */
        for (int i = 1; i < N+1; i++) {
            maximoPesoParaCadaNodo[i] = {MINFLOAT, 0, 0};
        }

        /* Calculo los pesos para cada Arista y populamos la matriz de adyacencia*/
        for (int i = 0; i < M; i++) {
            W[i] = (float)D[i] - mid*(float)R[i];
            adyacencia[u[i]][v[i]] = {W[i], D[i], R[i]};
            adyacencia[v[i]][u[i]] = {W[i], D[i], R[i]};
        }

        /* Empezamos por el nodo 1 */
        for (int i = 1; i < N+1; i++) {
            maximoPesoParaCadaNodo[i] = adyacencia[1][i];
            visited[i] = false;
        }
        visited[1] = true;

        for (int i = 2; i < N+1; i++) {
            int nodoMinimoPeso = 0;
            CostoDyR minimoPeso = {MINFLOAT, 0, 0};
            int numArista = -1;

            for (int j = 1; j < N+1; j++) {
                if (visited[j] == false && maximoPesoParaCadaNodo[j].costo > minimoPeso.costo) {
                    minimoPeso = maximoPesoParaCadaNodo[j];
                    nodoMinimoPeso = j;
                }
            }

            ratio += minimoPeso.costo;
            Dist  += minimoPeso.D;
            Reps  += minimoPeso.R;
            visited[nodoMinimoPeso] = true;

            for (int j = 1; j < N+1; j++) {
                if (adyacencia[nodoMinimoPeso][j].costo > maximoPesoParaCadaNodo[j].costo) {
                    maximoPesoParaCadaNodo[j] = adyacencia[nodoMinimoPeso][j];
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
        int sumD = 0, sumC = 0;

        /* Inicializamos las variables */
        for (int i = 0; i < M; i++) {
            int orig, dest, dist, rep;
            cin >> orig >> dest >> dist >> rep;
            

            sumD += dist;
            sumC += rep;
            u[i] = orig;
            v[i] = dest;
            D[i] = dist;
            R[i] = rep;
            W[i] = MINFLOAT;
        }
        solucion(sumD, sumC);
        T--;
    }

    for (auto r : res) {
        cout << r.first << " " << r.second << endl;
    }
    
}
