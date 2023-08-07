
template <class T>
Conjunto<T>::Conjunto() :
    numeroDeNodos(0), 
    _raiz(nullptr) {
}

template <class T>
Conjunto<T>::~Conjunto() { 
    liberarNodos(_raiz);
}

template <class T>
bool Conjunto<T>::pertenece(const T& clave) const {
    return getNodo(clave) != nullptr;
}

template <class T>
void Conjunto<T>::insertar(const T& clave) {
    if (!pertenece(clave)) {
        Nodo* nodo = new Nodo(clave);
        insertarNodo(nodo);
        numeroDeNodos++;
    }
}

template <class T>
void Conjunto<T>::remover(const T& clave) {
    Nodo* nodo = getNodo(clave);

    if (nodo->izq == nullptr) {
        moverNodo(nodo, nodo->der);
    } else if (nodo->der == nullptr) {
        moverNodo(nodo, nodo->izq);
    } else {
        Nodo* sucesorDelNodo = getNodo(siguiente(nodo->valor));
        sucesorDelNodo->izq = nodo->izq;
        Nodo* padreDeNodo = getPadre(nodo->valor);
        if (padreDeNodo == nullptr) {
            _raiz = nodo->der;
        } else if (padreDeNodo->der == nodo) {
            padreDeNodo->der = nodo->der;
        } else {
            padreDeNodo->izq = nodo->der;
        }
    }
    numeroDeNodos--;
    delete nodo;

    // _raiz = eliminarNodo(_raiz, clave);
    // delete getNodo(clave); // EL problema esta aca, cuando elimino el nodo pierdo la referencia!!!!
    // numeroDeNodos--;
    // // Eliminar memoria del nodo borrado!!!
}

template <class T>
const T& Conjunto<T>::siguiente(const T& clave) {
    Nodo* nodo = getNodo(clave);
    if (nodo->der != nullptr) {
        return _minimo(nodo->der);
    }   

    Nodo* padre = getPadre(clave);
    while (padre != nullptr && nodo == padre->der) {
        nodo = padre;
        padre = getPadre(padre->valor);
    }
    return padre->valor;
}

template <class T>
const T& Conjunto<T>::minimo() const {
    return _minimo(_raiz);
}

template <class T>
const T& Conjunto<T>::maximo() const {
    return _maximo(_raiz);
}

template <class T>
unsigned int Conjunto<T>::cardinal() const {
    return numeroDeNodos;
}


// -------------------- AUXILIARES -------------------- //


template<class T>
void Conjunto<T>::liberarNodos(Nodo* raiz) {
    if (raiz != nullptr) {
        liberarNodos(raiz->izq);
        liberarNodos(raiz->der);
        delete raiz;
    }
}

template<class T>
typename::Conjunto<T>::Nodo* Conjunto<T>::getNodo(const T& clave) const {
    Nodo* temp = _raiz;
    while (temp != nullptr && temp->valor != clave) {
        if (clave < temp->valor) {
            temp = temp->izq;
        } else {
            temp = temp->der;
        }
    }
    return temp;
}

template<class T>
typename::Conjunto<T>::Nodo* Conjunto<T>::getPadre(const T& clave) const {
    Nodo* temp = _raiz;
    Nodo* padre = nullptr;
    while (temp != nullptr && temp->valor != clave) {
        padre = temp;
        if (clave < temp->valor) {
            temp = temp->izq;
        } else {
            temp = temp->der;
        }
    }
    return padre;
}

template<class T>
void Conjunto<T>::insertarNodo(Nodo* nodo) {
    Nodo* temp = _raiz;
    Nodo* padre = nullptr;
    while (temp != nullptr) {
        padre = temp;
        if (nodo->valor < temp->valor) {
            temp = temp->izq;
        } else {
            temp = temp->der;
        }
    }

    if(padre == nullptr) {
        _raiz = nodo;
    } else if (nodo->valor < padre->valor) {
        padre->izq = nodo;
    } else {
        padre->der = nodo;
    }
}

template<class T>
void Conjunto<T>::moverNodo(Nodo* destino, Nodo* fuente) {
    Nodo* padre = getPadre(destino->valor);
    if (padre == nullptr) {
        _raiz = fuente;
    } else if (destino == padre->izq) {
        padre->izq = fuente;    
    } else {
        padre->der = fuente;
    }
}


template<class T>
const T& Conjunto<T>::_minimo(Nodo* raiz) const {
    Nodo* temp = raiz;
    while (temp->izq != nullptr) {
        temp = temp->izq;
    }
    return temp->valor;
}

template <class T>
const T& Conjunto<T>::_maximo(Nodo* raiz) const {
    Nodo* temp = raiz;
    while (temp->der != nullptr) {
        temp = temp->der;
    }
    return temp->valor;
}