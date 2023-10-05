template<class T>
T cuadrado(T x) {
    return x*x;
}

template<class Contenedor, class Elem>
bool contiene(Contenedor s, Elem e) {
    for(int i = 0; i < s.size(); i++) {
        if(s[i] == e) {
            return true;
        }
    }
    return false;
}

template<class Contenedor>
bool esPrefijo(Contenedor a, Contenedor b) {
    if(a.size() > b.size()) {
        return false;
    }

    for(int i = 0; i < a.size(); i++) {
        if(a[i] != b[i]) {
            return false;
        }
    }

    return true;
}


template<class Contenedor, class Elem>
Elem maximo(Contenedor c) {
    Elem max = c[0];
    for(int i = 1; i < c.size(); i++) {
        if(max < c[i]) {
            max = c[i];
        }
    }
    return max;
}

