#ifndef _LISTA_ALUMNOS_H_
#define _LISTA_ALUMNOS_H_

#include <string>
#include <ostream>

using namespace std;

typedef unsigned long Nat;

class Lista {
public:
    Lista();
    Lista(const Lista& l);
    ~Lista();

    void agregarAdelante(const int& elem);
    void agregarAtras(const int& elem);
    void eliminar(Nat i);
    int longitud() const;    
    const int& iesimo(Nat i) const;
    int& iesimo(Nat i);
    void mostrar(ostream& o);

    Lista& operator=(const Lista& aCopiar);
    friend ostream& operator<<(ostream& os, Lista& l) {
        l.mostrar(os);
        return os;
    }

private:
    struct Nodo {
        int valor;
        Nodo* anterior;
        Nodo* siguiente;
        Nodo(Nodo* anterior_, int v, Nodo* siguiente_) : anterior(anterior_), valor(v), siguiente(siguiente_) {}
    };
    
    Nodo* primerNodo_;
    Nodo* ultimoNodo_;
    int longitud_;
    
    void eliminarNodos();
    void resetearPointers();
    void clonarLista(const Lista& aCopiar);
    void agregarPrimerNodoDeLaLista(Nodo* nuevoNodo);
};

#endif              