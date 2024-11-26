//
// Created by jorge on 17/10/24.
//
#include <iostream>
#include <thread>
#include <chrono>
#include <random>

#include "HashMapConcurrente.hpp"
#include "CargarArchivos.hpp"

unsigned int cantThreadsLectura {};
unsigned int cantThreadsPromedio {};
std::vector<std::string> filePaths = {};
std::chrono::duration<long, std::ratio<1, 1000>> tiempoCarga {};
std::chrono::duration<long, std::ratio<1, 1000>> tiempoPromedios {};
std::chrono::duration<long, std::ratio<1, 1000>> tiempoClaves {};
std::chrono::duration<long, std::ratio<1, 1000>> tiempoValores {};
std::chrono::duration<long, std::milli> espera {10};
std::chrono::time_point<std::chrono::system_clock> tiempoComienzo ;
std::chrono::time_point<std::chrono::system_clock> tiempoFinal;
std::chrono::duration<long, std::ratio<1, 1000>> tiempoTotal;
std::thread t1;
std::thread t2;
std::thread t3;
std::thread t4;
std::vector<std::string> claves;
int promedios {};
int nClaves {};
int valores {};

void cargaArchivos(HashMapConcurrente &hashMap)
{
    auto comienzo{std::chrono::high_resolution_clock::now()};
    cargarMultiplesArchivos(hashMap, cantThreadsLectura, filePaths);
    auto final{std::chrono::high_resolution_clock::now()};
    tiempoCarga = std::chrono::duration_cast<std::chrono::milliseconds>(final - comienzo);
}

void calcularPromedio(HashMapConcurrente &hashMap)
{
    std::this_thread::sleep_for(espera);
    int i {0};
    auto comienzo{std::chrono::high_resolution_clock::now()};
    for (; i < promedios && std::chrono::duration_cast<std::chrono::milliseconds> (std::chrono::high_resolution_clock::now() - comienzo).count() < 180000; i++)
    {
        hashMap.promedioParalelo(cantThreadsPromedio);
        //std::cout << "Promedio " << i+1 << ": " << hashMap.promedioParalelo(cantThreadsPromedio) << '\n';
    }
    auto final{std::chrono::high_resolution_clock::now()};

    if (i != promedios)
    {
        std::cout << "Promedio acortado tras 3 minutos de calculos\n";
        promedios = i;
    }

    tiempoPromedios = std::chrono::duration_cast<std::chrono::milliseconds>(final - comienzo);
}

void pedirClaves(HashMapConcurrente &hashMap)
{
    std::this_thread::sleep_for(espera);
    int i {0};

    auto comienzo{std::chrono::high_resolution_clock::now()};
    for (; i < nClaves && std::chrono::duration_cast<std::chrono::milliseconds> (std::chrono::high_resolution_clock::now() - comienzo).count() < 180000; i++)
        hashMap.claves();

    auto final{std::chrono::high_resolution_clock::now()};

    if (i != nClaves)
    {
        std::cout << "Claves acortado tras 3 minutos de calculos\n";
        nClaves = i;
    }

    tiempoClaves = std::chrono::duration_cast<std::chrono::milliseconds>(final - comienzo);
}

void tomarValores(HashMapConcurrente &hashMap)
{
    //consideramos siempre van a haber claves
    std::random_device rd; // a seed source for the random number engine
    std::mt19937 gen(rd()); // mersenne_twister_engine seeded with rd()
    std::uniform_int_distribution<> distrib(0, static_cast<int>(claves.size()) - 1);
    std::this_thread::sleep_for(espera);

    int i{0};

    auto comienzo{std::chrono::high_resolution_clock::now()};
    for (; i < valores; ++i)
        hashMap.valor(claves[distrib(gen)]);

    auto final{std::chrono::high_resolution_clock::now()};

    if (i != valores)
    {
        std::cout << "Valores acortado tras 3 minutos de calculos\n";
        valores = i;
    }

    tiempoValores = std::chrono::duration_cast<std::chrono::milliseconds>(final - comienzo);
}

