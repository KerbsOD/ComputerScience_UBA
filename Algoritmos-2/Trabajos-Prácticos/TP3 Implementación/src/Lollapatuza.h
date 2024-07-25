#ifndef TP_LOLLA_LOLLAPATUZA_H
#define TP_LOLLA_LOLLAPATUZA_H

#include "tipos.h"
#include "Puesto.h"

class Lollapatuza {
public:
    Lollapatuza(const set<Persona> &personas, const map<IdPuesto, Puesto> &infoPuestos);

    // Generadores.
    void Vender(IdPuesto idpuesto, Persona persona, Producto item, Nat cantidad);
    void Hackear(Persona persona, Producto item);

    // Observadores.
    Nat getGastoTotal(Persona persona) const;
    Persona getMasGasto() const;
    IdPuesto getMenorStock(Producto item) const;
    const set<Persona>& getPersonas() const;
    const set<IdPuesto>& getPuestos() const;
    static Nat aplicarDescuento(Nat precio, Nat cantidad, Nat descuento);

    // Observadores Puesto.
    Nat getStock (IdPuesto idPuesto, Producto item) const;
    Nat getDescuento (IdPuesto idPuesto, Producto item, Nat cantidad) const;
    Nat getgastoEnPuesto (IdPuesto idPuesto, Persona persona) const;
    Nat getPrecio (Producto item) const;

private:
    set<IdPuesto>                                               m_puestosID;
    set<Persona>                                                m_personasID;
    map<IdPuesto, PuestoDeComida>                               m_puestosPorID;
    map<Persona, PersonaINFO>                                   m_personasPorID;
    map<PersonaINFO, Persona>                                   m_personasGasto;
    map<Persona, map<Producto,map<IdPuesto, PuestoDeComida*>>>  m_comprasSinPromocion;
};

#endif
