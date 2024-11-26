#ifndef HMC_HPP
#define HMC_HPP

#include <mutex>
#include <array>
#include <atomic>
#include <string>
#include <vector>

#include "ListaAtomica.hpp"

enum {CLAVES, PROMEDIO, VALOR};

typedef std::pair<std::string, unsigned int> hashMapPair;

class HashMapConcurrente
{
public:
    static constexpr int cantLetras = 26;

    HashMapConcurrente();

    ~HashMapConcurrente();

    void incrementar(const std::string &clave);

    std::vector<std::string> claves();

    unsigned int valor(const std::string &clave);

    float promedio();

    float promedioParalelo(unsigned int cantThreads);

private:
    ListaAtomica<hashMapPair> *tabla[HashMapConcurrente::cantLetras]{};
    std::array<std::array<std::mutex, HashMapConcurrente::cantLetras>, 3> matrizMutexLectores {};

    void contadoresThread(std::pair<unsigned int, unsigned int> *contadorEnElThread, std::atomic<int> &pos);
    static unsigned int hashIndex(const std::string &clave);
    void lockTableFor(unsigned int readerID);
    void lockAllReaders(unsigned int indicePrimeraLetra);
    void unlockAllReaders(unsigned int indicePrimeraLetra);
};

#endif  /* HMC_HPP */
