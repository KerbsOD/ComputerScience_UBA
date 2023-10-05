#include <vector>
#include <map>
#include "Diccionario.hpp"

using namespace std;

template<class T>
class Multiconjunto {
public:
    Multiconjunto();
    void agregar(T x);
    int ocurrencias(T x);
    bool operator<=(Multiconjunto<T> otro) const;

private:
    map<T, int> elementos;
};


template<class T>
Multiconjunto<T>::Multiconjunto() {

}

template<class T>
void Multiconjunto<T>::agregar(T x) {
    elementos[x]++;
}

template<class T>
int Multiconjunto<T>::ocurrencias(T x) {
    return elementos[x];
}

template<class T>
bool Multiconjunto<T>::operator<=(Multiconjunto<T> otro) const {
    for(auto elemento : elementos) {
        if(elemento.second > otro.ocurrencias(elemento.first)) {
            return false;
        }
    }
    return true;
}