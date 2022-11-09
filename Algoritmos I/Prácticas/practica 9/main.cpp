#include<iostream>
#include<vector>
#include <algorithm> 


using namespace std;

pair<int, int> ej1(vector<vector<int>> m, int x);
int ej2(vector<int> s);
int ej3A(int numero);
int ej3B(int numero);
int ej4A(vector<int> s);
int ej4B(vector<int> s);
int ej4C(vector<int> s);
int ej5A(vector<vector<int>> matriz, int x);
int ej6A(vector<int> v, int x);
int ej6B(vector<int> v);
int ej6C(vector<int> v);
int ej6D(vector<int> s, int cota_inf, int cota_sup);
bool ej7(vector<int> s);
vector<char> ejercicio8(string s);
vector<int> ejercicio9(vector<int> v, int k, int x);
void ej10(vector<int> &v);
void ej12A(vector<int> &v);
void ej13();
void burbujeo(vector<int> &v);
void insercion(vector<int> &v);
void seleccion(vector<int> &v);
void ej14(vector<int> &v);
void bingoSort(vector<int> &v);
void ejercicio16(vector<int> &v);
vector<int> ejercicio17(vector<int> a);
void ejercicio18(vector<int> &v);

int main(){

    vector<int> v = {4,2,6,7,4,4,4,3,7,7,7};

    bingoSort(v);

    for(int i = 0; i < v.size(); i++){
        cout << v[i];
    }

    

    
}

///////////////////// Ejercicio 1 ////////////////////////////
pair<int, int> ej1(vector<vector<int>> m, int x){
    pair<int, int> pos = {-1, -1};
    bool encontrado = false;

    for(int i = 0; i < m.size(); i++){
        for(int j = 0; j < m.size(); j++){
            if(m[i][j] == x){
                encontrado = true;
                pos = {i, j};
            }
        }
    }

    return pos;
}


///////////////////// Ejercicio 2 ////////////////////////////
int ej2(vector<int> s){
    
    int low = 0;
    int high = s.size() - 1;

    while(low + 1 < high){
        
        int mid = (low + high) / 2;
        
        if(s[mid] > mid){
            high = mid;
        } else {
            low = mid;
        }
    }

    return high;
}


///////////////////// Ejercicio 3 ////////////////////////////
int ej3A(int numero){
    
    int x = 1;
    
    while(!((x*x) >= numero)){
        x++;
    }

    return x;
}

int ej3B(int numero){
    
    int low = 0;
    int high = numero;
    int res = -1;

    while(low <= high){
        
        int mid = (low + high) / 2;

        if(mid * mid == numero){
            return mid;
        } 

        else if(mid * mid < numero){
            res = mid;
            low = mid + 1;
        }

        else {
            high = mid - 1;
        }
    }
    return res;
}


///////////////////// Ejercicio 4 ////////////////////////////
int ej4A(vector<int> s){

    int suma = 0;

    for(int i = 0; i < s.size(); i++){
        suma = suma + s[i];
    }

    return suma;
}

int ej4B(vector<int> s){

    int low = 0;
    int high = s.size()-1;

    while(low + 1 < high){
        int mid = (low + high) / 2;

        if(s[mid] == 1){
            high = mid;
        } else {
            low = mid;
        }
    }

    return (s.size() - high);
}


int ej4C(vector<int> s){
    int low = 0;
    int high = s.size()-1;

    while(low + 1 < high){
        int mid = (low + high) / 2;

        if(s[mid] == 22){
            high = mid;
        } else {
            low = mid;
        }
    }

    int veintidos = (s.size() - high) * 22;
    int quinces = high * 15;

    return (veintidos + quinces);
}


///////////////////// Ejercicio 5 ////////////////////////////
int ej5A(vector<vector<int>> matriz, int x){
    
    int suma = 0;
    
    for(int i = 0; i < matriz.size(); i++){
        for(int j = 0; j < matriz[0].size(); j++){
            if(matriz[i][j] == x){
                suma++;
            }
        }
    }

    return suma;
}

// c: O(M+N)


///////////////////// Ejercicio 6 ////////////////////////////
int ej6A(vector<int> v, int x){ // O(N)
    
    int suma = 0;
    
    for(int i = 0; i < v.size(); i++){
        if(v[i] == x){
            suma++;
        }
    }

    return suma;
}


int ej6B(vector<int> v){ // O(n)
    int maxi=v[0], min = v[0];
    
    for (int i=0;i<v.size();i++){
        if (v[i] < min) min = v[i];
        if (v[i] > maxi) maxi = v[i];
    }
    
    return maxi-min;
}


