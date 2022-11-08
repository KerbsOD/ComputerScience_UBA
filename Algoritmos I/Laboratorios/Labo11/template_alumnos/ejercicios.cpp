#include "ejercicios.h"
#include "time.h"
#include <ctime>
#include "stdlib.h"
#include <string>
#include<iostream>

using namespace std;

int busquedaBinaria(vector<int> v, int x){

    if(v.size() > 0){
        if(v[0] >= v[v.size()-1]){
            int low = 0;
            int high = v.size()-1;

            while(low <= high){

                int mid = (low + high) / 2;

                if(v[mid] == x){
                    return mid;
                }

                if(v[mid] > x){
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }

            }
        }
    }

    int low = 0;
    int high = v.size()-1;

    while(low <= high){

        int mid = (low + high) / 2;

        if(v[mid] == x){
            return mid;
        }

        if(v[mid] < x){
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return -1;
}

int busquedaJumpSearch(vector<int> v, int x){
    int lastEntero;
    int low;
    int high;

    for(int i = 1; i < v.size(); i++){
        if(v.size() % i == 0){
            lastEntero = i;
        }
    }

    for(int i = 0; i < v.size(); i = i + lastEntero){
        if(v[i] < x && v[i + lastEntero] >= x){
            low = v[i+1];
            high = v[i + lastEntero];
        }
    }

    for(int i = low; i <= high; i++){
        if(x == v[i]){
            return i;
        }
    }

	return -1;
}

int buscar(vector<int> v, int x){
    return busquedaBinaria(v, x);
    //return busquedaJumpSearch(v, x);
}


void tiempos() {

        int i = 1000000;

        cout << "n = " << i << "\n";
        vector<int> v = construir_vector(i, "asc");

        clock_t begin = clock();
        busquedaBinaria(v, 80);
        clock_t end = clock();
        double elapsed_msecs = double(end - begin) / CLOCKS_PER_SEC  * 1000; // mide el tiempo en milisegundos
        cout <<  "Busqueda Binaria: " << elapsed_msecs << "\n";

        clock_t begin2 = clock();
        busquedaJumpSearch(v, 80);
        clock_t end2 = clock();
        double elapsed_msecs2 = double(end2 - begin2) / CLOCKS_PER_SEC  * 1000; // mide el tiempo en milisegundos
        cout <<  "JumpSearch: " << elapsed_msecs2 << "\n";

        cout << "\n";

}

void tiempos2(){

    vector<int> v = construir_vector(10000, "asc");

    // A
    clock_t begin = clock();
    v.size();
    clock_t end = clock();
    double elapsed_msecs = double(end - begin) / CLOCKS_PER_SEC  * 1000; // mide el tiempo en milisegundos
    cout << "v.size(): " << elapsed_msecs << "\n";


    // B
    clock_t begin2 = clock();
    v.push_back(454);
    clock_t end2 = clock();
    double elapsed_msecs2 = double(end2 - begin2) / CLOCKS_PER_SEC  * 1000; // mide el tiempo en milisegundos
    cout << "v.push_back(x): " << elapsed_msecs2 << "\n";



    // C
    clock_t begin3 = clock();
    v.pop_back();
    clock_t end3 = clock();
    double elapsed_msecs3 = double(end3 - begin3) / CLOCKS_PER_SEC  * 1000; // mide el tiempo en milisegundos
    cout << "v.pop_back(): " << elapsed_msecs3 << "\n";

    // D
    clock_t begin4 = clock();
    v[647];
    clock_t end4 = clock();
    double elapsed_msecs4 = double(end4 - begin4) / CLOCKS_PER_SEC  * 1000; // mide el tiempo en milisegundos
    cout << "v[i]: " << elapsed_msecs4 << "\n";


    // E
    clock_t begin5 = clock();
    v[647] = 56745;
    clock_t end5 = clock();
    double elapsed_msecs5 = double(end5 - begin5) / CLOCKS_PER_SEC  * 1000; // mide el tiempo en milisegundos
    cout << "v[i] = e: " << elapsed_msecs5 << "\n";


    // F
    vector<bool> vbool = {1,0,1,1,1,0,0,0,1,0};
    clock_t begin6 = clock();
    vbool.flip();
    clock_t end6 = clock();
    double elapsed_msecs6 = double(end6 - begin6) / CLOCKS_PER_SEC  * 1000; // mide el tiempo en milisegundos
    cout << "v.flip(): " << elapsed_msecs6 << "\n";


    // G
    clock_t begin7 = clock();
    v.clear();
    clock_t end7 = clock();
    double elapsed_msecs7 = double(end7 - begin7) / CLOCKS_PER_SEC  * 1000; // mide el tiempo en milisegundos
    cout << "v[i] = e: " << elapsed_msecs7 << "\n";

    // H
    vector<int> v2 = construir_vector(1000, "asc");
    clock_t begin8 = clock();
    v2.empty();
    clock_t end8 = clock();
    double elapsed_msecs8 = double(end8 - begin8) / CLOCKS_PER_SEC  * 1000; // mide el tiempo en milisegundos
    cout << "v.empty(): " << elapsed_msecs8 << "\n";
}


vector<int> construir_vector(int size, string mode){
    vector<int> res {};
    time_t t;
    srand((unsigned) time(&t));
    int base = rand() % 100;
    int step;
    for(int i = 0; i < size; i++){
        step = rand() % 100;
        if(mode == "asc") {
            res.push_back(base+step);
            base += step;
        }
        if(mode == "desc"){
            res.push_back(base-step);
            base -= step;
        }
        if(mode == "azar"){
            res.push_back(step);
        }
        if(mode == "iguales"){
            res.push_back(base);
        }
    }
    return res;
}



int indicePico(vector<int> v){

    int low = 0;
    int high = v.size()-1;

    while(low <= high){
        int mid = (low + high) / 2;

        if((mid == 0 || v[mid] >= v[mid-1]) && (mid == v.size() || v[mid] >= v[mid+1])){
            return mid;
        }

        if(mid > 0 && v[mid-1] > v[mid]){
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

	return -1;
}

int puntoFijo(vector<int> v){

    int low = 0;
    int high = v.size() - 1;

    while(low <= high){

        int mid = (low + high) / 2;

        if(v[mid] == mid && v[mid-1] != mid - 1){
            return mid;
        }

        if(v[mid] < mid){
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
	return -1;
}

int encontrarRotado(vector<int> v, int x) {

    int low = 0;
    int high = v.size() - 1;

    while (low <= high) {

        int mid = (low + high) / 2;

        if (v[mid] == x) {
            return mid;
        }

        if (v[mid] < x) {
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    if (v[0] == x){
        return 0;
    }

    if(v[v.size()-1] == x){
        return v.size() - 1;
    }

	return -1;
}

int menorMasGrande(vector<int> v, int x) {

    if (v.size() == 1) {
     return 0;
    }

    int low = 0;
    int high = v.size() - 1;

    while (low <= high) {

        int mid = (low + high) / 2;

        if (v[mid] > x && v[mid-1] <= x) {
            return mid;
        }

        if(v[mid] < x){
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

	return -1;
}

vector<int> masCercanoK(vector<int> v, int k,  int x){

    vector<int> res;


    return res;
}



