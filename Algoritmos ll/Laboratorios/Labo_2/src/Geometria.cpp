#include <iostream>

using namespace std;

using uint = unsigned int;
const float pi = 3.14;

// Ejercicio 1

class Rectangulo {
    public:
        Rectangulo(uint alto, uint ancho);
        uint alto() const;
        uint ancho() const;
        float area() const;

    private:
        int alto_;
        int ancho_;

};

Rectangulo::Rectangulo(uint alto, uint ancho) : alto_(alto), ancho_(ancho)/* Completar */ {};

uint Rectangulo::alto() const {
    // Completar
    return alto_;
}

uint Rectangulo::ancho() const {
    return ancho_;
}

float Rectangulo::area() const {
    return alto_*ancho_;
}


// Ejercicio 2

class Elipse {
public:
    Elipse(uint a, uint b);
    uint r_a() const;
    uint r_b() const;
    float area() const;
private:
    uint _a;
    uint _b;
};

Elipse::Elipse(uint a, uint b) : _a(a), _b(b) {

}

uint Elipse::r_a() const {
    return _a;
}

uint Elipse::r_b() const {
    return _b;
}

float Elipse::area() const {
    return _a*_b*pi;
}
// Ejercicio 3

class Cuadrado {
    public:
        Cuadrado(uint lado);
        uint lado();
        float area();

    private:
        Rectangulo r_;
};

Cuadrado::Cuadrado(uint lado): r_(lado, lado) {}

uint Cuadrado::lado() {
    return r_.alto();
}

float Cuadrado::area() {
    return r_.alto()*r_.alto();
}

// Ejercicio 4

// Clase Circulo
class Circulo {
public:
    Circulo(uint radio);
    uint radio() const;
    float area() const;
private:
    Elipse e;
};

Circulo::Circulo(uint radio) : e(radio, radio){}

uint Circulo::radio() const {
    return e.r_a();
}

float Circulo::area() const {
    return pi*e.r_a()*e.r_a();
}

// Ejercicio 5

ostream& operator<<(ostream& os, Rectangulo r) {
    os << "Rect(" << r.alto() << ", " << r.ancho() << ")";
    return os;
}

ostream& operator<<(ostream& os, Elipse e) {
    os << "Elipse(" << e.r_a() << ", " << e.r_b() << ")";
    return os;
}

ostream& operator<<(ostream& os, Circulo c) {
    os << "Circ(" << c.radio() << ")";
    return os;
}

ostream& operator<<(ostream& os, Cuadrado q) {
    os << "Cuad(" << q.lado() << ")";
    return os;
}

// ostream Elipse

// Ejercicio 6