int ej6C(vector<int> v){ // O(n^2)
    int masApariciones;
    int cuentaActual = 0;

    for(int i = 0; i < v.size(); i++){
        for(int j = 0; j < v.size(); j++){
            if(v[j] == v[i]){
                cuentaActual++;
            }
        }

        if(cuentaActual > masApariciones){
            masApariciones = cuentaActual;
        }

        cuentaActual = 0;
    }

    return masApariciones;
}

int ej6D(vector<int> s, int cota_inf, int cota_sup){
    
    vector<int> aparis(cota_sup-cota_inf, 0);
    
    for (int i=0;i<s.size();i++) { //O(n)
        aparis[s[i]-cota_inf]++;
    }
    
    int indi_maxi=0;
    
    for (int i=0;i<aparis.size();i++){ //O(cota_sup-cota_inf)
        if (aparis[indi_maxi] < aparis[i]){
        indi_maxi = i;
        }
    }
    return indi_maxi-cota_inf;
}

///////////////////// Ejercicio 7 ////////////////////////////
bool ej7(vector<int> s){
    vector<pair<int,int>> aparis = {};

    sort(s.begin(), s.end());
    bool deCuentas = true;
    int suma = 0;


    for(int i = 0; i < s.size(); i++){
        if(s[i] == s[i+1]){
            suma++;
        } else if(s[i] != s[i+1] || i == s.size() - 1) {
            if(s[i] != suma+1){
                deCuentas = false;
            }
            suma = 0;
        }
    }

    return deCuentas;
}


///////////////////// Ejercicio 8 ////////////////////////////
vector<char> ejercicio8(string s){ // O(n)
    
    vector<int> asc(128, 0);
    vector<int> numeros;
    vector<char> res;

    for(int i = 0; i < s.size(); i++){ // O(n)
        int a = s[i];
        for(int j = 0; j < asc.size(); j++){ // O(128)
            if(a == j){
                asc[j]++;
            }
        }
    }

    for(int i = 0; i < asc.size(); i++){ // O(128)
        
        if(asc[i] >= 1){
            for(int j = 0; j < asc[i]; j++){
                numeros.push_back(i);
            }
        }
    }


    for(int i = 0; i < numeros.size(); i++){
        if(numeros[i] == 32){
            continue;
        } else {
            res.push_back(numeros[i]);
        }
    }

    

    return res;
}


///////////////////// Ejercicio 9 ////////////////////////////
vector<int> ejercicio9(vector<int> v, int k, int x){
    
    vector<int> Distancias;
    vector<int> res;

    for(int i = 0; i < v.size(); i++){
        Distancias.push_back(v[i] - x);
    }

    sort(Distancias.begin(), Distancias.end());

    for(int i = 0; i < v.size(); i++){
        Distancias[i] = Distancias[i] + 12;
    }


    for(int i = 0; i <= k; i++){
        if(Distancias[i] == Distancias[i+1] || Distancias[i] == x){
            continue;
        } else {
            res.push_back(Distancias[i]);
        }
    }

    return res;
}



///////////////////// Ejercicio 10 ////////////////////////////
void ej10(vector<int> &v){

    bool swapped = true;
    int start = 0;
    int end = v.size() - 1;
 
    while (swapped) {
        
        swapped = false;
 
        for (int i = start; i < end; ++i) {
            if (v[i] > v[i + 1]) {
                swap(v[i], v[i + 1]);
                swapped = true;
            }
        }
 
        if (!swapped){
            break;
        }
            
        swapped = false;
 
        --end;
 
        for (int i = end - 1; i >= start; --i) {
            if (v[i] > v[i + 1]) {
                swap(v[i], v[i + 1]);
                swapped = true;
            }
        }
 
        ++start;
    }
}


///////////////////// Ejercicio 11 ////////////////////////////
// A) Cambia la posicion actual con la siguiente de manera creciente para cada posicion.
// B) 0 <= i < s.size() 
// C) 0 <= j < s.size() 
// D) El ultimo elemento sea menor al ante ultimo, pero caso es O(n^2)


///////////////////// Ejercicio 12 ////////////////////////////

