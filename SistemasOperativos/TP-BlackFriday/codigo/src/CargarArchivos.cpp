#ifndef CHM_CPP
#define CHM_CPP

#include <vector>
#include <iostream>
#include <fstream>
#include <thread>

#include "CargarArchivos.hpp"
#include "auxiliares.hpp"

int cargarCompras(HashMapConcurrente &hashMap, const std::string &filePath)
{
    std::fstream file;
    int cant = 0;
    std::string itemActual;

    // Abro el archivo.
    file.open(filePath, std::fstream::in);
    if (!file.is_open())
    {
        std::cerr << "Error al abrir el archivo '" << filePath << "'" << std::endl;
        return -1;
    }
    while (getline(file, itemActual))
    {
        // Completar (Ejercicio 4)
        if (esLetra(itemActual[0]) == false)
        {
            continue;
        }
        hashMap.incrementar(itemActual);
        cant++;
    }
    // Cierro el archivo.
    if (!file.eof())
    {
        std::cerr << "Error al leer el archivo" << std::endl;
        file.close();
        return -1;
    }
    file.close();
    return cant;
}

void cargarComprasThread(HashMapConcurrente &hashMap, const std::vector<std::string> &filePaths,
                          std::atomic<int> &archivo)
{
    int indice;
    const int ultimaPosicion{static_cast<int>(filePaths.size())};
    while ((indice = archivo++) < ultimaPosicion)
        cargarCompras(hashMap, filePaths[indice]);
}

void cargarMultiplesCompras(HashMapConcurrente &hashMap, unsigned int cantThreads, std::vector<std::string> filePaths)
{
    // Completar (Ejercicio 4)
    std::atomic<int> archivo(0);

    std::thread threads[cantThreads];
    for (unsigned int i{0}; i < cantThreads; ++i)
        threads[i] = std::thread(cargarComprasThread, std::ref(hashMap), std::ref(filePaths), std::ref(archivo));

    for (auto &t: threads)
        t.join();
}

int cargarArchivos(HashMapConcurrente &hashMap, const std::string &filePath)
{
    std::fstream file;
    int cant = 0;
    std::string palabraActual;

    // Abro el archivo.
    file.open(filePath, std::fstream::in);
    if (!file.is_open())
    {
        std::cerr << "Error al abrir el archivo '" << filePath << "'" << std::endl;
        return -1;
    }
    while (file >> palabraActual)
    {
        // Completar (Ejercicio 4)
        if (esLetra(palabraActual[0]) == false)
        {
            continue;
        }
        hashMap.incrementar(palabraActual);
        cant++;
    }
    // Cierro el archivo.
    if (!file.eof())
    {
        std::cerr << "Error al leer el archivo" << std::endl;
        file.close();
        return -1;
    }
    file.close();
    return cant;
}

void cargarArchivosThread(HashMapConcurrente &hashMap, const std::vector<std::string> &filePaths,
                          std::atomic<int> &archivo)
{
    int indice;
    const int ultimaPosicion{static_cast<int>(filePaths.size())};
    while ((indice = archivo++) < ultimaPosicion)
        cargarArchivos(hashMap, filePaths[indice]);
}

void cargarMultiplesArchivos(HashMapConcurrente &hashMap, unsigned int cantThreads, std::vector<std::string> filePaths)
{
    // Completar (Ejercicio 4)
    std::atomic<int> archivo(0);

    std::thread threads[cantThreads];
    for (unsigned int i{0}; i < cantThreads; ++i)
        threads[i] = std::thread(cargarArchivosThread, std::ref(hashMap), std::ref(filePaths), std::ref(archivo));

    for (auto &t: threads)
        t.join();
}

#endif
