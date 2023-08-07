#include "Puesto.h"

PuestoDeComida::PuestoDeComida(Menu menu, Stock stock, Promociones promociones)
    : m_menu(menu), m_stock(stock), m_promociones(promociones) {             // O(I) + O(I) + O(I)*O(cant)

    for (auto itemYPrecio : m_menu) {                                        // O(I)
        Producto item = itemYPrecio.first;                                   // O(1)

        if (m_promociones.count(item) == 1) {
            Nat promocionAnterior = 0;                                       // O(1)
            Nat mayorCantidadConDescuento = (m_promociones.rbegin())->first; // O(1)
            for (int i = 0; i < mayorCantidadConDescuento; i++) {            // O(cant)
                if (m_promociones.at(item).count(i) == 1) {                  // O(log(I)) + O(log(cant))
                    promocionAnterior = m_promociones[item][i];              // O(log(I)) + O(log(cant))
                }else {                                                    
                    m_promociones.at(item).insert({i, promocionAnterior});   // O(log(I)) + O(log(cant))
                }
            }
        }        
    }
}
/*
    Complejidad: 
    O(I) * O(cant) * O(log(I) + log(cant)) + O(A*(log(A) + I)) 

    Que hace?:
    - Inserta el menu, el stock y las promociones del puesto.
    - A cada item del menu, desde la cantidad 0 hasta la maxima cantidad con descuento. Si la cantidad tiene descuento
      entonces la guardamos como la "promocionAnterior", si la cantidad no tiene descuento lo insertamos en "m_promociones" 
      con la promocion de "promocionAnterior". Cada vez que una cantidad si tiene promocion, actualizamos "promocionAnterior".
*/


void PuestoDeComida::RegistrarVenta(Persona persona, Producto item, Nat cantidad){
    if (m_clientes.count(persona) == 0) {                                   // O(log(A))
        m_clientes.insert({persona, ClienteINFO()});                        // O(log(A))
    }

    ClienteINFO* cliente = &m_clientes.at(persona);                         // O(log(A))
    Nat descuento        = getPromocion(item, cantidad);                    // O(log(I)) + O(log(cant))                 
    Nat precio           = getPrecio(item);                                 // O(log(I))                             
    Nat gastoDeCompra    = aplicarDescuento(precio, cantidad, descuento);   // O(1)  

    m_stock.at(item) -= cantidad;                                           // O(log(I))                        
    cliente->gastoEnPuesto += gastoDeCompra;                                // O(1)

    if (descuento == 0){                                                    // O(1) 
        if (cliente->cantidadCompradaSinPromocion.count(item) == 0) {       // O(log(I))
            cliente->cantidadCompradaSinPromocion.insert({item, 0});        // O(log(I))
        } 
        cliente->cantidadCompradaSinPromocion.at(item) += cantidad;         // O(log(I))
    }
}
/*
    Complejidad: 
    O(log(A)) + O(log(I)) + O(log(cant))

    Que hace?:
    - Busco al cliente en mi lista de clientes, si no existe, lo creo.
    - Busco el descuento para el item y la cantidad solicitada en mi lista de promociones.
    - Busco el precio del item en mi menu.
    - Calculo el gasto total teniendo en cuenta el descuento.
    - Modifico el stock el puesto.
    - Modifico el gasto en puesto del cliente pues ha cambiado.
    - Si la compra del item no tuvo ningun descuento entonces agrego la cantidad comprada a 
      "cantidadCompradaSinPromocion" de mi cliente.
    - Si es la primera vez que compro ese item sin promocion, lo agrego al mapa con la cantidad = 0;
*/