void ej12A(vector<int> &v){ // O(n^2)
    
    bool sorted = false;

    while(!sorted){
        for(int j = v.size() - 1; j > 0; j--){
            if (v[j] < v[j-1]) {
                swap(v[j], v[j-1]);
            }
        }

        for(int j = v.size() - 1; j > 0; j--){
            if (v[j] < v[j-1]) {
                swap(v[j], v[j-1]);
            }
        }

        for(int i = 0; i < v.size() - 1; i++){
            if(v[i] > v[i+1]){
                sorted = false;
                break;
            } else {
                sorted = true;
            }
        }
    }
}


///////////////////// Ejercicio 13 ////////////////////////////
void ej13(){
    vector<int> a = {1,2,3,4,5};
    vector<int> b = {5,4,3,2,1};
    vector<int> c = {1,3,5,2,4};
    vector<int> d = {1,1,1,2,2,2};
    vector<int> e = {1, 2, 1, 2, 1, 2, 1, 2};
    vector<int> f = {1, 10, 50, 30, 25, 4, 6};


    // A 
    burbujeo(a);
    insercion(a);
    seleccion(a);

    // B 
    burbujeo(b);
    insercion(b);
    seleccion(b);

    // C
    burbujeo(c);
    insercion(c);
    seleccion(c);

    // D 
    burbujeo(d);
    insercion(d);
    seleccion(d);

    // E
    burbujeo(e);
    insercion(e);
    seleccion(e);

    // F
    burbujeo(f);
    insercion(f);
    seleccion(f);

}

void burbujeo(vector<int> &v){
    
    bool desordenado = true;

    while(desordenado){
        desordenado = false;
        
        for(int i = 0; i < v.size() - 1; i++){
            if(v[i] > v[i + 1]){
                swap(v[i], v[i+1]);
                desordenado = true;
            }
        }
    } 
}


void insercion(vector<int> &v){

    for(int i = 1; i < v.size(); i++){
        int key = v[i];
        int j = i - 1;

        while(j >= 0 && v[j] > key){
            v[j+1] = v[j];
            j--;
            v[j+1] = key;
        }
    }
}


void seleccion(vector<int> &v){

    for(int i = 0; i < v.size(); i++){
        int min = i;
        for(int j = i + 1; j < v.size(); j++){
            if(v[j] < v[min]){
                min = j;
            }
        }

        swap(v[min], v[i]);
    }
}


///////////////////// Ejercicio 14 ////////////////////////////
void ej14(vector<int> &v){
    bingoSort(v);
}

void bingoSort(vector<int> &v){

    vector<int> newVec;

    for(int i = 0; i < v.size(); i++){
        int ph = i;
        int min = i;
        for(int j = i + 1; j < v.size(); j++){
            if(v[j] < v[min]){
                min = j;
            }
        }

        for(int j = i + 1; j < v.size(); j++){
            if(v[j] == v[min]){
                swap(v[j], v[i]);
                i++;
            }
        }

        i = ph;
    }
}


///////////////////// Ejercicio 15 ////////////////////////////
// a) Burbujeo, en el peor caso lo recorre una vez para ver que este ordenado.
// b) Insercion, seria mas facil meter elementos dentro de una secuncia.
// c) selection sort, es ideal para buscar los minimos elementos de una secuencia.
// d) selection, buscaria el minimo de cada secuencia, luego los compaero e inerto el minimo en el tercer vector.
// e) selection sort seria el mas eficiente.
// f) selection sort, cambio min por max.
// g) buble sort, pues solo iteraria sobre los k desordenados.


///////////////////// Ejercicio 16 ////////////////////////////
void ejercicio16(vector<int> &v){
    
    int indiceDondeSeRompe;
    for(int i = 0; i < v.size() - 1; i++){
        if(v[i] > v[i+1]){
            indiceDondeSeRompe = i + 1;
        }
    }


    for(int i = indiceDondeSeRompe; i < v.size(); i++){
        int min = i;
        for(int j = i + 1; j < v.size(); j++){
            if(v[j] < v[min]){
                min = j;
            }
        }

        swap(v[min], v[i]);
    }
}


///////////////////// Ejercicio 17 ////////////////////////////
vector<int> ejercicio17(vector<int> a){

}

///////////////////// Ejercicio 18 ////////////////////////////
void ejercicio18(vector<int> &v){
    vector<int> s(v.size(), 0);

    for(int i = 0; i < v.size(); i++){
        s[v[i]-1]++;
    }

    v.clear();

    for(int i = s.size()-1; i >= 0; i--){
        if(s[i]  == 1){
            v.push_back(i+1);
        } else if(s[i] > 1){
            v.push_back(i+1);
            s[i]--;
            i++;
        }
    }
}
