#include "electores.h"
#include <cmath>

int validarVotante(int BirthYear, int BirthMonth, int BirthDay) {

    int referenceYear = 2022;
    int referenceMonth = 10;
    int referenceDay = 22;

    int meses[13] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

    int completeYearsDaysAlive = 365 * (referenceYear - BirthYear - 1);

    int daysInBirthYear = meses[BirthMonth] - BirthDay;
    for(int i = (BirthMonth + 1); i <= 12; i++){
        daysInBirthYear = daysInBirthYear + meses[i];
    }

    int daysInReferenceYear = referenceDay;
    for(int i = 1; i < referenceMonth; i++){
        daysInReferenceYear = daysInReferenceYear + meses[i];
    }

    int diasTotales = completeYearsDaysAlive + daysInBirthYear + daysInReferenceYear;


    int edad = floor(diasTotales / 365);

    if ( BirthYear > 2022 || BirthMonth > 12 || BirthMonth < 1 || BirthDay < 1 || BirthDay > 31 ) {
        return 4;
    }


    int estado;

    if(edad >= 70){
        estado = 3;
    }
    if(edad < 70 && edad >= 18){
        estado = 2;
    }
    if(edad < 18 && edad >= 16){
        estado = 1;
    }
    if(edad < 16){
        estado = 0;
    }

    return estado;
}
