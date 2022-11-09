#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>
#include <set>

using namespace std;

void insertionSort(vector< int > &v){

    int vs = v.size();
    int j, t;

    for (int i = 1; i < vs; i++)
    {
        j = i;
        t = v[j];
        while (j > 0 && v[j-1] < t)
        {
            v[j] = v[j-1];
            j--;
        }
        v[j] = t;
    }
}

void selectionSort(vector< int > &v){
    for(int i = 0; i < v.size() - 1; i++){
        int min = i;
        for(int j = i + 1; j < v.size(); j++){
            if(v[j] < v[min]){
                min = j;
            }
        }
        swap(v[min], v[i]);
    }
}

void ordenar(vector<int> &items){
	//Poner aca una implementación de ordenar
    selectionSort(items);
}


int bestFit(int W, vector<int> &items){
	multiset<int> restos;
	for(int i=0; i<(int)items.size(); ++i){
		restos.insert(W);
	}
	int res = 0;
	for(int i=0; i<(int)items.size(); ++i){
		multiset<int>::iterator it = restos.lower_bound(items[i]);
		int restoAct = *it;
		if(restoAct==W){
			res++;
		}
		restoAct -= items[i];
		restos.erase(it);
		restos.insert(restoAct);
	}
	return res;
}

int main(){
	int N, W, aux;

	//Se levantan los items y la capacidad del contenedor
	cout << "Se levantan los items y la capacidad del contenedor";
	ifstream bpp("BPP.in");
	bpp >> N >> W;
	vector<int> items;
	for(int i=0; i<N; ++i){
		bpp >> aux;
		items.push_back(aux);
	}
	bpp.close();
	//Se corre best-fit
	int cant1 = bestFit(W, items);
	cout << "Con la idea bestFit, se consigue una asignacion con " << cant1 << " contenedores" << endl;

	//Se ordenan los items
	ordenar(items);
	//Se corre best-fit-decreasing
	int cant2 = bestFit(W, items);
	cout << "Con la idea bestFitDecreasing, se consigue una asignacion con " << cant2 << " contenedores" << endl;

	return 0;
}
