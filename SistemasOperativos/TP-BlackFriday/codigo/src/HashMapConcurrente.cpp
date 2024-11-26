#include <algorithm>
#ifndef CHM_CPP
#define CHM_CPP

#include <thread>

#include "HashMapConcurrente.hpp"
#include "auxiliares.hpp"

HashMapConcurrente::HashMapConcurrente()
{
    for (auto &entrada: tabla)
        entrada = new ListaAtomica<hashMapPair>();
}

HashMapConcurrente::~HashMapConcurrente()
{
    for (auto &entrada: tabla)
    {
        delete entrada;
    }
}

unsigned int HashMapConcurrente::hashIndex(const std::string &clave)
{
    return static_cast<unsigned int>(std::tolower(clave[0]) - 'a');
}

void HashMapConcurrente::lockAllReaders(const unsigned int indicePrimeraLetra) {
    for (auto &readerFunction : matrizMutexLectores)
        readerFunction[indicePrimeraLetra].lock();
}

void HashMapConcurrente::unlockAllReaders(const unsigned int indicePrimeraLetra) {
    for (auto &readerFunction : matrizMutexLectores)
        readerFunction[indicePrimeraLetra].unlock();
}

void HashMapConcurrente::incrementar(const std::string &clave)
{
    // Completar (Ejercicio 2)
    if (esLetra(clave[0]) == false)
    {
        return;
    }

    const unsigned int indicePrimeraLetra = hashIndex(clave);

    lockAllReaders(indicePrimeraLetra);

    ListaAtomica<hashMapPair> *lista = tabla[indicePrimeraLetra];
    for (auto nodoActual = lista->begin(); nodoActual != lista->end(); ++nodoActual)
    {
        hashMapPair *itemYCantidad = &(*nodoActual);
        if (itemYCantidad->first == clave)
        {
            itemYCantidad->second++;
            unlockAllReaders(indicePrimeraLetra);
            return;
        }
    }

    lista->insertar({clave, 1});
    unlockAllReaders(indicePrimeraLetra);
}

void HashMapConcurrente::lockTableFor(unsigned int readerID) {
    for (auto &letra : matrizMutexLectores[readerID])
        letra.lock();
}

std::vector<std::string> HashMapConcurrente::claves()
{
    // Completar (Ejercicio 2)
    std::vector<std::string> claves;

    lockTableFor(CLAVES);

    for (int i = 0; i < cantLetras; i++)
    {
        ListaAtomica<hashMapPair> *listaAtomicaDeLetra = tabla[i];
        for (auto nodoActual = listaAtomicaDeLetra->begin(); nodoActual != listaAtomicaDeLetra->end(); ++nodoActual)
        {
            hashMapPair *itemYCantidad = &(*nodoActual);
            claves.emplace_back(itemYCantidad->first);
        }
        matrizMutexLectores[CLAVES][i].unlock();
    }

    return claves;
}

unsigned int HashMapConcurrente::valor(const std::string &clave)
{
    // Completar (Ejercicio 2)
    if (esLetra(clave[0]) == false)
    {
        return 0;
    }

    const unsigned int indicePrimeraLetra = hashIndex(clave);
    ListaAtomica<hashMapPair> *listaAtomicaDeLetra = tabla[indicePrimeraLetra];

    std::lock_guard lockValor(matrizMutexLectores[VALOR][indicePrimeraLetra]);

    for (auto nodoActual = listaAtomicaDeLetra->begin(); nodoActual != listaAtomicaDeLetra->end(); ++nodoActual)
    {
        hashMapPair *itemYCantidad = &(*nodoActual);
        if (itemYCantidad->first == clave)
        {
            return itemYCantidad->second;
        }
    }

    return 0;
}

float HashMapConcurrente::promedio()
{
    lockTableFor(PROMEDIO);

    unsigned int sum = 0;
    unsigned int count = 0;
    for (unsigned int index = 0; index < HashMapConcurrente::cantLetras; index++)
    {
        for (const auto &p: *tabla[index])
        {
            sum += p.second;
            count++;
        }
        matrizMutexLectores[PROMEDIO][index].unlock();
    }
    if (count > 0)
    {
        return static_cast<float>(sum) / static_cast<float>(count);
    }
    return 0;
}

float HashMapConcurrente::promedioParalelo(unsigned int cantThreads)
{
    std::atomic<int> pos{0};

    std::pair<unsigned int, unsigned int> *contadoresPorThread[cantThreads];
    for (auto &entrada: contadoresPorThread)
        entrada = new std::pair<unsigned int, unsigned int>{0, 0};

    lockTableFor(PROMEDIO);

    std::thread threads_[cantThreads];
    for (unsigned int i{0}; i < cantThreads; ++i)
        threads_[i] = std::thread(&HashMapConcurrente::contadoresThread, this, contadoresPorThread[i], std::ref(pos));

    for (auto &t: threads_)
        t.join();

    unsigned int totalPalabras{0};
    unsigned int entradasUnicas{0};

    for (auto &entrada: contadoresPorThread)
    {
        auto &[palabras, entradas]{*entrada};
        totalPalabras += palabras;
        entradasUnicas += entradas;
        delete entrada;
    }

    if (entradasUnicas > 0)
        return (static_cast<float>(totalPalabras)) / static_cast<float>(entradasUnicas);

    return 0;
}

void HashMapConcurrente::contadoresThread(std::pair<unsigned int, unsigned int> *contadorEnElThread,
                                          std::atomic<int> &pos)
{
    int index;
    while ((index = pos++) < cantLetras)
    {
        for (auto &[CLAVE, VALOR]: *tabla[index])
        {
            contadorEnElThread->first += VALOR;
            ++(contadorEnElThread->second);
        }
        matrizMutexLectores[PROMEDIO][index].unlock();
    }
}
#endif
