#include "Funciones.h"


// Ejercicio 1
void Ejercicio1() {
    
    int nota;
    float suma = 0;

    for(int i = 0; i < 10; i++) {
        
        std::cout << "Nota del Estudiante Nro " << (i+1) << ": ";
        std::cin >> nota;
        std::cout << "\n";

        suma = suma + nota;
    }

    float promedio = suma/10;

    std::cout << "La suma total de las notas es: " << suma << "\n";
    std::cout << "Promedio: " << promedio << "\n";
}


// Ejercicio 2
void Ejercicio2() {

    int nota, i = 1;
    float suma = 0;
    bool entry = true;

    while(entry) {
        std::cout << "Nota del Estudiante Nro " << i << ": ";
        std::cin >> nota;
        std::cout << "\n";

        if(nota == (-1)) {
            break;
        }

        suma = suma + nota;
        i++;
    }

    float promedio = suma/i;

    std::cout << "La suma total de las notas es: " << suma << "\n";
    std::cout << "Promedio: " << promedio << "\n";
}


// Ejercicio 3
void Ejercicio3() {

    int nota, i = 1, aprobaron = 0;
    float suma = 0;
    bool entry = true;

    while(entry) {
        std::cout << "Nota del Estudiante Nro " << i << ": ";
        std::cin >> nota;
        std::cout << "\n";

        if(nota == (-1)) 
            break;
        else if(nota > 6) 
            aprobaron++;

        suma = suma + nota;
        i++;
    }

    float promedio = suma/i;

    if((i-1) < 6) {
        std::cout << "Error";
    } else if (aprobaron > (i*2)/3) {
        std::cout << "Se puede aumentar el numero de plazas en el curso";
    }
}


// Ejercicio 4
int Ejercicio4(long long n) {
    
    int num = 0; 
    int i = 0; 
    int rem;

    while (n!=0) {
        rem = n % 10;
        n /= 10;
        num += rem * pow(2, i);
        ++i;
    }

    return num;
}


// Ejercicio 5
void Ejercicio5(float radio) {
    
    float diametro = 2*radio;
    float circunferencia = diametro * 3.12159;
    float área = 3.14159 * pow(radio, 2);

    std::cout << "Diametro: " << diametro << "\n";
    std::cout << "Circunferencia: " << circunferencia << "\n";
    std::cout << "Area: " << área << "\n";
}


// Ejercicio 6
void Ejercicio6A(int n) {
    std::cout << 3*n << "\n";
}

void Ejercicio6B(int& n) {
    n = 3*n;
}


// Ejercicio 7
void swap(int& a, int& b) {
    int a0 = a, b0 = b;
    a = b0;
    b = a0;
}


// Ejercicio 8
void collatz(int n) {
    
    int cantidadPasos = 1;

    std::cout << "Collatz of: " << n << "\n";
    std::cout << "Sequence: ";
    
    while(n != 1) {

        std::cout << n << " ";
        
        if(n % 2 == 0) {
            n = n / 2;
            cantidadPasos++;
        }
        else {
            n = (n * 3) + 1;
            cantidadPasos++;
        }
    }

    std::cout << 1 << "\n";

    std::cout << "Pasos: " << cantidadPasos;
}

void collatzRecu(int n,int cantPasos) {

    if(n <= 1) {
        ++cantPasos;
        std::cout << n << "\n";
        std::cout << "Pasos: " << cantPasos;
    }
    else {
        std::cout << n << " ";
        if(n % 2 == 0) 
        {
            collatzRecu(n/2, cantPasos + 1);
        } 
        else 
        {
            collatzRecu(n*3 + 1, cantPasos + 1);
        }
    }
}


// Ejercicio 9
void division(int dividendo, int divisor) {

    if(dividendo >= 0 && divisor > 0) {

        int cociente = dividendo / divisor;
        int resto    = dividendo - (divisor*cociente);

        std::cout << "Resto: "    << resto << "\n";
        std::cout << "Cociente: " << cociente << "\n";
    } 
}


int divisionRecu(int dividendo, int divisor) {

    if(dividendo < 0) {
        int resto = dividendo + divisor;
        return resto;
    }

    return divisionRecu(dividendo - divisor, divisor);
}
