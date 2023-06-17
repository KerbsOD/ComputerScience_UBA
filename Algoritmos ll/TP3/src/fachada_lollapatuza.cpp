#include "fachada_lollapatuza.h"


FachadaLollapatuza::FachadaLollapatuza(const set<Persona> &personas, const map<IdPuesto, aed2_Puesto> &infoPuestos) {
    // TODO: Completar
}

void FachadaLollapatuza::registrarCompra(Persona persona, Producto producto, Nat cant, IdPuesto idPuesto) {
    // TODO: Completar
}

void FachadaLollapatuza::hackear(Persona persona, Producto producto) {
    // TODO: Completar
}

Nat FachadaLollapatuza::gastoTotal(Persona persona) const {
    // TODO: Completar
}

Persona FachadaLollapatuza::mayorGastador() const {
    // TODO: Completar
}

IdPuesto FachadaLollapatuza::menorStock(Producto producto) const {
   // TODO: Completar
}

const set<Persona> &FachadaLollapatuza::personas() const {
    // TODO: Completar
}

Nat FachadaLollapatuza::stockEnPuesto(IdPuesto idPuesto, const Producto &producto) const {
    // TODO: Completar
}

Nat FachadaLollapatuza::descuentoEnPuesto(IdPuesto idPuesto, const Producto &producto, Nat cantidad) const {
    // TODO: Completar
}

Nat FachadaLollapatuza::gastoEnPuesto(IdPuesto idPuesto, Persona persona) const {
    // TODO: Completar
}

set<IdPuesto> FachadaLollapatuza::idsDePuestos() const {
    // TODO: Completar
}