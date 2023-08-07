#ifndef SOLUCION_TIPOS_H
#define SOLUCION_TIPOS_H

#include <string>
#include <map>
#include <set>
#include <queue>
#include <list>

using namespace std;

using Persona = int;
using IdPuesto = unsigned int;
using Producto = unsigned int;
using Nat = unsigned int;
using Stock = map<Producto, Nat>;
using Promociones = map<Producto, map<Nat, Nat>>;
using Menu = map<Producto, Nat>;

struct Puesto {
    Stock stock;
    Promociones promociones;
    Menu menu;
};

// Auxiliares

// Exclusivo de Lolla.
struct PersonaINFO {
    Persona personaID;
    Nat gastoTotal;

    PersonaINFO() : personaID(0), gastoTotal(0) {}
    PersonaINFO(Persona a) : personaID(a), gastoTotal(0) {}

    const bool operator<(const PersonaINFO &b) const {
        if (gastoTotal < b.gastoTotal) {
            return true;
        } 
        if (gastoTotal == b.gastoTotal && personaID > b.personaID) {
            return true;
        }
        return false;
    }   
};

// Exclusivo de puesto
struct ClienteINFO {
    Nat gastoEnPuesto;
    map<Producto, Nat> cantidadCompradaSinPromocion;
    
    ClienteINFO() : gastoEnPuesto(0), cantidadCompradaSinPromocion() {}
};

/* Complejidades:
    - A las personas en el lollapatuza.
    - I la cantidad de items del menu.
    - P la cantidad de puestos en el lollapatuza.
    - cant la maxima cantidad con descuento de un determinado item.
*/
#endif //SOLUCION_TIPOS_H
