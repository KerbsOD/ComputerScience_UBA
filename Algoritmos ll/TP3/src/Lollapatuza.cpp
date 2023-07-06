#include "Lollapatuza.h"

Lollapatuza::Lollapatuza(const set<Persona> &personas, const map<IdPuesto, Puesto> &infoPuestos) {
    for (Persona personaID: personas) {                                              // O(A)
        PersonaINFO personaINFO = PersonaINFO(personaID);                            // O(1)
        
        m_personasID.insert(personaID);                                              // O(log(A)) 
        m_personasPorID.insert({personaID, personaINFO});                            // O(log(A))
        m_personasGasto.insert({personaINFO, personaID});                            // O(log(A))
    }

    for (auto &p: infoPuestos) {                                                     // O(P)
        IdPuesto puestoID = p.first;                                                 // O(1)
        Menu menu = p.second.menu;                                                   // O(I)
        Promociones promociones = p.second.promociones;                              // O(cant)*O(I)
        Stock stock = p.second.stock;                                                // O(I)

        m_puestosID.insert(puestoID);                                                // O(log(P))
        m_puestosPorID.insert({puestoID, PuestoDeComida(menu, stock, promociones)}); // O(log(P)) + O(I) * O(cant) * O(log(I) + log(cant)) + O(A*(log(A) + I)) 
    }
}
/*
    Complejidad:
    O(A*log(A)) + O(P) * (log(P) + cant * I * (log(I) + log(cant)) + A*(log(A) + I))

    Que hace?:
    - Para cada persona en el lollapatuza: 
    - Creo personaINFO. Esta se inicializa con el ID de la persona y su gasto total en 0.
    - Inserto personaINFO en mi set de personas. (conjLog).
    - Inserto en personasPorID como clave el id de la persona y como definicion su tupla<id,gasto total>.
    - Inserto en personasGasto como clave su tupla<id,gastoTotal> y como definicion su id. (esto nos sirve para tener
      un avl ordenado por gastos y luego por ids. Creo que podriamos usar un set de c++ pero habria que testearlo. Por eso
      usamos como clave la tupla<id,gastoTotal> y como definicion el id. Para poder usar map).
    - Para cada puesto en el lollapatuza:
    - Guardo en diferentes variables el id, stock, menu y promociones.
    - Inserto el id en mi conjunto de ids.
    - Inserto en puestos por id el puesto, siendo la clave su id y su definicion una clase PuestoDeComida. 
      Esta toma el menu, stock y promociones como parametros. (tener en cuenta la complejidad del constructor de PuestoDeComida).
*/


void Lollapatuza::Vender(IdPuesto idpuesto, Persona persona, Producto item, Nat cantidad) {    
    PersonaINFO* personaInfo  = &m_personasPorID.at(persona);                                 // O(log(A))
    PuestoDeComida* puesto    = &m_puestosPorID.at(idpuesto);                                 // O(log(P))
    Nat descuentoDeCompra     = getDescuento(idpuesto,item, cantidad);                        // O(log(P) + log(I) + log(cant))
    Nat precioDeItem          = getPrecio(item);                                              // O(log(I))
    Nat gastoDeCompra         = aplicarDescuento(precioDeItem, cantidad, descuentoDeCompra);  // O(1)
    
    m_personasGasto.erase(*personaInfo);                                                      // O(log(A))
    personaInfo->gastoTotal += gastoDeCompra;                                                 // O(1)
    m_personasGasto.insert({*personaInfo, persona});                                          // O(log(A))
    
    puesto->RegistrarVenta(persona, item, cantidad);                                          // O(log(A)) + O(log(I)) + O(log(cant))

    if (descuentoDeCompra == 0) {                                                             // O(1)
        if (m_comprasSinPromocion.count(persona) == 0) {                                      // O(log(A)) + O(1)
            map<Producto, map<IdPuesto, PuestoDeComida*> > mapaVacio;                         // O(1)
            m_comprasSinPromocion.insert({persona, mapaVacio});                               // O(log(A))
        }

        auto* itemsCompradosSinPromo = &m_comprasSinPromocion.at(persona);                    // O(log(A))
        if (itemsCompradosSinPromo->count(item) == 0) {                                       // O(log(I))
            map<IdPuesto, PuestoDeComida*> mapaVacio;                                         // O(1)
            itemsCompradosSinPromo->insert({item, mapaVacio});                                // O(log(I)) + O(1) - Mapa vacio.                 
        }                   

        if (itemsCompradosSinPromo->at(item).count(idpuesto) == 0) {                          // O(log(I) + log(P))
            itemsCompradosSinPromo->at(item).insert({idpuesto, puesto});                      // O(log(I) + log(P))
        }
    }
} 
/*
    Complejidad:
    O(log(A)) + O(log(P)) + O(log(I)) + O(log(cant))

    Que hace?:
    - Buscamos el gasto de una persona dado su id en "m_personasPorID".
    - Buscamos la clase del puesto dado su id en "m_puestosPorID".
    - Dado el id del puesto, el item y la cantidad. Obtenemos el descuento.
    - Dado el item, obtenemos su precio del menu.
    - Calculamos el gasto total de la compra.
    - Borramos personaINFO de "m_personasGasto", actualizamos su gastoTotal y nuevamente lo insertamos. Todo esto en
      O(log(A)) + O(1) + O(log(A)). Al insertarte nuevamente el gastoTotal se inserta de manera ordenado y actualizado.
    - Registramos la venta en el puesto, esto va a actualizar el stock, el gasto del cliente y la lista de compras sin descuento. (todo en el puesto).
    - Si la compra no tiene descuento:
      (1) Buscamos si la persona esta en el mapa "comprasSinPromocion". Si no esta, la insertamos con un mapa 
          vacio(map<Producto, map<idPuesto, PuestoDeComida*>). 
          (segun c++ reference crear y copiar un mapa vacio es constante).
      (2) Buscamos si el item esta en el mapa de items comprados sin promocion en "comprasSinPromocion". Si no esta, lo insertamos
          con un mapa vacio(map<idPuesto, PuestoDeComida*>).
      (3) Buscamos si el idpuesto esta en el mapa de puestos id donde esa persona compró el item sin promoción. Si no esta, lo
          insertamos con el puesto donde se registró la venta.
*/


