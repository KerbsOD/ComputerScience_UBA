#ifndef FECHA
#define FECHA
#include "Includes.h"


class Fecha {
public:
  Fecha(int mes, int dia);
  int mes() const;
  int dia() const;
  void incrementar_dia();
  bool operator==(Fecha f);
  friend ostream& operator<<(ostream& os, Fecha f);

private:
  int _mes;
  int _dia;
};


#endif