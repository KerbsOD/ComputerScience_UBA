#include "vectores.h"
#include<fstream>

// Función para probar en main.cpp si este módulo fue cargado correctamente
void holaModuloVectores(){
    cout << "El módulo vectores fue cargado correctamente" << endl;
}


//Ejercicio
bool divide(vector<int> v, int a){
	// Dados un vector v y un int a, decide si a divide a todos los numeros de v.
    for(int i = 0; i < v.size(); i++) {
        if(v[i] % a != 0) {
            return false;
        }
    }
    return true;
}

//Ejercicio
int mayor(vector<int> v){
	// Dado un vector v, devuelve el valor maximo encontrado.
    int maximo = v[0];
    for(int i = 0; i < v.size(); i++) {
        if(v[i] > maximo) {
            maximo = v[i];
        }
    }

    return maximo;
}

//Ejercicio
vector<int> reverso(vector<int> v){
	// Dado un vector v, devuelve el reverso.
    vector<int> v2;
    for(int i = (v.size()-1); i > -1; i--) {
        v2.push_back(v[i]);
    }

    return v2;
}

//Ejercicio
vector<int> rotar(vector<int> v, int k){
	// Dado un vector v y un entero k, rotar k posiciones los elementos de v.
	// [1,2,3,4,5,6] rotado 2, deberia dar [3,4,5,6,1,2].
    vector<int> r, m;

    for(int i = 0; i < k; i++) {
        r.push_back(v[i]);
    }
    for(int i = k; i < v.size(); i++) {
        m.push_back(v[i]);
    }
    for(int i = 0; i < r.size(); i++) {
        m.push_back(r[i]);
    }

    return m;
}

//Ejercicio
vector<int> factoresPrimos(int n){
	//que dado un entero devuelve un vector con los factores primos del mismo

    vector<int> primos;
    int i = 2;
    while(n > 1) {
        if(n % i == 0) {
            primos.push_back(i);
            n = n / i;
            i = 2;
        }
        i++;
    }

    return primos;
}

//Ejercicio
void mostrarVector(vector<int> v){
	//que dado un vector de enteros muestra por la salida estándar, el vector
	// Ejemplo: si el vector es <1, 2, 5, 65> se debe mostrar en pantalla [1, 2, 5, 65]
    int i = 0;
    while(i<v.size()) {
        if(i == 0) {
            cout << "[" << v[i];
            i++;
        } else {
            cout << ", " << v[i];
            i++;
        }
    }
    cout << "]";
}

vector<int> leerVector(string nombreArchivo){
    ifstream fin;
    fin.open(nombreArchivo, ios::in);
    int val;
    vector<int> v;
    while(fin >> val) {
        v.push_back(val);
    }
    fin.close();
    return v;
}

void guardarVector(vector<int> v, string nombreArchivo) {
    ofstream output;
    output.open(nombreArchivo, ios::out);
    for(int i = 0; i < v.size(); i++) {
        if(i == 0) {
            output << "[" << v[i];
        } else {
            output << ", " << v[i];
        }
    }
    output << "]";
}

int elementoMedio(vector<int>v) {
    int cuenta = 0;
    for(int i = 0; i < v.size(); i++) {
        cuenta = cuenta + v[i];
        if(cuenta > v[i+1]) {
            return v[i];
        }
    }
}

void cantApariciones(string nombreArchivo) {

}
