#include "Lollapatuza.h"

Lollapatuza::Lollapatuza(Puestos puestos, Personas personas)
    : m_Personas(personas), m_Puestos(puestos)
{

}

void Lollapatuza::Vender(IdPuesto idpuesto, Persona persona, Producto item, Nat cantidad) {
    Nat precio = m_Puestos[idpuesto]->ObtenerPrecio(item); // O(log(P)) + O(log(I))
    Nat descuento = m_Puestos[idpuesto]->ObtenerPromocion(item, cantidad); // O(log(P)) + O(log(I)) + O(log(C))

    Nat gastado = precio - (precio*descuento/100);
    m_Clientes[persona].gastoTotal += gastado;  // O(log(A))
    m_Puestos[idpuesto]->GastoDe(persona) += gastado; // O(log(p)) + O(log(A))

    // O(log(A))
    if (GastoTotal(persona) > GastoTotal(PersonaQueMasGasto) || GastoTotal(persona) == GastoTotal(PersonaQueMasGasto) && persona > PersonaQueMasGasto) {
        PersonaQueMasGasto = persona;
    }

    if (descuento == 0) {
        m_Clientes[persona].ComprasSinPromocion[item][idpuesto]->CantidadCompradaSinPromocion(persona, item) += cantidad;
        // O(log(A)) + O(log(I)) + O(log(P)) + O(log(A)) + O(log(I))
        // CantidadCompradaSinPromocion devuelve una referencia modificable. Podemos sumarle una nueva cantidad.
        // Esto tambien nos sirve para hackear, si la cantidad es 0 entonces podemos eliminar el puesto.
    }
}

void Lollapatuza::Hackear(Persona persona, Producto item) {
    Puestos ArbolPuestosDondeCompreSinPromocion = m_Clientes[persona].ComprasSinPromocion[item];    // O(log(A)) + O(log(I))
    PuestoDeComida PuestoConMenorID = *(begin(ArbolPuestosDondeCompreSinPromocion)->second); // Asumo Inorder // O(1)
    Nat& CantidadCompradaSinPromocion = PuestoConMenorID.CantidadCompradaSinPromocion(persona, item);   // O(log(A)) + O(log(I))

    // O(log(A))
    ClienteINFO clienteINFO = {m_Clientes[persona].gastoTotal - PuestoConMenorID.ObtenerPrecio(item),
                                m_Clientes[persona].ComprasSinPromocion};
    m_Clientes.erase(persona); // O(log(A))
    m_Clientes[persona] = clienteINFO; // O(log(A))

    CantidadCompradaSinPromocion -= 1; // O(1)
    if (CantidadCompradaSinPromocion == 0) { // O(1)
        m_Clientes[persona].ComprasSinPromocion[item].erase(begin(ArbolPuestosDondeCompreSinPromocion)->first);
        // O(log(A)) + O(log(I)) + O(log(P))
    }
}

Nat Lollapatuza::GastoTotal(Persona persona) { // O(log(A))
    m_Clientes[persona].gastoTotal;
}

Persona Lollapatuza::MasGasto() { // O(1)
    return PersonaQueMasGasto;
}

IdPuesto Lollapatuza::MenorStock(Producto item) { // O(P) * O(log(I) + log(P) + log(I))
    IdPuesto PuestoConMenorStock = m_Puestos.begin()->first;
    for (auto puesto : m_Puestos) {
        if (puesto.second->ObtenerStock(item) < m_Puestos[PuestoConMenorStock]->ObtenerStock(item)) {
            PuestoConMenorStock = puesto.first;
        } else if (puesto.second->ObtenerStock(item) == m_Puestos[PuestoConMenorStock]->ObtenerStock(item)) {
            if (puesto.first < PuestoConMenorStock) {
                PuestoConMenorStock = puesto.first;
            }
        }
    }
}

Personas& Lollapatuza::ObtenerPersonas() { // O(1)
    return m_Personas;
}

Puestos& Lollapatuza::ObtenerPuestos() { // O(1)
    return m_Puestos;
}
