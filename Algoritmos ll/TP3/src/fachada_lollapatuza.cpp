#include "fachada_lollapatuza.h"

FachadaLollapatuza::FachadaLollapatuza(const set<Persona> &personas, const map<IdPuesto, Puesto> &infoPuestos) :
lolla(personas, infoPuestos) {
        
}

void FachadaLollapatuza::registrarCompra(Persona persona, Producto producto, Nat cant, IdPuesto idPuesto) {
    lolla.Vender(idPuesto, persona, producto, cant);
}

void FachadaLollapatuza::hackear(Persona persona, Producto producto) {
   lolla.Hackear(persona, producto);
}

Nat FachadaLollapatuza::gastoTotal(Persona persona) const {
   return lolla.getGastoTotal(persona);
}

Persona FachadaLollapatuza::mayorGastador() const {
    return lolla.getMasGasto();
}

IdPuesto FachadaLollapatuza::menorStock(Producto producto) const {
    return lolla.getMenorStock(producto);
}

const set<Persona> &FachadaLollapatuza::personas() const {
    return lolla.getPersonas();
}

Nat FachadaLollapatuza::stockEnPuesto(IdPuesto idPuesto, const Producto &producto) const {
    return lolla.getStock(idPuesto, producto);
}

Nat FachadaLollapatuza::descuentoEnPuesto(IdPuesto idPuesto, const Producto &producto, Nat cantidad) const {
    return lolla.getDescuento(idPuesto, producto, cantidad);
}

Nat FachadaLollapatuza::gastoEnPuesto(IdPuesto idPuesto, Persona persona) const {
    return lolla.getgastoEnPuesto(idPuesto, persona);
}

set<IdPuesto> FachadaLollapatuza::idsDePuestos() const {
    return lolla.getPuestos();
}