#ifndef RECORDATORIO
#define RECORDATORIO
#include "Fecha.h"
#include "Horario.h"
#include "Includes.h"


class Recordatorio {
public:
    Recordatorio(Fecha f, Horario h, string mensaje);
    string mensaje() const;
    Fecha fecha() const;
    Horario horario() const;
    friend ostream& operator<<(ostream& os, Recordatorio r);

private:
    string _mensaje;
    Fecha _fecha;
    Horario _horario;
};


#endif