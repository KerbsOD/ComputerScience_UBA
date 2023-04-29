#include <vector>
#include <iostream>

using namespace std;

int busquedaBinaria(vector<int> v, int x);
int buscar(vector<int> v, int x);
int menorMasGrande(vector<int> v, int x);

int buscar(vector<int> v, int x){
    return busquedaBinaria(v, x);
    //return busquedaJumpSearch(v, x);
}

int busquedaBinaria(vector<int> v, int x){

    if(v.size() > 0){
        if(v[0] >= v[v.size()-1]){
            int low = 0;
            int high = v.size()-1;

            while(low <= high){

                int mid = (low + high) / 2;

                if(v[mid] == x){
                    return mid;
                }

                if(v[mid] > x){
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }

            }
        }
    }

    int low = 0;
    int high = v.size()-1;

    while(low <= high){

        int mid = (low + high) / 2;

        if(v[mid] == x){
            return mid;
        }

        if(v[mid] < x){
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return -1;
}


int menorMasGrande(vector<int> v, int x) {

    // Casos donde esta en el borde del vector o 
    // que exista ya automaticamente devuelvo el siguiente
    int indice = buscar(v,x);
    if(indice != -1){
        if(indice != v.size() - 1){
            return buscar(v, x) + 1;
        } else {
            return -1;
        }
    } 

    int low = 0;
    int high = v.size() - 1;

    while(low <= high){
        int mid = (low + high) / 2;
        
        // Un Elemento
        if(v.size() <= 1 && x < v[mid]){
            return mid;
        }

        // Borde derecho
        if(v[mid] < x && mid+1 == v.size()){
            return -1;
        }

        // Borde Izquierdo
        if(v[mid] > x && mid == 0){
            return mid;
        }

        // En el medio
        if((v[mid] < x && v[mid + 1] > x)){
            return mid+1;
        }

        // Nada
        if(v[mid] < x){
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return -1;
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
    cin >> x;
    
    // Evaluo si el vector v esta ordenado
    int res = menorMasGrande(v,x);
    
    // Imprimo la salida
    cout << res;
    
    return 0;
}
