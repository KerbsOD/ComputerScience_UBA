#ifndef ALGO2_LABO_CLASE5_ALGORITMOS_H
#define ALGO2_LABO_CLASE5_ALGORITMOS_H

#include <utility>
#include <iterator>
#include <vector>

// Completar con las funciones del enunciado
template<class Contenedor>
typename Contenedor::value_type minimo(const Contenedor& c) {
    typename Contenedor::const_iterator it = c.begin();
    typename Contenedor::value_type min = *it;
    while(it != c.end()) {
        if(min > *it) {
            min = *it;
        }
        ++it;
    }
    return min;
}

template<class Contenedor>
typename Contenedor::value_type promedio(const Contenedor& c) {
    typename Contenedor::const_iterator it = c.begin();
    typename Contenedor::value_type prom = *it;
    ++it;
    int contador = 1;
    while(it != c.end()) {
        prom += *it;
        ++it;
        ++contador;
    }
    return prom / contador;
}

template<class Iterator>
typename Iterator::value_type minimoIter(const Iterator& desde, const Iterator& hasta) {
    auto it = desde;
    auto min = *it;
    while(it != hasta) {
        if(min > *it) {
            min = *it;
        }
        ++it;
    }
    return min;
}

template<class Iterator>
typename Iterator::value_type promedioIter(const Iterator& desde, const Iterator& hasta) {
    auto it = desde;
    auto prom = *it;
    it++;
    int contador = 1;
    while(it != hasta) {
        prom += *it;
        ++contador;
        ++it;
    }
    return prom / contador;
}

template<class Contenedor>
void filtrar(Contenedor &c, const typename Contenedor::value_type& elem) {
    typename Contenedor::const_iterator it = c.begin();
    typename Contenedor::const_iterator aux = c.begin();
    while(it != c.end()) {
        if(*it == elem) {
            aux++;
            c.erase(it);
            it = aux;
        } else {
            it++;
            aux++;
        }
    }
}

template<class Contenedor>
bool ordenado(Contenedor& c) {
    typename Contenedor::const_iterator it = c.begin();
    typename Contenedor::value_type anterior = *it;
    it++;
    while (it != c.end()) {
        if (*it < anterior) {
          return false;  
        } 
        anterior = *it;
        it++;
    }
    return true;
}

template<class Contenedor>
std::pair<Contenedor, Contenedor> split(const Contenedor & c, const typename Contenedor::value_type& elem) {
    typename Contenedor::const_iterator it = c.begin();
    Contenedor menores;
    Contenedor mayores;
    while(it != c.end()) {
        if(*it < elem) {
            menores.insert(menores.end(), *it);
        } else {
            mayores.insert(mayores.end(), *it);
        }
        it++;
    }
    return {menores, mayores};
}

template <class Contenedor>
void merge(const Contenedor& c1, const Contenedor & c2, Contenedor & res) {
  typename Contenedor::const_iterator it_A = c1.begin();
  typename Contenedor::const_iterator it_B = c2.begin();
 
  while(it_A != c1.end() && it_B != c2.end()) {
      if(*it_A < *it_B) {
          res.insert(res.end(), *it_A);
          it_A++;
      } else {
          res.insert(res.end(), *it_B);
          it_B++;
        }
    }

    while(it_A != c1.end()) {
        res.insert(res.end(), *it_A);
        it_A++;
    } 

    while(it_B != c2.end()) {
        res.insert(res.end(), *it_B);
        it_B++;
    }
}

#endif //ALGO2_LABO_CLASE5_ALGORITMOS_H