void Lollapatuza::Hackear(Persona persona, Producto item) {
    PersonaINFO perInfo           = m_personasPorID.at(persona);                                  // O(log(A))
    IdPuesto menorID              = m_comprasSinPromocion.at(persona).at(item).begin()->first;    // O(log(A) + log(I)) + O(1)
    PuestoDeComida* puestoPuntero = m_comprasSinPromocion.at(persona).at(item).begin()->second;   // O(log(A) + log(I)) + O(1)
    Nat precio                    = getPrecio(item);                                              // O(log(I))
    bool hackeable                = puestoPuntero->Hackeo(persona, item);                         // O(log(A) + log(I))

    m_personasPorID.at(persona).gastoTotal -= precio;                                             // O(log(A))
    
    m_personasGasto.erase(perInfo);                                                               // O(log(A))
    perInfo.gastoTotal -= precio;                                                                 // O(1)
    m_personasGasto.insert({perInfo, persona});                                                   // O(log(A))
    
    if (hackeable == false) {                                                                     // O(1)
        m_comprasSinPromocion.at(persona).at(item).erase(menorID);                                // O(log(A) + log(I) + log(P))
    }
}
/*
    Complejidad:
    O(log(A) + log(I))
    O(log(A) + log(I) + log(P)) si el item ya no es hackeable.

    Que hace?:
    - Busco el gasto total de la persona en m_personasPorID.
    - Con el iterador del diccLog accedo al elemento mas pequeño (el puesto de menor id) en comprasSinPromocion para una 
      persona y un item dado. Asi consigo en O(1) el menor id y un puntero a su clase. (menorID y puestoPuntero respectivamente).
    - Obtengo el precio del item.
    - Con puestoPuntero proceso la funcion Hackear. puestoPuntero->Hackear modifica:
      (1) El stock del item en el puesto.
      (2) El gasto total de la persona en el puesto de comida.
      Ademas hackear del puesto devuelve un bool que nos dice si despues del hackeo el puesto sigue siendo hackeable. Si no sigue
      siendo hackeable entonces devuelve false. 
    - Al gasto total de la persona en el lolla le descontamos el precio del item hackeado.
    - Borramos el nodo perINFO de m_personaGasto. Le restamos el precio del item hackeado y lo insertamos nuevamente. Con esto 
      vamos a actualizar el gastoTotal de la persona e insertarla en orden nuevamente en el mapa "m_personasGasto".
    - Si el puesto ya no es hackeable, eliminamos el nodo de comprasSinPromocion para esta persona y este item.
      (recordar que un puesto ya no es hackeable si la cantidad del item comprada sin descuento es 0).
*/


Nat Lollapatuza::getGastoTotal(Persona persona) const {
    Nat gastoTotal = m_personasPorID.at(persona).gastoTotal;    //O(log(A))
    return gastoTotal; 
}
/*
    Complejidad:
    O(log(A))

    Que hace?:
    - Dado el id de una persona busca su gasto total en personasPorID.
*/


Persona Lollapatuza::getMasGasto() const {
    Persona personaQueMasGasto = (*m_personasGasto.rbegin()).second;    // O(1)
    return  personaQueMasGasto; 
}
/*
    Complejidad:
    O(1)

    Que hace?:
    - "m_personasGasto" es un mapa de tupla<PersonaINFO, Persona>. PersonaINFO esta ordenada primero por gasto y 
      si tienen el mismo gasto, el que mas gasto es el de menor id.
    - La persona que mas gasto esta al final de la lista pues los mapas son un tipo de AVL. Usando iteradores podemos
      acceder al ultimo elemento del mapa con "rbegin()". Y como queremos a la "Persona" que esta al final, entonces
      pedimos el ".second" de la lista.
*/


