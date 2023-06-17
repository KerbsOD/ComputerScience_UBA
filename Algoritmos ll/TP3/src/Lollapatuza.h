#ifndef TP_LOLLA_LOLLAPATUZA_H
#define TP_LOLLA_LOLLAPATUZA_H

#include "tipos.h"
#include "Puesto.h"

using Puestos = map<IdPuesto, PuestoDeComida*>;

class Lollapatuza {
public:
    Lollapatuza(Puestos puestos, Personas personas);
    void Vender(IdPuesto idpuesto, Persona persona, Producto item, Nat cantidad);
    void Hackear(Persona persona, Producto item);
    Nat GastoTotal(Persona persona);
    Persona MasGasto();
    IdPuesto MenorStock(Producto item);
    Personas& ObtenerPersonas();
    Puestos& ObtenerPuestos();

private:
    struct ClienteINFO {
        Nat gastoTotal;
        map<Producto, Puestos> ComprasSinPromocion;
        /* El arbol se recorre inOrder, el menorID es un puntero al puesto donde
         * el cliente compro el item dado sin descuento.
         * Preguntamos la cantidad, si la cantidad es 0, entonces no es hackeable y lo eliminamos del arbol
         * en O(log(P)). Necesitamos saber la cantidad comprada en el puesto. (Lo hacemos en el puesto).
         * */
    };

    Puestos  m_Puestos;
    Personas m_Personas;
    map<Persona, ClienteINFO> m_Clientes;
    Persona PersonaQueMasGasto;
};



#endif //TP_LOLLA_LOLLAPATUZA_H
