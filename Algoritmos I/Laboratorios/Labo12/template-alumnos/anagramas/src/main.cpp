
#include "anagramas.h"
using namespace std;

int main(){
    string palabra, palabra2;
    cout << "Ingrese una palabra en ingles con letras en minuscula:" << endl;
    cin >> palabra;

    ifstream dicci ("ingles.dic");
    vector<string> listaPalabras;
    string word;
    while(getline(dicci, word)){
        listaPalabras.push_back(word);
    }
    int cantidadAnagrama = 0;
    for (int i = 0; i < listaPalabras.size(); ++i)
    {
        if (esAnagrama(listaPalabras[i], palabra)) {
            cout << "Son anagramas: " << listaPalabras[i] << " y " << palabra << endl;
            cantidadAnagrama++;
        }
    }
    cout << "La cantidad de anagramas es: " << cantidadAnagrama << endl;
    return 0;
}

bool esAnagrama(string p1, string p2){
    // CAMBIAR AQUI QUE IMPLEMENTACION USAR
    return esAnagrama2(p1,p2);
}

bool esAnagrama1(string p1, string p2){
    //devuelve true sii p1 es anagrama de p2
    //esta versión usa ordenar
    ordenarString(p1);
    ordenarString(p2);
    return p1 == p2;
}

bool esAnagrama2(string p1, string p2){
    //COMPLETAR
    //devuelve true sii p1 es anagrama de p2
    //esta versión usa el mapeo de letras a números primos. Utilizar charToPrimo()

    if(p1.size() != p2.size()){
        return false;
    }

    int m1 = 1;
    int m2 = 1;
    for(int i = 0; i < p1.size(); i++){
        m1 = m1 * charToPrimo(p1[i]);
        m2 = m2 * charToPrimo(p2[i]);
    }

	return m1 == m2;
}

void ordenarString(string &palabra){
    //COMPLETAR
    //Asumir que palabra solo contiene letras minusculas de a-z (sin enie). Implementar cualquier algoritmo
    vector<int> asc(128, 0);
    vector<int> numeros;

    for(int i = 0; i < palabra.size(); i++){ // O(n)
        int a = palabra[i];
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

    palabra.clear();

    for(int i = 0; i < numeros.size(); i++){
        if(numeros[i] == 32){
            continue;
        } else {
            palabra.push_back(numeros[i]);
        }
    }

}


int charToPrimo(char ch){
    switch (ch) {
        case 'a':
            return 2;
        case 'b':
            return 3;
        case 'c':
            return 5;
        case 'd':
            return 7;
        case 'e':
            return 11;
        case 'f':
            return 13;
        case 'g':
            return 17;
        case 'h':
            return 19;
        case 'i':
            return 23;
        case 'j':
            return 29;
        case 'k':
            return 31;
        case 'l':
            return 37;
        case 'm':
            return 41;
        case 'n':
            return 33;
        case 'o':
            return 47;
        case 'p':
            return 53;
        case 'q':
            return 59;
        case 'r':
            return 61;
        case 's':
            return 67;
        case 't':
            return 71;
        case 'u':
            return 73;
        case 'v':
            return 79;
        case 'w':
            return 83;
        case 'x':
            return 89;
        case 'y':
            return 97;
        case 'z':
            return 101;
    }

    return 0;
}

int posicionEnAlfabeto(char c){

}
