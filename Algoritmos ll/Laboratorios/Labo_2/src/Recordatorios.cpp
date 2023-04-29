#include <iostream>
#include <list>
using namespace std;

using uint = unsigned int;


//############################################### MÓDULO FECHA ###############################################//
class Fecha {
  public:
    Fecha(int mes, int dia);
    int mes() const;
    int dia() const;
    void incrementar_dia();
    bool operator==(Fecha f);

  private:
    int _mes;
    int _dia;
};


//############################################## MÓDULO HORARIO ##############################################//
class Horario {
public:
    Horario(uint hora, uint min);
    uint hora() const;
    uint min() const;
    bool operator==(Horario h);
    bool operator<(Horario h);

private:
    uint _hora;
    uint _min;
};


//############################################ MÓDULO RECORDATORIO ############################################//
class Recordatorio {
public:
    Recordatorio(Fecha f, Horario h, string mensaje);
    string mensaje() const;
    Fecha fecha() const;
    Horario horario() const;

private:
    string _mensaje;
    Fecha _fecha;
    Horario _horario;
};


//############################################ MÓDULO AGENDA ############################################//
using Recordatorios = list<Recordatorio>;
struct Pagina {Fecha fecha; Recordatorios recordatorios;};
using Paginas = list<Pagina>;

class Agenda {
public:
    Agenda(Fecha fecha_inicial);
    void agregar_recordatorio(Recordatorio rec);
    void incrementar_dia();
    list<Recordatorio> recordatorios_de_hoy();
    Fecha hoy();

private:
    Fecha _fecha_actual;
    Paginas _mis_paginas;
    bool existe_la_fecha_en_mis_paginas(Fecha f);
    void crear_pagina(Fecha f);
    void insertar_recordatorio_en_pagina(Recordatorio rec);
    void insertar_en_orden(Recordatorio mi_rec, Recordatorios &s);
};



uint dias_en_mes(uint mes) {
    uint dias[] = {
        // ene, feb, mar, abr, may, jun
        31, 28, 31, 30, 31, 30,
        // jul, ago, sep, oct, nov, dic
        31, 31, 30, 31, 30, 31
    };
    return dias[mes - 1];
}

//############################################### MÓDULO FECHA ###############################################//
Fecha::Fecha(int mes, int dia) : _mes(mes), _dia(dia) {}

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

inline ostream& operator<<(ostream& os, Fecha f) {
    os << f.dia() << "/" << f.mes();
    return os;
}

bool Fecha::operator==(Fecha f) {
    bool igual_dia = this->dia() == f.dia();
    bool igual_mes = this->mes() == f.mes();
    return igual_dia && igual_mes;
}


//############################################## MÓDULO HORARIO ##############################################//
Horario::Horario(uint hora, uint min) : _hora(hora), _min(min) {}

uint Horario::hora() const { return _hora; }
uint Horario::min()  const { return _min;  }

inline ostream& operator<<(ostream& os, Horario h) {
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


//############################################ MÓDULO RECORDATORIO ############################################//
Recordatorio::Recordatorio(Fecha f, Horario h, std::string mensaje) : _mensaje(mensaje), _fecha(f), _horario(h){}

string  Recordatorio::mensaje() const { return _mensaje; }
Fecha   Recordatorio::fecha()   const { return _fecha;   }
Horario Recordatorio::horario() const { return _horario; }

inline ostream& operator<<(ostream& os, Recordatorio r) {
    os << r.mensaje() << " @ " << r.fecha() << " " << r.horario();
    return os;
}


//############################################ MÓDULO AGENDA ############################################//
Agenda::Agenda(Fecha fecha_inicial) : _fecha_actual(fecha_inicial) {
    crear_pagina(fecha_inicial);
}
 
void Agenda::agregar_recordatorio(Recordatorio rec) {
    if(existe_la_fecha_en_mis_paginas(rec.fecha())) {
        insertar_recordatorio_en_pagina(rec);
    } else {
        crear_pagina(rec.fecha());
        agregar_recordatorio(rec);
    }
}

void Agenda::incrementar_dia() {
    _fecha_actual.incrementar_dia();
    if(!existe_la_fecha_en_mis_paginas(_fecha_actual)) {
        crear_pagina(_fecha_actual);
    }
}

Recordatorios Agenda::recordatorios_de_hoy() {
    for(Pagina p : _mis_paginas) {
        if(p.fecha == _fecha_actual) {
            return p.recordatorios;
        }
    }
    return {};
}

Fecha Agenda::hoy() {
    return _fecha_actual;
}

bool Agenda::existe_la_fecha_en_mis_paginas(Fecha f) {
    for(Pagina p : _mis_paginas) {
        if(p.fecha == f) {
            return true;
        }
    }
    return false;
}

void Agenda::crear_pagina(Fecha f) {
    Pagina p = {f, {}};
    _mis_paginas.push_back(p);
}

void Agenda::insertar_recordatorio_en_pagina(Recordatorio rec) {
    for(Pagina &p : _mis_paginas) {
        if(rec.fecha() == p.fecha) {
            insertar_en_orden(rec, p.recordatorios);
        }
    }
}

void Agenda::insertar_en_orden(Recordatorio mi_rec, Recordatorios &s) {
    Recordatorios temp;
    bool agregado = false;
    for(Recordatorio rec : s) {
        if(mi_rec.horario() < rec.horario() && !agregado) {
            temp.push_back(mi_rec);
            agregado = true;
        }
        temp.push_back(rec);
    }

    if(!agregado) {
        temp.push_back(mi_rec);
    }

    s = temp;
}


inline ostream& operator<<(ostream& os, Agenda a) {
    os << a.hoy() << "\n" << "=====" << "\n";
    for(Recordatorio r : a.recordatorios_de_hoy()) {
        os << r << "\n";
    }
    return os;
}
