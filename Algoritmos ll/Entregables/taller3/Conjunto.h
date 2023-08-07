#ifndef CONJUNTO_H_
#define CONJUNTO_H_

#include <assert.h>
#include <string>
#include <iostream>

using namespace std;

template <class T>
class Conjunto
{
public:
    Conjunto();
    ~Conjunto();
    void insertar(const T&);
    bool pertenece(const T&) const;
    void remover(const T&);
    const T& siguiente(const T& elem);
    const T& minimo() const;
    const T& maximo() const;
    unsigned int cardinal() const;
    void mostrar(std::ostream&) const;

private:
    struct Nodo
    {
        Nodo(const T& v) : valor(v), izq(nullptr), der(nullptr) {};
        T valor;
        Nodo* izq;
        Nodo* der; 
    };

    Nodo* _raiz;
    unsigned int numeroDeNodos;

    void liberarNodos(Nodo* raiz);
    void insertarNodo(Nodo* nodo);
    void moverNodo(Nodo* destino, Nodo* fuente);
    Nodo* getNodo(const T&) const;
    Nodo* getPadre(const T&) const;
    const T& _minimo(Nodo* raiz) const;
    const T& _maximo(Nodo* raiz) const;
};

template<class T>
std::ostream& operator<<(std::ostream& os, const Conjunto<T>& c) {
	 c.mostrar(os);
	 return os;
}

#include "Conjunto.hpp"

#endif // CONJUNTO_H_
