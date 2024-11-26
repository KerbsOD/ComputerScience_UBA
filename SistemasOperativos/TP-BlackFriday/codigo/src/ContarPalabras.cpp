#include <iostream>

#include "HashMapConcurrente.hpp"
#include "CargarArchivos.hpp"

int main(int argc, char **argv) {
    if (argc < 4) {
        std::cout << "Error: faltan argumentos." << std::endl;
        std::cout << std::endl;
        std::cout << "Modo de uso: " << argv[0] << " <threads_lectura> <threads_promedio>" << std::endl;
        std::cout << "    " << "<archivo1> [<archivo2>...]" << std::endl;
        std::cout << std::endl;
        std::cout << "    threads_lectura: "
            << "Cantidad de threads a usar para leer archivos." << std::endl;
        std::cout << "    threads_promedio: "
            << "Cantidad de threads a usar para computar promedio." << std::endl;
        std::cout << "    archivo1, archivo2...: "
            << "Archivos a procesar." << std::endl;
        return 1;
    }
    int cantThreadsLectura = std::stoi(argv[1]);
    int cantThreadsPromedio = std::stoi(argv[2]);

    std::vector<std::string> filePaths = {};
    for (int i = 3; i < argc; i++) {
        filePaths.emplace_back(argv[i]);
    }

    HashMapConcurrente hashMap{}; // = HashMapConcurrente();
    cargarMultiplesCompras(hashMap, cantThreadsLectura, filePaths);
    std::cout << "Promedio: " << hashMap.promedioParalelo(cantThreadsPromedio) << '\n';

    return 0;
}
