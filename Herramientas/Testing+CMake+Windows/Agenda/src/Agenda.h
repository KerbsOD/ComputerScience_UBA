#ifndef AGENDA
#define AGENDA
#include "Recordatorio.h"
typedef list<Recordatorio> Recordatorios;
struct Pagina { Fecha fecha; Recordatorios recordatorios; };
typedef list<Pagina> Paginas;


class Agenda {
public:
    Agenda(Fecha fecha_inicial);
    void agregar_recordatorio(Recordatorio rec);
    void incrementar_dia();
    list<Recordatorio> recordatorios_de_hoy();
    Fecha hoy();
    friend ostream& operator<<(ostream& os, Agenda a);

private:
    Fecha _fecha_actual;
    Paginas _mis_paginas;
    bool existe_la_fecha_en_mis_paginas(Fecha f);
    void crear_pagina(Fecha f);
    void insertar_recordatorio_en_pagina(Recordatorio rec);
    void insertar_en_orden(Recordatorio mi_rec, Recordatorios &s);
};


#endif