IdPuesto Lollapatuza::getMenorStock(Producto item) const {
    IdPuesto idMenorStock = (*m_puestosPorID.begin()).first;                 // O(1)
    Nat menorStock        = (*m_puestosPorID.begin()).second.getStock(item); // O(1) + O(log(I))

    for (const auto &iteradorPuesto : m_puestosPorID) {                      // O(P)
        IdPuesto puestoID = iteradorPuesto.first;                            // O(1)
        Nat stockPuestoActual = iteradorPuesto.second.getStock(item);        // O(log(I))

        if (stockPuestoActual < menorStock  ||                               // O(1)
           (stockPuestoActual == menorStock && puestoID < idMenorStock)) {   // O(1)
            idMenorStock = puestoID;                                         // O(1)
            menorStock = stockPuestoActual;                                  // O(1)
        }
    }

    return idMenorStock;                                                     
}
/*
    Complejidad:
    O(P)*O(log(I))  

    Que hace?:
    - Usamos el primer elemento de "m_puestosPorID" como referencia para compararlo con todos los puestos.
      En idMenorStock cargamos su id y en menorStock cargamos su stock del item dado.
    - Para cada puesto en "m_puestosPorID" si el stock del puesto actual es menor a "menorStock", actualizamos menorStock 
      con el stock del puesto actual y actualizamos idMenorStock con el id del puesto actual.
    - El otro caso es si el stock es igual a menorStock pero el id del puesto actual es menor al idMenorStock.
*/


const set<Persona> &Lollapatuza::getPersonas() const {
    return m_personasID; //O(1)
}
/*
    Complejidad:
    O(1)

    Que hace?:
    - Devuelve el conjunto con las personasID como referencia no modificable.
*/


const set<IdPuesto> &Lollapatuza::getPuestos() const {
    return m_puestosID; //O(1)
}
/*
    Complejidad:
    O(1)

    Que hace?:
    - Devuelve el conjunto con los puestosID como referencia no modificable.
*/


Nat Lollapatuza::getStock(IdPuesto idPuesto, Producto item) const {
    Nat stockEnPuesto = m_puestosPorID.at(idPuesto).getStock(item);    // O(log(P) + log(I))
    return stockEnPuesto;
}
/*
    Complejidad:
    O(log(P)) + O(log(I))

    Que hace?:
    - Busca un puesto con su id.
    - En el puesto usamos la funcion getStock y nos retorna el stock de un item.
*/


Nat Lollapatuza::getDescuento(IdPuesto idPuesto, Producto producto, Nat cantidad) const {
    Nat descuento = m_puestosPorID.at(idPuesto).getPromocion(producto, cantidad);   // O(log(P) + log(I) + log(cant))
    return  descuento; 
}
/*
    Complejidad:
    O(log(P) + log(I) + log(cant))

    Que hace?:
    - Buscamos el puesto con su id.
    - En el puesto usamos la funcion getPromocion y nos retorna el stock de un item.
*/


Nat Lollapatuza::getgastoEnPuesto(IdPuesto idPuesto, Persona persona) const {
    Nat gastoDeCliente = m_puestosPorID.at(idPuesto).getGasto(persona); // O(log(P) + log(A))
    return gastoDeCliente;
}
/*
    Complejidad:
    O(log(P) + log(A))

    Que hace?:
    - Dado un puesto y una persona devolvemos el gasto de esa persona en el puesto.
*/


Nat Lollapatuza::getPrecio(Producto item) const {
    Nat precio = (*m_puestosPorID.begin()).second.getPrecio(item); // O(log(I))
    return precio;
}
/*
    Complejidad:
    O(log(I))

    Que hace?:
    - Dado un item busca su precio en el primer puesto de m_puestosPorID. Esto es simplemente para no tener que copiar
      el menu a nuestros atributos privados en el constructor de lollapatuza. Simplemente accedemos a cualquier puesto
      y preguntamos cual es el precio del item. Teniendo en cuenta que todos los puestos venden al mismo precio.
*/


Nat Lollapatuza::aplicarDescuento(Nat precio, Nat cantidad, Nat descuento){
    Nat precioConDescuento = precio - (precio * descuento / 100);   // O(1)
    return precioConDescuento * cantidad;                           // O(1)
}
/*
    Complejidad:
    O(1)

    Que hace?:
    - Como los descuentos son enteros, los dividimos por 100 y los multiplicamos por el precio. Luego al precio original
      le restamos el porcentaje y calculamos el precio con descuento por la cantidad comprada.
*/