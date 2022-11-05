#include "ejercicios.h"

using namespace std;

int main() {
    int n = 1000; int hasta = 10000; int paso = 500;
     ofstream fout;
     fout.open("datos.csv");

     fout << "n\t" << "tiempo\t" << "C" << endl;

     while(n < hasta){
         vector<int> v = construir_vector(n, "asc");

         double t0 = clock();
         int indice = hayDuplicados(v);
         double t1 = clock();

         double tiempo = (double(t1-t0)/CLOCKS_PER_SEC);

         double cuenta = tiempo / (n*n);

         fout << n << "\t" << tiempo << "\t" <<  cuenta <<endl;

         n +=paso;
     }
     fout.close();

    return 0;
}