#include<iostream>
#include<vector>
#include<climits>
#include<cmath>
#include<algorithm>
using namespace std;

int T, N, M;
vector<pair<int, int>> res;
struct RatioTotal {
    double ratio;
    int D;
    int R;
};

struct Arista {
    int u;
    int v;
    int D;
    int R;
    double peso;

    bool operator<(const Arista &a) const {
        return peso > a.peso;
    }

    bool operator>(const Arista &a) const {
        return peso < a.peso;
    }
};

int buscar(int i, vector<int> &padre) {
    if (i == padre[i]) {
        return i;
    }

    return buscar(padre[i], padre);
}

RatioTotal Kruskal(double C, vector<Arista> aristas) {
    
    /* Inicializo las variables */
    int D            = 0;
    int R            = 0;
    double sumaTotal = 0.0;
    vector<int> padre(N+1, -1);
    
    /* Proceso los vectores */
    for (int i = 0; i < N+1; i++) {
        padre[i] = i;
    }
    for (auto &arista : aristas) {
        arista.peso = (double)arista.D - C*(double)arista.R;
    }

    /* Ordenamos las aristas */
    sort(aristas.begin(), aristas.end());  
    
    /* Calculamos la sumatoria de ratios */
    for (int i = 0; i < aristas.size(); i++) {
        int jefeDeU = buscar(aristas[i].u, padre);
        int jefeDeV = buscar(aristas[i].v, padre);
    
        if (jefeDeU != jefeDeV) {
            padre[jefeDeU] = padre[jefeDeV];
            
            D         += aristas[i].D;
            R         += aristas[i].R;
            sumaTotal += aristas[i].peso;
        }
    }

    return {sumaTotal, D, R};
}

vector<Arista> conexiones;
pair<int, int> solucion(int sumD, int sumR) {
    pair<int, int> sol = {0, 0};
    double ratio       = 1.0;
    double maxC        = (float)sumD;
    double minC        = 1.0/(float)sumR;

    while (maxC-minC > 0.0001 && fabs(ratio) > 0.0001) {
        double midC = (maxC+minC)/2.0;
        RatioTotal agm = Kruskal(midC, conexiones);
        sol = {agm.D, agm.R};

        if (agm.ratio < 0) {
            maxC = midC;        // Si la cuenta es negativa entonces C es muy grande.
        } else {
            minC = midC;
        }
    }   

    return sol;
}


int main () {
    cin >> T;
    res = {};

    while (T > 0) {
        cin >> N >> M;
        int sumD = 0;
        int sumR = 0;

        conexiones = {};
        for (int i = 0; i < M; i++) {
            int u, v, d, r;
            cin >> u >> v >> d >> r;

            sumD+=d;
            sumR+=r;
            conexiones.push_back({u, v, d, r});
        }
        
        pair<int, int> Distancia_Y_Ratio = solucion(sumD, sumR);
        res.push_back(Distancia_Y_Ratio);

        T--;
    }

    for (auto r : res) {
        cout << r.first << " " << r.second << endl;
    }
}