void verificacion(int argc, char **argv)
{
    if (argc < 4)
    {
        std::cout << "Error: faltan argumentos." << "\n\n";
        std::cout << "Modo de uso: " << argv[0] << " <threads_lectura> <threads_promedio>" << '\n';
        std::cout << "    " << "<archivo1> [<archivo2>...]" << "\n\n";
        std::cout << "    threads_lectura: " << "Cantidad de threads a usar para leer archivos." << '\n';
        std::cout << "    threads_promedio: " << "Cantidad de threads a usar para computar promedio." << '\n';
        std::cout << "    archivo1, archivo2...: " << "Archivos a procesar." << '\n';
        exit(EXIT_FAILURE);
    }
}

void tomarDatos (int argc, char **argv)
{
    try
    {
        cantThreadsLectura = std::stoi(argv[1]);
        cantThreadsPromedio = std::stoi(argv[2]);
    }
    catch (std::invalid_argument&)
    {
        std::cout << "Error: argumentos incorrectos." << "\n\n";
        std::cout << "Modo de uso: " << argv[0] << " <threads_lectura> <threads_promedio>" << '\n';
        std::cout << "    " << "<archivo1> [<archivo2>...]" << "\n\n";
        std::cout << "    threads_lectura: " << "Cantidad de threads a usar para leer archivos." << '\n';
        std::cout << "    threads_promedio: " << "Cantidad de threads a usar para computar promedio." << '\n';
        std::cout << "    archivo1, archivo2...: " << "Archivos a procesar." << '\n';
        exit(EXIT_FAILURE);
    }
    for (int i = 3; i < argc; i++)
        filePaths.emplace_back(argv[i]);
}

void cargarYPromedio(HashMapConcurrente &hashMap)
{
    std::cout << "Se realizará una carga con " << cantThreadsLectura << " hilos de los archivos, pidiendo simultaneamente "<< promedios <<" promedioParalelo().\n\n";

    tiempoComienzo = std::chrono::high_resolution_clock::now();
    t1 = std::thread(cargaArchivos, std::ref(hashMap));
    t2 = std::thread(calcularPromedio, std::ref(hashMap));

    t1.join();
    t2.join();
    tiempoFinal = std::chrono::high_resolution_clock::now();
    tiempoTotal = std::chrono::duration_cast<std::chrono::milliseconds>(tiempoFinal - tiempoComienzo);

    std::cout << "Tiempo para cargar en paralelo a valor(): " << tiempoCarga.count() << "ms.\n";
    std::cout << "Tiempo para realizar " << promedios << " promedioParalelo en paralelo a la carga: " << tiempoPromedios.count() << "ms.\n";
    std::cout << "Tiempo total para realizar todo lo anterior paralelamente: " << tiempoTotal.count() << "ms.\n\n";
}

void cargarYClaves(HashMapConcurrente &hashMap)
{
    std::cout << "Se realizará una carga con " << cantThreadsLectura << " hilos de los archivos, pidiendo simultaneamente "<< nClaves <<" claves().\n\n";

    tiempoComienzo = std::chrono::high_resolution_clock::now();
    t1 = std::thread(cargaArchivos, std::ref(hashMap));
    t3 = std::thread(pedirClaves, std::ref(hashMap));

    t1.join();
    t3.join();
    tiempoFinal = std::chrono::high_resolution_clock::now();
    tiempoTotal = std::chrono::duration_cast<std::chrono::milliseconds>(tiempoFinal - tiempoComienzo);

    std::cout << "Tiempo para cargar en paralelo a valor(): " << tiempoCarga.count() << "ms.\n";
    std::cout << "Tiempo para realizar " << nClaves << " claves en paralelo a la carga: " << tiempoClaves.count() << "ms.\n";
    std::cout << "Tiempo total para realizar todo lo anterior paralelamente: " << tiempoTotal.count() << "ms.\n\n";
}

