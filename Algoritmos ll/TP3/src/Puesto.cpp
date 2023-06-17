#include "Puesto.h"

PuestoDeComida::PuestoDeComida(Menu menu, Stock stock, Promociones promociones) :
    m_menu(menu),
    m_stock(stock),
    m_promociones(promociones)  {}

Nat PuestoDeComida::ObtenerStock(Producto item) { // O(log(I))
    return m_stock[item];
}

Nat PuestoDeComida::ObtenerPromocion(Producto item, Nat cantidad) { // O(log(I)) + O(log(C))
    return m_promociones[item][cantidad];
}

Nat PuestoDeComida::ObtenerPrecio(Producto item) { // O(log(I))
    return m_menu[item];
}

Nat& PuestoDeComida::GastoDe(Persona persona) { // O(log(A))
    return m_Clientes[persona].gastoTotal;
}

Nat& PuestoDeComida::CantidadCompradaSinPromocion(Persona persona, Producto item) { // O(log(A)) + O(log(I))
    return m_Clientes[persona].CantidadCompradaSinPromocion[item];
}


