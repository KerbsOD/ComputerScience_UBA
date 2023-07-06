#ifndef FACHADA_LOLLAPATUZA_H
#define FACHADA_LOLLAPATUZA_H

#include "tipos.h"
#include "Lollapatuza.h"

class FachadaLollapatuza {
public:
    FachadaLollapatuza(const set<Persona> &personas, const map<IdPuesto, Puesto> &infoPuestos);
    void registrarCompra(Persona persona, Producto producto, Nat cant, IdPuesto idPuesto);
    void hackear(Persona persona, Producto producto);
    Nat gastoTotal(Persona persona) const;
    Persona mayorGastador() const;
    IdPuesto menorStock(Producto producto) const;
    const set<Persona> &personas() const;
    Nat stockEnPuesto(IdPuesto idPuesto, const Producto &producto) const;
    Nat descuentoEnPuesto(IdPuesto idPuesto, const Producto &producto, Nat cantidad) const;
    Nat gastoEnPuesto(IdPuesto idPuesto, Persona persona) const;
    set<IdPuesto> idsDePuestos() const;

private:
    Lollapatuza lolla;
};

#endif
