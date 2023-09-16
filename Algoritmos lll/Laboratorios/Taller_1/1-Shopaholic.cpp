#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

int greedy(vector<int> productos) {
    int beneficioMaximo = 0;
    std::sort(productos.begin(), productos.end());
    for(int i = productos.size()-1; i >= 2; i-=3) {
        beneficioMaximo += productos[i-2];
    }
    return beneficioMaximo;
}


int main() {
    int t;
    cin >> t;

    for (int i = 0; i < t; i++) {
        int n;
        cin >> n;
        vector<int> productos;

        for(int j = 0; j < n; j++) {
            string precio;
            cin >> precio;
            productos.push_back(stoi(precio));
        }
        cout << greedy(productos) << endl;
    }
}