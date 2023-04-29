#include <vector>
#include "algobot.h"

using namespace std;

// Ejercicio 1
vector<int> quitar_repetidos(vector<int> s) {
    set<int> sr;
    vector<int> ssr;
    for(auto num : s) {
        sr.insert(num);
    }
    for(auto e : sr) {
        ssr.push_back(e);
    }
    
    return ssr;
}

// Ejercicio 2
vector<int> quitar_repetidos_v2(vector<int> s) {
    set<int> sr;
    vector<int> ssr;
    for(auto num : s) {
        sr.insert(num);
    }
    for(auto e : sr) {
        ssr.push_back(e);
    }
    
    return ssr;
}

// Ejercicio 3
bool mismos_elementos(vector<int> a, vector<int> b) {
    set<int> ma, mb;
    for(int num : a) {
        ma.insert(num);
    }
    for(int num : b) {
        mb.insert(num);
    }
    return ma == mb;
}

// Ejercicio 4
bool mismos_elementos_v2(vector<int> a, vector<int> b) {
    set<int> ma, mb;
    for(int num : a) {
        ma.insert(num);
    }
    for(int num : b) {
        mb.insert(num);
    }
    return ma == mb;
}

// Ejercicio 5
map<int, int> contar_apariciones(vector<int> s) {
    map<int, int> m;
    for(int num : s) {
        m[num]++;
    }
    return m;
}

// Ejercicio 6
vector<int> filtrar_repetidos(vector<int> s) {
    map<int,int> m = contar_apariciones(s);
    vector<int> t;
    for(auto it : m) {
        if(it.first == 1) {
            t.push_back(it.second);
        }
    }
    return t;
}

// Ejercicio 7
set<int> interseccion(set<int> a, set<int> b) {
    return set<int>();
}

// Ejercicio 8
map<int, set<int>> agrupar_por_unidades(vector<int> s) {
    return map<int, set<int>>();
}

// Ejercicio 9
vector<char> traducir(vector<pair<char, char>> tr, vector<char> str) {
    return vector<char>();
}

// Ejercicio 10
bool integrantes_repetidos(vector<Mail> s) {
    return true;
}

// Ejercicio 11
map<set<LU>, Mail> entregas_finales(vector<Mail> s) {
  return map<set<LU>, Mail>();
}
