#include "Proxy2.h"

Proxy::Proxy(ConexionJugador** conn) : _conn(conn) {} // Guardo la DIRECCION DEL PUNTERO en _conn.

void Proxy::enviarMensaje(string msg) {
  (*_conn)->enviarMensaje(msg);
}
