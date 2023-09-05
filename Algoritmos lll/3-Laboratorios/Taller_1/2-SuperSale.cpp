#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

struct Huevo {
    int precio;
    int peso;
};


int dp(int i, int c, vector<vector<int>> &memoria, vector<Huevo> &huevos) {
    if (i == huevos.size() || c == 0) {
        return 0;
    }

    if (memoria[i][c] != -1) {
        return memoria[i][c];
    }

    int maxPrecio = dp(i+1, c, memoria, huevos);
    if (c >= huevos[i].peso) {
        maxPrecio = max(maxPrecio, dp(i+1, c - huevos[i].peso, memoria, huevos) + huevos[i].precio);
    }

    memoria[i][c] = maxPrecio;
    return maxPrecio;
}

int main() {
   int t;
   cin >> t;

    vector<int> output;

   for (int i = 0; i < t; i++) {
       vector<Huevo> huevos;
       vector<int> amigos;

       int n;  // Numero de Huevos
       cin >> n;
       vector<vector<int>> memoria(n, vector<int>(31, -1));
       for (int j = 0; j < n; j++) {
           Huevo nuevoHuevo;
           cin >> nuevoHuevo.precio;
           cin >> nuevoHuevo.peso;

           huevos.push_back(nuevoHuevo);
       }

       int m;  // Numero de amigos
       cin >> m;
       for (int j = 0; j < m; j++) {
           int pesoSoportadoPorAmigo;
           cin >> pesoSoportadoPorAmigo;

           amigos.push_back(pesoSoportadoPorAmigo);
       }


        int acumulador = 0;
        for (int j = 0; j < amigos.size(); j++) {
            acumulador += dp(0, amigos[j], memoria, huevos);
        }

        output.push_back(acumulador);
   }

   for (int i = 0; i < output.size(); i++) {
    cout << output[i] << endl;
   }
}