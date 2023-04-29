#include "Recordatorio.h"

Recordatorio::Recordatorio(Fecha f, Horario h, std::string mensaje) : _mensaje(mensaje), _fecha(f), _horario(h){}

string  Recordatorio::mensaje() const { return _mensaje; }
Fecha   Recordatorio::fecha()   const { return _fecha;   }
Horario Recordatorio::horario() const { return _horario; }

ostream& operator<<(ostream& os, Recordatorio r) {
    os << r.mensaje() << " @ " << r.fecha() << " " << r.horario();
    return os;
}