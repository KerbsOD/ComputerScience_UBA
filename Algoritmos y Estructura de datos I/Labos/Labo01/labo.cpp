#include<iostream>
#include<math.h>


// Ejercicio 1
int SigNum(int x) {
    return x+1;
}


// Ejercicio 2
int SumarDos(int a, int b) {
    return a+b;
}


// Ejercicio 3
int SumOMult(int x, int y) {
    if (x > y) {
        return x + y;
    } else {
        return x * y;
    }
}


// Ejercicio 4
bool esPrimo(unsigned int n) {
    bool esPrimo = true;
    int posiblesDivisores = trunc(sqrt(n));   
    for(int i = 2; i < posiblesDivisores; i++) {
        if(n % 2 == 0) {
            esPrimo = false;
        }
    }
    return esPrimo;
}


// Ejercicio 5
int fibo(unsigned int n) {
    if(n == 0) {
        return 0;
    } else if (n == 1) {
        return 1;
    }
    return fibo(n-1) + fibo(n-2);
}


// Ejercicio 6
int imp(int n) {
    if(n == 1) {
        return 1;
    }
    if(n % 2 != 0) {
        return n + imp(n-1);
    } else {
        return imp(n-1);
    }
}


// Ejercicio 7
int divisoresHasta(int n, int i) {
    if(i == 1) {
        return 1;
    } else if(n % i == 0) {
        return divisoresHasta(n, i-1) + i;
    }
    return divisoresHasta(n, i-1);
}

int sumaDivisores(unsigned int n) {
    return divisoresHasta(n, n-1);
}


// Ejercicio 8
int combinatorio(unsigned int n, unsigned int k) {
    if(k == 1) {
        return n;
    } else if (k == n) {
        return 1;
    } else if(k == 0) {
        return 1;
    }
    return (combinatorio(n-1, k) + combinatorio(n-1, k-1));
}


// Ejercicio 5) b)
int FiboIT(unsigned int n) {
    while(n >= 0) {
        if(n == 1) {
            return n;
        } else if(n == 0) {
            return n;
        }
        return fibo(n-1) + fibo(n-2);
    }
}

// Ejercicio 6) b)
int impIT(unsigned int n) {
    int count = 0;

    for(int i = 1; i < n; i++) {
        if(i % 2 != 0) {
            count = count + i;
        }
    }
    return count;
}

// Ejercicio 7) b)
int divisoresHastaIT(unsigned int n) {
    int count = 0; 

    for(int i = 2; i < n; i++) {
        if(n % i == 0) {
            count = count + i;
        }
    }
    return count;
}


// MAIN ------------------------------------------------------
int main() {
    int y =10,z;
    float x = 3.0;
    z = y/x;
    std::cout << "El resultado es: " << z << std::endl;
    return 0;
}