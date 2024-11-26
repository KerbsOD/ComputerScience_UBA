#ifndef HMC_ARCHIVOS_HPP
#define HMC_ARCHIVOS_HPP

#include <vector>
#include <string>

#include "HashMapConcurrente.hpp"

int cargarCompras(HashMapConcurrente &hashMap, const std::string &filePath);
int cargarArchivos(HashMapConcurrente &hashMap, const std::string &filePath);

void cargarMultiplesCompras(HashMapConcurrente &hashMap, unsigned int cantThreads, std::vector<std::string> filePaths);
void cargarMultiplesArchivos(HashMapConcurrente &hashMap, unsigned int cantThreads, std::vector<std::string> filePaths);

#endif /* HMC_ARCHIVOS_HPP */
