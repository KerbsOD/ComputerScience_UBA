#include<iostream>
#include<vector>
#include<algorithm>
using namespace std;

vector<double> minutosPorParcial;
vector<double> descontentoPorParcial;
vector<pair<double, int>> descontentoPorMinuto;

long int greedy(int n) {
    long int minutosTotales = 0;
    long int descontentoTotal = 0;

    for (int i = 0; i < n; i++) {
        descontentoPorMinuto.push_back({descontentoPorParcial[i]/minutosPorParcial[i], i});
    }

    sort(descontentoPorMinuto.begin(), descontentoPorMinuto.end(), greater<>());

    for (auto descontento : descontentoPorMinuto) {
        minutosTotales    += minutosPorParcial[descontento.second];
        descontentoTotal  += minutosTotales * descontentoPorParcial[descontento.second];
    }

    return (descontentoTotal % 1000000007);
}

int main() {
    long int T, N;
    cin >> T;

    vector<long int> res;

    for (int i = 0; i < T; i++) {
        minutosPorParcial      = {};
        descontentoPorParcial  = {};
        descontentoPorMinuto   = {};
        cin >> N;
        
        for (int j = 0; j < N; j++) {
            double minutos;
            cin >> minutos;
            minutosPorParcial.push_back(minutos);
        }
        
        for (int j = 0; j < N; j++) {
            double descontento;
            cin >> descontento;
            descontentoPorParcial.push_back(descontento);
        }

        res.push_back(greedy(N));
    }

    for (int i = 0; i < T; i++) {
        cout << res[i] << endl;
    }
}