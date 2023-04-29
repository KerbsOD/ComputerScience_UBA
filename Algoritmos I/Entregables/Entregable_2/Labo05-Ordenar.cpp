#include <vector>
#include <iostream>

using namespace std;

bool isSorted(vector<int> v){
	int i = 0;
	bool ordenado = true;

	while(i < v.size()-1){
		ordenado = (v[i] <= v[i+1]);
		if(!ordenado){
			return false;
		}
		i++;
	}
	return true;
}

void ordenar1(vector<int>& v){
	
	while(!isSorted(v)){
		for(int i = 0; i < v.size()-1; i++){
			if(v[i] > v[i+1]){
				swap(v[i], v[i+1]);
				i=0;
			}
		}
	}
	return;
}

int main() {
    /* No hace falta modificar el main */
    
    // Leo las entradas
    int n; //Longitud del vector
    cin >> n;
    int i = 0;
    int x;
    vector<int> v;// En v leo el vector
    while (i<n){
        cin >> x;
        v.push_back(x);
        i++;
    }

    // Hago el ordenamiento
    ordenar1(v);
    
    // Imprimo el vector resultado
    i = 0;
    while (i < v.size()){
        cout << v[i] << " ";
        i++;
    }
    
    return 0;
}
