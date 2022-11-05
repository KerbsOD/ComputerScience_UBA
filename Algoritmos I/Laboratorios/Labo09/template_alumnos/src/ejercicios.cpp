#include "ejercicios.h"

/* Para compilar */ 

using namespace std;

vector<string> split(string s, char delim){

    vector<string> palabras;
    string miPalabra = "";

    for(int i = 0; i < s.size(); i++){

        if(s[i] != delim ){
            miPalabra.push_back(s[i]);
        }

        if(s[i] == delim || i == s.size() - 1){
            if(miPalabra.size() > 0){
                palabras.push_back(miPalabra);
                miPalabra.clear();
            }
        }
    }

    return palabras;
}


string darVueltaPalabra(string s){
    string res;

    vector<string> palabras = split(s, ' ');
    vector<string> palabrasDadasVuelta;

    for(int i = palabras.size()-1; i >= 0; i--){
        palabrasDadasVuelta.push_back(palabras[i]);
    }

    for(int i = 0; i < palabrasDadasVuelta.size(); i++){
        for(int j = 0; j < palabrasDadasVuelta[i].size(); j++){
            res.push_back(palabrasDadasVuelta[i][j]);
        }
        if(i != palabrasDadasVuelta.size()-1){
            res.push_back(' ');
        }
    }


    return res;
}

// Decidir si s1 es substring o subsecuencia de s2
bool subsecuencia(string s1, string s2) {

    int j = 0;

    for(int i = 0; i < s2.size(); i++){
        if(j < s1.size() && s1[j] == s2[i]){
            j++;
        }
    }

    return(s1.size() == j);

}

// Mismo orden relativo de conjunto de anagramas y dentro de cada vector y con repetidos
vector<vector<string> > agruparAnagramas(vector<string> v){
	vector<vector<string> > res;

    vector<string> listaDeAnagramas;



    for(int i = 0; i < v.size(); i++){
        for(int j = 0; j < v.size(); j++){
            if (esAnagrama(v[i], v[j]) && !pertenece(v[j], res)){
                listaDeAnagramas.push_back(v[j]);
            }
        }
        if(listaDeAnagramas.size() != 0){
            res.push_back(listaDeAnagramas);
        }
        listaDeAnagramas.clear();
    }

                 // {"ab", "cd", "ef", "ba", "ab", "dc"}
	return res; // {{"ab", "ba", "ab"}, {"cd", "dc"}, {"ef"}}

}

bool pertenece(string s, vector<vector<string>> v){

    bool pertenece = false;

    for(int i = 0; i < v.size(); i++){
        for(int j = 0; j < v[i].size(); j++){
            if(v[i][j] == s) {
                pertenece = true;
            }
        }
    }

    return pertenece;
}



bool esAnagrama(string s, string t) {

    bool anagrama = true;

    for(int i = 0; i < s.size(); i++){
        anagrama = anagrama && cantidadApariciones(s, s[i]) == cantidadApariciones(t, s[i]);
    }

    return anagrama;
}

int cantidadApariciones(string s, char x) {
    int cantidad = 0;

    for(int i = 0; i < s.size(); i++){
        if (s[i] == x) {
            cantidad++;
        }
    }

    return cantidad;
}


bool esPalindromo(string s){

    string palabraRotada;

    for(int i = s.size()-1; i >= 0; i--){
        palabraRotada.push_back(s[i]);
    }

    return s == palabraRotada;
}

bool tieneRepetidos(string s){
	bool distinto = true;

    for(int i = 0; i < s.size(); i++){
        if(cantidadApariciones(s, s[i]) > 1){
            return true;
        }
    }
	return !distinto;
}

string rotar(string s, int j) {

    string t = s;

    while(j > s.size()){
        j = j - s.size();
    }

    for(int i = 0; i < s.size(); i++){
        t[i] = s[(s.size() - j + i) % s.size()];
    }

    return t;
}

// no se puede usar substring
string darVueltaK(string s, int k){
	string res;

    for(int i = 0; i < s.size(); i = i + k){ //PERFECTO

        string placeholder;

        if(s.size() - i < k){

            for(int j = i; j < s.size(); j++){
                placeholder.push_back(s[j]);
            }

            string stringRotado = rotarPalabra(placeholder);

            for(int f = 0; f < stringRotado.size(); f++){
                res.push_back(stringRotado[f]);
            }

            placeholder.clear();

        } else {
            for(int j = i; j < i + k ; j++){
                placeholder.push_back(s[j]);
            }

            string stringRotado = rotarPalabra(placeholder);

            for(int f = 0; f < stringRotado.size(); f++){
                res.push_back(stringRotado[f]);
            }

            placeholder.clear();
        }

    }


	return res;
}

string rotarPalabra(string s){
    string res;
    for(int i = s.size()-1; i >= 0; i--){
        res.push_back(s[i]);
    }
    return res;
}

string abueloLaino(string s){
    string res;

    if (cantidadApariciones(s, 'i') >= 1){
        res = "N";
    } else {
        res = "S";
    }
    return res;
}

int cantidadDeFelicitaciones(vector<string> v){
    int res;


    return res;
}

int middleOut(string s, string t){

    return 0;
}
