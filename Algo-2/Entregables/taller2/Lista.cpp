#include "Lista.h"
#include <cassert>

Lista::Lista() : _primero(nullptr), _ultimo(nullptr) {
}

Lista::Lista(const Lista& l) : Lista() {
    //Inicializa una lista vacía y luego utiliza operator= para no duplicar el código de la copia de una lista.
    *this = l;
}

Lista::~Lista() {
    // Completar
    eliminarNodos(_primero);
}

void Lista::eliminarNodos(Nodo* root) {
    if(root != nullptr) {
        eliminarNodos(root->siguiente);
        delete root;
    }
}

Lista& Lista::operator=(const Lista& aCopiar) {
    // Completar
    eliminarNodos(_primero);
    _primero  = nullptr;
    _ultimo = nullptr;
    Nodo* temp = aCopiar._primero;
    while(temp != nullptr) {
        this->agregarAtras(temp->valor);
        temp = temp->siguiente;
    }
    return *this;
}

void Lista::agregarAdelante(const int& elem) { // No tengo pre
    // Completar
    Nodo* nuevoNodoAlInicio = new Nodo(elem, nullptr, _primero);
    if(this->longitud() == 0) {
        _primero = nuevoNodoAlInicio;
        _ultimo = nuevoNodoAlInicio;
    } else {
        _primero->anterior = nuevoNodoAlInicio;
        _primero = nuevoNodoAlInicio;
    }
}

void Lista::agregarAtras(const int& elem) { // No tengo pre
    // Completar
    Nodo* nuevoNodoAlFinal = new Nodo(elem, _ultimo, nullptr);
    if(this->longitud() == 0) {
        _primero = nuevoNodoAlFinal;
        _ultimo = nuevoNodoAlFinal;
    } else {
        _ultimo->siguiente = nuevoNodoAlFinal;
        _ultimo = nuevoNodoAlFinal;
    }
}
   

void Lista::eliminar(Nat i) { // No tengo pre
    if(i == 0) {
        Nodo* temp = _primero;
        if(this->longitud() <= 1) {
            _primero = nullptr;
        } else {
            _primero = _primero->siguiente;
            _primero->anterior = nullptr;
        }
        delete temp;
    } else if (i == this->longitud()-1){
        Nodo* temp = _ultimo;
        if(this->longitud() <= 1) {
            _ultimo = nullptr;
        } else {
            _ultimo = _ultimo->anterior;
            _ultimo->siguiente = nullptr;
        }
        delete temp;
    } else {
        Nodo* temp = _primero;
        while(i > 0) {
            temp = temp->siguiente;
            i--;
        }
        temp->anterior->siguiente = temp->siguiente;
        temp->siguiente->anterior = temp->anterior;
        delete temp;
    }
}

int Lista::longitud() const {
    int cantidad = 0;
    Nodo* temp = _primero; 
    while(temp != nullptr) {
        cantidad++;
        temp = temp->siguiente;
    }
    return cantidad;
}

const int& Lista::iesimo(Nat i) const { // No tengo pre
    Nodo* temp = _primero;
    while(i > 0) {
        temp = temp->siguiente;
        i--;
    }   
    return temp->valor;
}

int& Lista::iesimo(Nat i) { // No tengo pre
    Nodo* temp = _primero;
    while(i > 0) {
        temp = temp->siguiente;
        i--;
    }   
    return temp->valor;
}

void Lista::mostrar(ostream& o) {
    // Completar
    Nodo* temp = _primero; 
    while(temp != nullptr) {
        o << temp->valor;
        temp = temp->siguiente;
    }
}