void cargarYValores(HashMapConcurrente &hashMap)
{
    std::cout << "Se realizará una carga con " << cantThreadsLectura << " hilos de los archivos, pidiendo simultaneamente "<< valores <<" valor().\n\n";

    tiempoComienzo = std::chrono::high_resolution_clock::now();
    t1 = std::thread(cargaArchivos, std::ref(hashMap));
    t4 = std::thread(tomarValores, std::ref(hashMap));
    t1.join();
    t4.join();
    tiempoFinal = std::chrono::high_resolution_clock::now();
    tiempoTotal = std::chrono::duration_cast<std::chrono::milliseconds>(tiempoFinal - tiempoComienzo);
    std::cout << "Tiempo para cargar en paralelo a valor(): " << tiempoCarga.count() << "ms.\n";
    std::cout << "Tiempo para realizar " << valores << " pedidos aleatorios de valor en paralelo a la carga: " << tiempoValores.count() << "ms.\n";

    std::cout << "Tiempo total para realizar todo lo anterior paralelamente: " << tiempoTotal.count() << "ms.\n\n";

}

void funcionesLectoras(HashMapConcurrente &hashMap)
{
    std::cout << "Se realizará una segunda carga con " << cantThreadsLectura << " hilos de los archivos, luego se realizarán "<< promedios <<" rondas de promediosParalelos(), claves() y valor() secuencialmente.\n\n";

    cargaArchivos(hashMap);
    std::cout << "La carga duró: " << tiempoCarga.count() << "ms.\n";

    calcularPromedio(hashMap);
    std::cout << "Tiempo para realizar " << promedios << " promediosParalelos: " << tiempoPromedios.count() << "ms.\n";

    pedirClaves(hashMap);
    std::cout << "Tiempo para realizar " << nClaves << " claves: " << tiempoClaves.count() << "ms.\n";

    tomarValores(hashMap);
    std::cout << "Tiempo para realizar " << valores << " pedidos aleatorios de valor: " << tiempoValores.count() << "ms.\n\n";

    auto clavesSegundo {hashMap.claves()};
    auto promedioSegundo {hashMap.promedioParalelo(cantThreadsPromedio)};

    std::cout << "Cantidad de claves: " << clavesSegundo.size() <<".\n";
    std::cout << "Promedio con " << cantThreadsPromedio << " hilos: " << promedioSegundo << ".\n\n";

    promedios = valores;
    nClaves = valores;
    std::cout << "Se realizarán "<< promedios <<" rondas de promediosParalelos(), claves() y valor() paralelamente\n\n";

    tiempoComienzo = std::chrono::high_resolution_clock::now();

    t2 = std::thread(calcularPromedio, std::ref(hashMap));
    t3 = std::thread(pedirClaves, std::ref(hashMap));
    t4 = std::thread(tomarValores, std::ref(hashMap));

    t2.join();
    t3.join();
    t4.join();

    tiempoFinal = std::chrono::high_resolution_clock::now();
    tiempoTotal = std::chrono::duration_cast<std::chrono::milliseconds>(tiempoFinal - tiempoComienzo);

    std::cout << "Tiempo para realizar " << promedios << " promediosParalelos en paralelo a todo: " << tiempoPromedios.count() << "ms.\n";
    std::cout << "Tiempo para realizar " << nClaves << " claves en paralelo a todo: " << tiempoClaves.count() << "ms.\n";
    std::cout << "Tiempo para realizar " << valores << " pedidos aleatorios de valor en paralelo a todo: " << tiempoValores.count() << "ms.\n";

    std::cout << "Tiempo total para realizar todo lo anterior paralelamente: " << tiempoTotal.count() << "ms.\n\n";

    promedios = valores;
    nClaves = valores;
}

