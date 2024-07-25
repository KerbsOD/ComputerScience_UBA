template <typename T>
string_map<T>::string_map() : _size(0), raiz(new Nodo()) {
    // COMPLETAR
}

template <typename T>
string_map<T>::string_map(const string_map<T>& aCopiar) : string_map() { 
    *this = aCopiar; 
} // Provisto por la catedra: utiliza el operador asignacion para realizar la copia.

template <typename T>
string_map<T>& string_map<T>::operator=(const string_map<T>& d) {
    // COMPLETAR
    eliminarNodos(raiz);
    raiz = new Nodo();
    for (auto c : d.claves) {
        insert(make_pair(c, *d.getDefinition(c)));
    }
    return *this;
}

template <typename T>
string_map<T>::~string_map(){
    // COMPLETAR
    eliminarNodos(raiz);
}

template <typename T>
void string_map<T>::insert(const pair<string, T>& par){
    // COMPLETAR
    Nodo* actual = raiz;
    for (char c : par.first) {
        if (actual->siguientes[c] == nullptr) {
            actual->siguientes[c] = new Nodo();
        }
        actual = actual->siguientes[c];
    }
    
    if (actual->definicion == nullptr) {
        actual->definicion = new T(par.second);
        claves.insert(par.first);
        _size++;
    } else {
        *actual->definicion = par.second;
    }
}


template <typename T>
int string_map<T>::count(const string& clave) const{
    // COMPLETAR
    Nodo* temp = raiz;
    for (char c : clave) {
        if (temp->siguientes[c] == nullptr) {
            return 0;
        }
        temp = temp->siguientes[c];
    }
    
    if (temp == nullptr) {
        return 0;
    }
    
    return temp->definicion != nullptr;
}

template <typename T>
const T& string_map<T>::at(const string& clave) const {
    // COMPLETAR
    return *(getDefinition(clave));
}

template <typename T>
T& string_map<T>::at(const string& clave) {
    // COMPLETAR
    return *(getDefinition(clave));
}

template <typename T>
void string_map<T>::erase(const string& clave) {
    // COMPLETAR
    Nodo* actual = raiz;
    Nodo* ultimoNodoUtil = raiz;
    int index = 0;

    for (int i = 0; i < clave.size(); i++) {
        actual = actual->siguientes[clave[i]];
        if (cantidadDeHijos(actual) > 1 || (cantidadDeHijos(actual) == 1 && actual->definicion != nullptr)) {
            ultimoNodoUtil = actual;
            index = i;
        }
    }
    delete actual->definicion;
    actual->definicion = nullptr;

    index++;
    Nodo* siguiente = ultimoNodoUtil->siguientes[clave[index]];
    eliminarNodos(siguiente);
    ultimoNodoUtil->siguientes[clave[index]] = nullptr;

    claves.erase(clave);
    _size--;
}

template <typename T>
int string_map<T>::size() const{
    // COMPLETAR
    return _size;
}

template <typename T>
bool string_map<T>::empty() const{
    // COMPLETAR
    return _size == 0;
}


// AUXILIARES

template <typename T>
T* string_map<T>::getDefinition(const string &clave) const {
    Nodo* temp = raiz;
    for (char c : clave) {
        if (temp == nullptr) {
            return nullptr;
        }
        temp = temp->siguientes[c];
    }
    return temp->definicion;
}

template <typename T>
void string_map<T>::eliminarNodos(Nodo* root) {
    if (root != nullptr) {
        for (Nodo* hijo : root->siguientes) {
            eliminarNodos(hijo);
            hijo = nullptr;
        }
        if (root->definicion != nullptr) {
            delete root->definicion;
            root->definicion = nullptr;
        }
        delete root;
    }
}

template <typename T>
int string_map<T>::cantidadDeHijos(Nodo* nodo) {
    int nodosNoNulos = 0;
    for (Nodo* hijo : nodo->siguientes) {
        if (hijo != nullptr) {
            nodosNoNulos++;
        }
    }
    return nodosNoNulos;
}




















