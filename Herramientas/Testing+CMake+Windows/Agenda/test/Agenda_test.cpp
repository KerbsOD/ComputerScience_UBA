#include <gtest/gtest.h>
#include "../src/Agenda.h"

TEST(Agenda, ordenado) {
  Agenda a(Fecha(5, 10));
  a.agregar_recordatorio(Recordatorio(Fecha(5, 10), Horario(9, 0), "Clase Algo2"));
  a.agregar_recordatorio(Recordatorio(Fecha(5, 10), Horario(11, 0), "Labo Algo2"));

  stringstream ss;
  ss << a;
  stringstream ss2;
  ss2 << "10/5" << endl;
  ss2 << "=====" << endl;
  ss2 << "Clase Algo2 @ 10/5 9:0" << endl;
  ss2 << "Labo Algo2 @ 10/5 11:0" << endl;
  EXPECT_EQ(ss.str(), ss2.str());
}

TEST(Agenda, desordenado) {
  Agenda a(Fecha(5, 10));
  a.agregar_recordatorio(Recordatorio(Fecha(5, 10), Horario(11, 0), "Labo Algo2"));
  a.agregar_recordatorio(Recordatorio(Fecha(5, 10), Horario(9, 0), "Clase Algo2"));

  stringstream ss;
  ss << a;
  stringstream ss2;
  ss2 << "10/5" << endl;
  ss2 << "=====" << endl;
  ss2 << "Clase Algo2 @ 10/5 9:0" << endl;
  ss2 << "Labo Algo2 @ 10/5 11:0" << endl;
  EXPECT_EQ(ss.str(), ss2.str());
}

TEST(Agenda, cambio_dia) {
  Agenda a(Fecha(5, 9));
  a.agregar_recordatorio(Recordatorio(Fecha(5, 10), Horario(11, 0), "Labo Algo2"));
  a.agregar_recordatorio(Recordatorio(Fecha(5, 10), Horario(9, 0), "Clase Algo2"));

  stringstream ss1;
  ss1 << a;
  stringstream ss1c;
  ss1c << "9/5" << endl;
  ss1c << "=====" << endl;
  EXPECT_EQ(ss1c.str(), ss1.str());

  a.incrementar_dia();
  stringstream ss2;
  ss2 << a;

  stringstream ss2c;
  ss2c << "10/5" << endl;
  ss2c << "=====" << endl;
  ss2c << "Clase Algo2 @ 10/5 9:0" << endl;
  ss2c << "Labo Algo2 @ 10/5 11:0" << endl;
  EXPECT_EQ(ss2.str(), ss2c.str());
}

int main(int argc, char* argv[]) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}






