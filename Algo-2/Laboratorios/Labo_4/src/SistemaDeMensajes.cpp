#include "SistemaDeMensajes.h"

SistemaDeMensajes::SistemaDeMensajes() : _conns() {
}

SistemaDeMensajes::~SistemaDeMensajes() {
    for(auto jugador : _conns) {
        delete jugador;
    }
    for(auto proxy : _proxys) {
        delete proxy;
    }
}

void SistemaDeMensajes::registrarJugador(int id, string ip) {
    desregistrarJugador(id);
    _conns[id] = new ConexionJugador(ip);   // _conns es un array de pointers, cuando registramos un id debemos crear un espacio en la memoria para su data.   
}

void SistemaDeMensajes::desregistrarJugador(int id) {
    if(registrado(id)) {
        delete _conns[id];
        _conns[id] = nullptr; // cuando borras un espacio de memoria, el pointer no se queda como nullptr 0.0
    }
}

bool SistemaDeMensajes::registrado(int id) const {
    return _conns[id] != nullptr;
}

void SistemaDeMensajes::enviarMensaje(int id, string mensaje) {
    _conns[id]->enviarMensaje(mensaje);
}

string SistemaDeMensajes::ipJugador(int id) const {
    return _conns[id]->ip(); // Recordar que la flechita me des-referencia y me da el valor de la variable.
}

SistemaDeMensajes::Proxy::Proxy(ConexionJugador** conn) : _conn(conn) {} // Guardo la DIRECCION DEL PUNTERO en _conn.

void SistemaDeMensajes::Proxy::enviarMensaje(string msg) {
  (*_conn)->enviarMensaje(msg);
}

SistemaDeMensajes::Proxy* SistemaDeMensajes::obtenerProxy(int id) {
    Proxy* p = new Proxy(&_conns[id]);
    _proxys.push_back(p);
    return p;
}
 