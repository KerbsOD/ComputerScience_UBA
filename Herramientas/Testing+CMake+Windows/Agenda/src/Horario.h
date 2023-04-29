#ifndef HORARIO
#define HORARIO
#include "Includes.h"


class Horario {
public:
    Horario(uint hora, uint min);
    uint hora() const;
    uint min() const;
    bool operator==(Horario h);
    bool operator<(Horario h);
    friend ostream& operator<<(ostream& os, Horario h);

private:
    uint _hora;
    uint _min;
};


#endif