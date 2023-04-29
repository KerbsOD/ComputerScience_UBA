#include "Agenda.h"


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


ostream& operator<<(ostream& os, Agenda a) {
    os << a.hoy() << "\n" << "=====" << "\n";
    for(Recordatorio r : a.recordatorios_de_hoy()) {
        os << r << "\n";
    }
    return os;
}