void mismoTiempo(HashMapConcurrente &hashMap)
{
    std::cout << "Se realizarán "<< promedios <<" rondas de promediosParalelos(), claves() y valor() paralelamente a una nueva carga de archivos, la misma a realizarse con "<< cantThreadsLectura <<" hilos.\n\n";

    tiempoComienzo = std::chrono::high_resolution_clock::now();
    t1 = std::thread (cargaArchivos, std::ref(hashMap));
    t2 = std::thread(calcularPromedio, std::ref(hashMap));
    t3 = std::thread(pedirClaves, std::ref(hashMap));
    t4 = std::thread(tomarValores, std::ref(hashMap));

    t1.join();
    t2.join();
    t3.join();
    t4.join();

    tiempoFinal = std::chrono::high_resolution_clock::now();
    tiempoTotal = std::chrono::duration_cast<std::chrono::milliseconds>(tiempoFinal - tiempoComienzo);

    std::cout << "Tiempo para cargar en paralelo a todo: " << tiempoCarga.count() << "ms.\n";
    std::cout << "Tiempo para realizar " << promedios << " promediosParalelos en paralelo a todo: " << tiempoPromedios.count() << "ms.\n";
    std::cout << "Tiempo para realizar " << nClaves << " claves en paralelo a todo: " << tiempoClaves.count() << "ms.\n";
    std::cout << "Tiempo para realizar " << valores << " pedidos aleatorios de valor en paralelo a todo: " << tiempoValores.count() << "ms.\n";

    std::cout << "Tiempo total para realizar todo lo anterior paralelamente: " << tiempoTotal.count() << "ms.\n\n";

    std::cout << "Cantidad de claves: " <<hashMap.claves().size() <<".\n";

    std::cout << "Promedio con " << cantThreadsPromedio << " hilos: " << hashMap.promedioParalelo(cantThreadsPromedio) << ".\n";
}

void valoresSimple(HashMapConcurrente &hashMap)
{
    std::random_device rd; // a seed source for the random number engine
    std::mt19937 gen(rd()); // mersenne_twister_engine seeded with rd()
    std::uniform_int_distribution<> distrib(0, static_cast<int>(claves.size()) - 1);
    for (int i{0}; i < valores; ++i)
        hashMap.valor(claves[distrib(gen)]);
}

void multiplesValoresSimultaneos(HashMapConcurrente &hashMap)
{
    std::cout << "Se realizará 4 hilos estarán pidiendo simultaneamente "<< valores <<" valor().\n\n";
    std::array<std::thread, 4> threads {};
    tiempoComienzo = std::chrono::high_resolution_clock::now();

    for (auto &t : threads)
        t = std::thread(valoresSimple,std::ref(hashMap));

    for (auto &t : threads)
        t.join();

    tiempoFinal = std::chrono::high_resolution_clock::now();
    tiempoTotal = std::chrono::duration_cast<std::chrono::milliseconds>(tiempoFinal - tiempoComienzo);

    std::cout << "Tiempo total para realizar los valores en simultáneo: " << tiempoTotal.count() << "ms.\n\n";
}


int main(int argc, char **argv)
{
    verificacion(argc, argv);
    HashMapConcurrente hashMap{};
    HashMapConcurrente segundo {};
    HashMapConcurrente tercero {};

    tomarDatos(argc, argv);

    std::cout << "Se realizará una carga con un solo hilo de los archivos.\n\n";
    tiempoComienzo = std::chrono::high_resolution_clock::now();

    for (auto &file: filePaths)
        cargarArchivos(hashMap, file);

    tiempoFinal = {std::chrono::high_resolution_clock::now()};
    tiempoTotal = std::chrono::duration_cast<std::chrono::milliseconds>(tiempoFinal - tiempoComienzo);

    claves = hashMap.claves();
    auto promedio = hashMap.promedio();
    auto promedioParalelo = hashMap.promedioParalelo(cantThreadsPromedio);

    promedios = 2000000;/*std::max(static_cast<int>(tiempoTotal.count()), static_cast<int> (claves.size()));*/
    nClaves = promedios;
    valores = promedios;

    std::cout << "La carga duró: " << tiempoTotal.count() << "ms \n";
    std::cout << "Cantidad de claves: " << claves.size() <<'\n';
    std::cout << "Promedio con un hilo: " << promedio << ".\n";
    std::cout << "Promedio con " << cantThreadsPromedio << " hilos: " << promedioParalelo << ".\n\n";

	multiplesValoresSimultaneos(hashMap);
    cargarYPromedio(hashMap);
    cargarYClaves(hashMap);
    cargarYValores(hashMap);
    funcionesLectoras(segundo);

    mismoTiempo(tercero);

    return 0;
}

