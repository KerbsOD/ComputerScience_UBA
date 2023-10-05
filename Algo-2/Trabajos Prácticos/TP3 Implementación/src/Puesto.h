#ifndef TP_LOLLA_PUESTO_H
#define TP_LOLLA_PUESTO_H

#include "tipos.h"

class PuestoDeComida {
public:
    PuestoDeComida(Menu menu, Stock stock, Promociones promociones);

    // Generadores.
    void RegistrarVenta(Persona persona, Producto item, Nat cantidad);
    bool Hackeo(Persona persona, Producto item);

    // Observadores.
    Nat getStock(Producto item) const;
    Nat getPromocion(Producto item, Nat cantidad) const;
    Nat getGasto(Persona persona) const;
    Nat getPrecio(Producto item) const;
    static Nat aplicarDescuento(Nat precio,Nat cantidad,Nat descuento);

private:
    Menu                             m_menu;
    Stock                            m_stock;
    Promociones                      m_promociones;
    map<Persona, ClienteINFO>        m_clientes;
};

#endif
