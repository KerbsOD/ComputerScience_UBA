#include <iostream>
#include <vector>

using namespace std;

bool estaOrdenado(vector<int> v){
    /* COMPLETAR */
    if(v.size() <= 1) {
        return true;
    }

    if(v[0] >= v.back()) {
        for(int i = 0; i < v.size() - 1; i++) {
            if(v[i] < v[i+1]) {
                return false;
            }
        }
        return true;
    }

    
    if(v[0] <= v.back()) {
        for(int i = 0; i < v.size() - 1; i++) {
            if(v[i] > v[i+1]) {
                return false;
            }
        }
        return true;
    }
}

int main() {
    /* No hace falta modificar el main */
    // Leo las entradas
    
    int n;
    cin >> n;
    int i = 0;
    int x;
    vector<int> v;// En v leo el vector
    while (i<n){
        cin >> x;
        v.push_back(x);
        i++;
    }



    // Evaluo si el vector v esta ordenado
    bool res = estaOrdenado(v);

    // Imprimo la salida
    cout << (res?"True":"False");

    return 0;
}
