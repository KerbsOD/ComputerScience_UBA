#include "ejercicios.h"
// EJERCICIO 1///////////////////////////////////////////////////////////////////////////////////////////


vector<vector<int> > productoVectorial(vector<int> u, vector<int> v){
	//COMPLETAR
	vector<vector<int>> res(u.size(), vector<int>(v.size()));

	for(int i = 0; i < u.size(); i++){
		for(int j = 0; j < v.size(); j++){
			res[i][j] = u[i]*v[j];
		}
	}

	return res;
}


// EJERCICIO 2 ///////////////////////////////////////////////////////////////////////////////////////////


void trasponer(vector<vector<int> > &m) {
	//COMPLETAR

	vector<vector<int>> res(m.size(), vector<int>(m.size()));                         

    for(int i = 0; i < m.size(); i++){
		for(int j = 0; j < m.size(); j++){
            res[i][j] = m[j][i];
        }
	}

	for(int i = 0; i < m.size(); i++){
		for(int j = 0; j < m.size(); j++){
            m[i][j] = res[i][j];
        }
	}
	
}


// EJERCICIO 3 ///////////////////////////////////////////////////////////////////////////////////////////


vector<vector<int> > multiplicar(vector<vector<int> > m1, vector<vector<int> > m2){
	//COMPLETAR
	
	vector<vector<int>> res(m1.size(), vector<int>(m2[0].size()));

    for(int i = 0; i < m1.size(); i++){
        for(int k = 0; k < m2[0].size(); k++){
            for(int j = 0; j < m1[0].size(); j++){
                res[i][k] = res[i][k] + (m1[i][j] * m2[j][k]);
            }
        }
    }
	
	
	return res;
}


// EJERCICIO 4 ///////////////////////////////////////////////////////////////////////////////////////////


int sumaVecinos(vector<vector<int>> m, int i, int j);
bool vecinosEnRango(vector<vector<int>> m, int i, int j);
int cantidadVecinos(vector<vector<int>> m, int i, int j);

vector<vector<int> > promediar(vector<vector<int> > m){
	//COMPLETAR

	vector<vector<int>> res(m.size(), vector<int>(m[0].size()));
    
    for(int i = 0; i < m.size(); i++){
        for(int j = 0; j < m[0].size(); j++){
            res[i][j] = (sumaVecinos(m, i, j) / cantidadVecinos(m, i, j));
        }
    }

	return res;
}


int sumaVecinos(vector<vector<int>> m, int i, int j){

    int suma = 0;

    for(int a = i - 1; a <= i + 1; a++){
        for(int b = j - 1; b <= j + 1; b++){
            if(vecinosEnRango(m, a, b)){
                suma = suma + m[a][b];
            }
        }
    }

    return suma;
}

bool vecinosEnRango(vector<vector<int>> m, int i, int j){
    return (0 <= i  && i < m.size() && 0 <= j && j < m[0].size());
}

int cantidadVecinos(vector<vector<int>> m, int i, int j){

    int suma = 0;

    for(int a = i - 1; a <= i + 1; a++){
        for(int b = j - 1; b <= j + 1; b++){
            if(vecinosEnRango(m, a, b)){
                suma++;
            }
        }
    }

    return suma;
}


// EJERCICIO 5 ///////////////////////////////////////////////////////////////////////////////////////////


bool esPico(vector<vector<int>> m, int i, int j);
bool enRango(vector<vector<int> > m, int a, int b);

int contarPicos(vector<vector<int>> m){
	int suma = 0;

    for(int i = 0; i < m.size(); i++){
        for(int j = 0; j < m[0].size(); j++){
            if(esPico(m, i, j)){
                suma++;
            }
        }
    }
	return suma;
}

bool esPico(vector<vector<int>> m, int i, int j){
    
    bool pico = true;

    for(int a = i - 1; a <= i + 1; a++){
        for(int b = j - 1; b <= j + 1; b++){
            if (enRango(m, a, b) && (m[i][j] <= m[a][b]) && !(a == i && b == j)){
                pico = false;
            }
        }
    }

    return pico;
}

