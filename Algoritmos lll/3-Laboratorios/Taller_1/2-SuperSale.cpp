#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

struct Huevo {
    int precio;
    int peso;
};

int dp() {

}


int main() {
    int t;
    cin >> t;
    vector<int> res;
    
    for (int i = 0; i < t; i++) {
        
        int n;
        cin >> n;
        vector<Huevo> huevos;

        for(int j = 0; j < n; j++) {
            int precio;
            cin >> precio;
            int peso;
            cin >> peso;

            huevos.push_back({precio, peso});
        }

        int m;
        cin >> m;
        vector<int> capacidades;

        for(int j = 0; j < m; j++) {
            int capacidad;
            cin >> capacidad;

            capacidades.push_back(capacidad);
        }

        res.push_back(dp());
    }

    for (int i : res) {
        cout << i << endl;
    }

}