#ifndef TP_LOLLA_PUESTO_H
#define TP_LOLLA_PUESTO_H

#include "tipos.h"

class PuestoDeComida {
public:
    PuestoDeComida(Menu menu, Stock stock, Promociones promociones);
    Nat ObtenerStock(Producto item);
    Nat ObtenerPromocion(Producto item, Nat cantidad);
    Nat ObtenerPrecio(Producto item);
    Nat& GastoDe(Persona persona);
    Nat& CantidadCompradaSinPromocion(Persona persona, Producto item);

private:
    struct ClienteINFO {
        Nat gastoTotal;
        map<Producto, Nat> CantidadCompradaSinPromocion;
        ClienteINFO() : gastoTotal(0) {};
    };

    Menu m_menu;
    Stock m_stock;
    Promociones m_promociones;
    map<Persona, ClienteINFO> m_Clientes;
};

#endif //TP_LOLLA_PUESTO_H
