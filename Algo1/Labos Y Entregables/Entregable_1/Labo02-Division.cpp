#include <iostream>

void division(int dividendo, int divisor, int &cociente, int &resto){
	// Modificar el pasaje de parametros de ser necesario para que calcule el cociente y resto. Deben se por copia o referencia??
    /* COMPLETAR */
    if(dividendo >= 0 && divisor > 0) {
        
        cociente = -1;

        while(dividendo >= 0) {
            dividendo-=divisor;
            cociente++;
        }

        if(dividendo < 0) {
            resto = dividendo + divisor;
        } else {
            resto = 0;}
    }
    
}

using namespace std;
int main() {
    /* No hace falta modificar el main */
    //Leo la entrada
    int divisor,dividendo,cociente,resto;
    cin >> dividendo>>divisor;
    
    //Calculo la division
    division(dividendo,divisor,cociente,resto);
    
    //Salida
    cout << cociente << " " << resto;
    
    return 0;
}