bool enRango(vector<vector<int> > m, int a, int b){
    return((0 <= a) && (a < m.size()) && (0 <= b) && (b < m[0].size()));
}


// EJERCICIO 6 ///////////////////////////////////////////////////////////////////////////////////////////


bool esTriangularSuperior(vector<vector<int> > m);
bool esTriangularInferior(vector<vector<int> > m);

bool esTriangular(vector<vector<int> > m){
	return (esTriangularSuperior(m) || esTriangularInferior(m));
}

bool esTriangularSuperior(vector<vector<int> > m){

    bool esTriangular = true;

    for(int i = 0; i < m.size(); i++){
        for(int j = 0; j < m[0].size(); j++){
            if(i > j && m[i][j] != 0){
                esTriangular = false;
            }
        }
    }

    return esTriangular;
}

bool esTriangularInferior(vector<vector<int> > m){
    
    bool esTriangular = true;

    for(int i = 0; i < m.size(); i++){
        for(int j = 0; j < m[0].size(); j++){
            if(i < j && m[i][j] != 0){
                esTriangular = false;
            }
        }
    }

    return esTriangular;
}


// EJERCICIO 7 ///////////////////////////////////////////////////////////////////////////////////////////


bool existeAmenaza(vector<vector<int> > m);
bool amenazaAlguna(vector<vector<int> > m, int i1, int j1);
bool seAmenazan(int i1, int  j1, int  i2, int j2);

bool hayAmenaza(vector<vector<int> > m){
	return existeAmenaza(m);
}

bool existeAmenaza(vector<vector<int> > m){

    bool existeAmenaza = false;

    for(int i1 = 0; i1 < m.size(); i1++){
        for(int j1 = 0; j1 < m[0].size(); j1++){
            if(m[i1][j1] == 1 && amenazaAlguna(m, i1, j1)){
                existeAmenaza = true;
            }
        }
    }

    return existeAmenaza;
}

bool amenazaAlguna(vector<vector<int> > m, int i1, int j1){
    
    bool amenazaAlguna = false;

    for(int i2 = 0; i2 < m.size(); i2++){
        for(int j2 = 0; j2 < m[0].size(); j2++){
            if(m[i2][j2] == 1 && seAmenazan(i1, j1, i2, j2)){
                amenazaAlguna = true;
            }
        }
    }

    return amenazaAlguna;
}


bool seAmenazan(int i1, int  j1, int  i2, int j2){
    return((i1 != i2 || j1 != j2) && (i1 == i2 || j1 == j2 || abs(i1 - i2) == abs(j1 - j2)));
}


// EJERCICIO 8 ///////////////////////////////////////////////////////////////////////////////////////////


int sumaDiagonal(vector<vector<int>> m);
int sumaDiagonalPerpendicular(vector<vector<int>> m);

int diferenciaDiagonales(vector<vector<int> > m) {
    return (abs(sumaDiagonal(m) - sumaDiagonalPerpendicular(m)));
}

int sumaDiagonal(vector<vector<int>> m){
    
    int suma = 0;

    for(int i = 0; i < m.size(); i++){
        suma = suma + m[i][i];
    }

    return suma;
}

int sumaDiagonalPerpendicular(vector<vector<int>> m){
    
    int suma = 0;

    for(int i = m.size()-1; i >= 0; i--){
        suma = suma + m[i][m.size() - i - 1];
    }

    return suma;
}


// EJERCICIO 9///////////////////////////////////////////////////////////////////////////////////////////

// Usamos numeros para describir los 3 posibles estados de las casillas
// 0: Casilla Vacía
// 1: Casilla con "X"
// 2: Casilla con "O"
bool terminada(vector<vector<int>> m);


bool taTeTi(vector<vector<int>> m){
    return(terminada(m));
}


bool terminada(vector<vector<int>> m){

    bool terminada = true;

    for(int i = 0; i < 3; i++){
        for(int j = 0; j < 3; j++){
            if(m[i][j] == 0){
                terminada = false;
            }
        }
    }

    return (terminada);
}


// EJERCICIO 10///////////////////////////////////////////////////////////////////////////////////////////

