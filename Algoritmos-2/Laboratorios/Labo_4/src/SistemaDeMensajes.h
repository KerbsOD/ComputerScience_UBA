#ifndef SISTEMADEMENSAJES_H
#define SISTEMADEMENSAJES_H

#include "ConexionJugador.h"
#include <string>
#include <vector>
//#include "Proxy.h"
#include "Proxy2.h"


using namespace std;

class SistemaDeMensajes {
public:
  SistemaDeMensajes();
  ~SistemaDeMensajes();
  class Proxy;
  void registrarJugador(int id, string ip);    // Pre: 0 <= id < 4
  void desregistrarJugador(int id);
  bool registrado(int id) const;               // Pre: 0 <= id < 4
  void enviarMensaje(int id, string mensaje);  // Pre: registrado(id)
  string ipJugador(int id) const;              // Pre: registrado(id)
  Proxy* obtenerProxy(int id);

  class Proxy {
  public:
    Proxy(ConexionJugador** conn);
    void enviarMensaje(string msg);

  private:
    ConexionJugador** _conn;
    Proxy(const Proxy&);  // No puedo copiarlo
  };
  
private:
  ConexionJugador* _conns[4];
  vector<Proxy*> _proxys;
};

#endif
