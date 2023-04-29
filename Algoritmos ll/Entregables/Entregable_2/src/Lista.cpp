#include "Lista.h"
#include <cassert>

Lista::Lista() : primerNodo_(nullptr), ultimoNodo_(nullptr), longitud_(0) {}

Lista::Lista(const Lista& l) : Lista() {
    *this = l;
}

Lista::~Lista() {
    eliminarNodos();
}

Lista& Lista::operator=(const Lista& aCopiar) {
    eliminarNodos();
    resetearPointers();
    clonarLista(aCopiar); // No le puse de nombre "copiarLista" porque queremos crear una lista nueva, no copiar los pointers.
    return *this;
}

void Lista::agregarAdelante(const int& elem) { 
    Nodo* nuevoNodoAlInicio = new Nodo(nullptr, elem, primerNodo_);
    if(longitud_ == 0) {
        agregarPrimerNodoDeLaLista(nuevoNodoAlInicio);
    } else {
        primerNodo_->anterior = nuevoNodoAlInicio;
        primerNodo_ = nuevoNodoAlInicio;
    }
    longitud_++;
}

void Lista::agregarAtras(const int& elem) { 
    Nodo* nuevoNodoAlFinal = new Nodo(ultimoNodo_, elem, nullptr);
    if(longitud_ == 0) {
        agregarPrimerNodoDeLaLista(nuevoNodoAlFinal);
    } else {
        ultimoNodo_->siguiente = nuevoNodoAlFinal;
        ultimoNodo_ = nuevoNodoAlFinal;
    }
    longitud_++;
}
   
void Lista::eliminar(Nat i) { 
    Nodo* temp;
    if(i == 0) {
        temp = primerNodo_;
        if(this->longitud() <= 1) {
            primerNodo_ = nullptr;
        } else {
            primerNodo_ = primerNodo_->siguiente;
            primerNodo_->anterior = nullptr;
        }
    } else if (i == this->longitud()-1){
        temp = ultimoNodo_;
        if(this->longitud() <= 1) {
            ultimoNodo_ = nullptr;
        } else {
            ultimoNodo_ = ultimoNodo_->anterior;
            ultimoNodo_->siguiente = nullptr;
        }
    } else {
        temp = primerNodo_;
        while(i > 0) {
            temp = temp->siguiente;
            i--;
        }
        temp->anterior->siguiente = temp->siguiente;
        temp->siguiente->anterior = temp->anterior;
    }
    delete temp;
    longitud_--;
}

int Lista::longitud() const {
    return longitud_;
}

const int& Lista::iesimo(Nat i) const { 
    Nodo* temp = primerNodo_;
    while(i > 0) {
        temp = temp->siguiente;
        i--;
    }   
    return temp->valor;
}

int& Lista::iesimo(Nat i) { 
    Nodo* temp = primerNodo_;
    while(i > 0) {
        temp = temp->siguiente;
        i--;
    }   
    return temp->valor;
}

void Lista::mostrar(ostream& o) {
    Nodo* temp = primerNodo_; 
    while(temp != nullptr) {
        o << temp->valor;
        temp = temp->siguiente;
    }
}

void Lista::eliminarNodos() {
    Nodo* nodoActual = primerNodo_;
    while(nodoActual != nullptr) {
        primerNodo_ = primerNodo_->siguiente;
        delete nodoActual;
        nodoActual = primerNodo_;
    }
    longitud_ = 0;
}

void Lista::clonarLista(const Lista& aCopiar) {
    Nodo* nodoActual = aCopiar.primerNodo_;
    while(nodoActual != nullptr) {
        agregarAtras(nodoActual->valor);
        nodoActual = nodoActual->siguiente;
    }
}

void Lista::agregarPrimerNodoDeLaLista(Nodo* nuevoNodo) {
    primerNodo_ = nuevoNodo;
    ultimoNodo_ = nuevoNodo;
}

void Lista::resetearPointers() {
    primerNodo_ = nullptr;
    ultimoNodo_ = nullptr;
}