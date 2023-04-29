#include "Fecha.h"


uint dias_en_mes(uint mes) {
    uint dias[] = {
        // ene, feb, mar, abr, may, jun
        31, 28, 31, 30, 31, 30,
        // jul, ago, sep, oct, nov, dic
        31, 31, 30, 31, 30, 31
    };
    return dias[mes - 1];
}

Fecha::Fecha(int mes, int dia) : _mes(mes), _dia(dia) {
    
}

int Fecha::mes() const { return _mes; }
int Fecha::dia() const { return _dia; }

void Fecha::incrementar_dia() {
    if( _mes >= 12 && dias_en_mes(_mes) <= _dia) {
        _mes = 1;
        _dia = 1;
    } else if (dias_en_mes(_mes) <= _dia) {
        _mes++;
        _dia = 1;
    } else {
        _dia++;
    }    
}

ostream& operator<<(ostream& os, Fecha f) {
    os << f.dia() << "/" << f.mes();
    return os;
}

bool Fecha::operator==(Fecha f) {
    bool igual_dia = this->dia() == f.dia();
    bool igual_mes = this->mes() == f.mes();
    return igual_dia && igual_mes;
}