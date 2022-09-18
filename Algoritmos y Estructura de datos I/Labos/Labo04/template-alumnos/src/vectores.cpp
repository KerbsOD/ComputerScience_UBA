#include "vectores.h"


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
void mostrarVectorFloat(vector<float> v){
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

vector<string> leerVectorString(string nombreArchivo){
    ifstream fin;
    fin.open(nombreArchivo, ios::in);
    string val;
    vector<string> v;
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

void guardarVectorF(vector<float> v, string nombreArchivo) {
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

bool pertenece(int x, vector<int> v){
    for(int i = 0; i < v.size(); i++) {
        if(v[i] == x) {
            return true;
        }
    }
    return false;
}

void cantApariciones(string nombreArchivo) {
    ofstream output;
    output.open("archivos/cantidadApariciones.out", ios::out);

    vector<int> vecEntrada = leerVector(nombreArchivo);
    vector<int> yaVistos;

    int cuenta;

    for(int i = 0; i < vecEntrada.size(); i++) {
        cuenta = 0;
        if(pertenece(vecEntrada[i], yaVistos)){} else {
            for(int j = 0; j < vecEntrada.size(); j++) {
                if((vecEntrada[j] == vecEntrada[i]) && (i != j)) {
                    cuenta++;
                }
            }
            yaVistos.push_back(vecEntrada[i]);
            output << "Numero: " << vecEntrada[i] << "  #Apariciones: " << cuenta << "\n";
        }
    }

    output.close();
}

void cantidadAparicionesDePalabra(string nombreArchivo, string palabra){
    ifstream input;
    input.open(nombreArchivo);

    vector<string> palabras = leerVectorString(nombreArchivo);
    int cuenta = 0;

    input.close();

    for(int i = 0; i < palabras.size(); i++) {
        if(palabras[i] == palabra) {
            cuenta++;
        }
    }
    cout << "Apariciones de " << palabra << ": " << cuenta;
}

void promedio(string nombreArchivoIn1, string nombreArchivoIn2, string nombreArchivoOut) {
    ifstream archivoUno, archivoDos;
    ofstream output;
    archivoUno.open(nombreArchivoIn1);
    archivoDos.open(nombreArchivoIn2);
    output.open(nombreArchivoOut);

    vector<int> vecArchivo1 = leerVector(nombreArchivoIn1);
    vector<int> vecArchivo2 = leerVector(nombreArchivoIn2);

    archivoUno.close();
    archivoDos.close();

    vector<float> res;
    for(int i = 0; i < vecArchivo1.size(); i++) {
        res.push_back((vecArchivo1[i] + vecArchivo2[i]) / 2);
    }

    guardarVectorF(res, nombreArchivoOut);
    output.close();
}

void ordenarSecuencias(string nombreArchivoIn1, string nombreArchivoIn2, string nombreArchivoOut) {
    ifstream archivoUno, archivoDos;
    ofstream output;
    archivoUno.open(nombreArchivoIn1);
    archivoDos.open(nombreArchivoIn2);
    output.open(nombreArchivoOut);

    vector<int> vecArchivo1 = leerVector(nombreArchivoIn1);
    vector<int> vecArchivo2 = leerVector(nombreArchivoIn2);

    archivoUno.close();
    archivoDos.close();

    vector<int> ordenTotal;

    for(int i = 0; i < vecArchivo1.size(); i++) {
        if(vecArchivo1[i] > vecArchivo2[i]){
            ordenTotal.push_back(vecArchivo2[i]);
            ordenTotal.push_back(vecArchivo1[i]);
        } else {
            ordenTotal.push_back(vecArchivo1[i]);
            ordenTotal.push_back(vecArchivo2[i]);
        }
    }
    guardarVector(ordenTotal, nombreArchivoOut);
    output.close();
}

vector<int> interseccion(string Archivo1, string Archivo2) {

    ifstream archivoUno, archivoDos;

    archivoUno.open(Archivo1);
    archivoDos.open(Archivo2);

    vector<int> vecArchivo1 = leerVector(Archivo1);
    vector<int> vecArchivo2 = leerVector(Archivo2);

    archivoUno.close();
    archivoDos.close();

    vector<int> interseccion;

    if(vecArchivo2.size() > vecArchivo1.size()) {
        for (int i = 0; i < vecArchivo2.size(); i++) {
            if (pertenece(vecArchivo2[i], vecArchivo1)) {
                interseccion.push_back(vecArchivo2[i]);
            }
        }
    } else {
        for (int i = 0; i < vecArchivo1.size(); i++) {
            if (pertenece(vecArchivo1[i], vecArchivo2)) {
                interseccion.push_back(vecArchivo1[i]);
            }
        }
    }

    return interseccion;
}