bool PuestoDeComida::Hackeo(Persona persona, Producto item){
    ClienteINFO* cliente = &m_clientes.at(persona);             // O(log(A))
    Nat precioDelItem    = m_menu.at(item);                     // O(log(I))
    bool hackeable       = true;                                // O(1)
    
    cliente->gastoEnPuesto -= precioDelItem;                    // O(1)
    cliente->cantidadCompradaSinPromocion.at(item)--;           // O(log(I)) + O(1)
    m_stock.at(item)++;                                         // O(log(I)) + O(1)

    if (cliente->cantidadCompradaSinPromocion.at(item) == 0) {  // O(log(I)) + O(1)
        cliente->cantidadCompradaSinPromocion.erase(item);      // O(log(I))
        hackeable = false;                                      // O(1)
    }

    return hackeable;                                           // O(1)
}
/*
    Complejidad: 
    O(log(A)) + O(log(I))
    
    Que hace?:
    - Busca la informacion del cliente.
    - Busca el precio del item.
    - Le resto el precio del item hackeado al gasto del cliente en el puesto.
    - Reduzco la cantidad del item comprada sin promocion en 1.
    - Aumento en 1 el stock del item en el puesto.
    - Si la cantidad comprada sin descuento del item es igual a 0 entonces ya no es hackeable.
      (1) Borro el item de "cantidadCompradaSinPromocion"
      (2) hackeable = false, ya no es hackeable. (leer hackear de lollapatuza para entender su funcionalidad).
*/


Nat PuestoDeComida::getStock(Producto item) const {
    Nat stock = m_stock.at(item);    // O(log(I))
    return stock;                    // O(1)
}
/*
    Complejidad:
    O(log(I))

    Que hace?:
    - Dado un item busca su stock en el puesto.
*/


Nat PuestoDeComida::getPromocion(Producto item, Nat cantidad) const {
    if (m_promociones.count(item) == 0){                                       // O(log(cant))
        return 0;                                                              // O(1)
    }
    
    auto iteradorMayorCantidadConPromocion = m_promociones.at(item).rbegin();  // O(log(cant))
    
    Nat mayorCantidad = iteradorMayorCantidadConPromocion->first;              // O(1)
    Nat promocion     = iteradorMayorCantidadConPromocion->second;             // O(1)
    
    if (cantidad > mayorCantidad) {                                            // O(1)
        return promocion;                                                      // O(1)
    } else { 
        return m_promociones.at(item).at(cantidad);                            // O(log(I)) + O(log(cant))
    }   
}
/*
    Complejidad: 
    O(log(I)) + O(log(cant))
    
    Que hace?:
    - Si el item no tiene ninguna promocion entonces devuelvo 0.
    - Creamos un iterador al final del mapa, esto nos da el maximo item con promocion y su promocion.
    - Si nos pasan una cantidad mayor a nuestro maximo item con promocion entonces devolvemos la promocion dl maximo.
    - Como se puede ver en el constructor de PuestoDeComida, para todos los items sin promocion menores al maximo le asignamos
      la promocion de la ultima cantidad inferior.
*/


Nat PuestoDeComida::getPrecio(Producto item) const {
    Nat precio = m_menu.at(item);   // O(log(I))
    return precio;                  // O(1)
}
/*
    Complejidad: 
    O(log(I))

    Que hace?:
    - Busco el precio del item en el menu que le pasamos al principio.
*/


Nat PuestoDeComida::getGasto(Persona persona) const {
    if (m_clientes.count(persona) == 0) {               // O(log A)
        return 0;                                       // O(1)
    }
    Nat gasto = m_clientes.at(persona).gastoEnPuesto;   // O(log A)
    return gasto; 
}
/*
    Complejidad: 
    O(log(A))

    Que hace?:
    - Si la persona no esta en la lista de clientes entonces su gasto es 0.
    - Buscamos 
    
*/


Nat PuestoDeComida::aplicarDescuento(Nat precio, Nat cantidad, Nat descuento){
    Nat precioConDescuento = precio - (precio * descuento / 100);   // O(1)
    return precioConDescuento * cantidad;                           // O(1)
}
/*
    Complejidad: 
    O(1)

    Que hace?:
    - Calculamos el precio unitario dado el descuento
    - Devolvemos el precio unitario por la cantidad;
*/
