#include "Horario.h"


Horario::Horario(uint hora, uint min) : _hora(hora), _min(min) {

}

uint Horario::hora() const { return _hora; }
uint Horario::min()  const { return _min; }

std::ostream& operator<<(std::ostream& os, Horario h) {
    os << h.hora() << ":" << h.min();
    return os;
}

bool Horario::operator==(Horario h) {
    bool iguales_min = this->min() == h.min();
    bool iguales_horas = this->hora() == h.hora();
    return iguales_min && iguales_horas;
}

bool Horario::operator<(Horario h) {
    if (this->hora() < h.hora()) {
        return true;
    } else if(this->hora() > h.hora()) {
        return false;
    }
    return this->min() < h.min();
}