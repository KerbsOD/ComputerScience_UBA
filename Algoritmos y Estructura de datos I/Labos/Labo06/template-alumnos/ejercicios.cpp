#include "ejercicios.h"


// Ejercicio 1
bool existePico(vector<int> v){
	int longitud = v.size();
	int i = 1;
	bool hayPico = false;

	while(i < longitud) {
		hayPico = ((v[i] > v[i-1]) && (v[i] > v[i+1]));
		if(hayPico) {
			break;
		}
		i++;
	}

	return (hayPico && longitud > 2);
}

// Ejercicio 2
int maximo(int x, int y){
    if(x<0)
        x=-x;
    if(y<0)
        y=-y;
    if(x>y)
        return x;
    else
        return y;
}

int minimo(int x, int y){
    if(x<0)
        x=-x;
    if(y<0)
        y=-y;
    if(x<y)
        return x;
    else
        return y;
}

int mcd(int m, int n){
	int a = maximo(m,n);
    int b = minimo(m,n);
    int resto;
    while(b>0){
        resto = a%b;
        a = b;
        b = resto;
    }
    if(b==0)
        return a;
    else
        return 1;
}

// Ejercicio 3
int indiceMinSubsec(vector<int> s, int l, int r){
    int k = l;
    
	for (int i = l; i <= r; i++) {
        if (s[i] < s[k]){
			k = i;
		} 
    }

    return k;
}

// Ejercicio 4
bool isSorted(vector<int> v){
	int i = 0;
	bool ordenado = true;

	while(i < v.size()-1){
		ordenado = (v[i] <= v[i+1]);
		if(!ordenado){
			return false;
		}
		i++;
	}
	return true;
}

void ordenar1(vector<int>& v){
	
	while(!isSorted(v)){
		for(int i = 0; i < v.size()-1; i++){
			if(v[i] > v[i+1]){
				swap(v[i], v[i+1]);
				i=0;
			}
		}
	}
	return;
}

// Ejercicio 5
bool isSorted(vector<int> v){
	int i = 0;
	bool ordenado = true;

	while(i < v.size()-1){
		ordenado = (v[i] <= v[i+1]);
		if(!ordenado){
			return false;
		}
		i++;
	}
	return true;
}

void ordenar2(vector<int>& v){
	
	while(!isSorted(v)){
		for(int i = 0; i < v.size()-1; i++){
			if(v[i] > v[i+1]){
				swap(v[i], v[i+1]);
				i=0;
			}
		}
	}
	return;
}

// Ejercicio 6
tuple<int,int> division(int n, int d){
	
	int q, r;

	if(n >= d){
		q = n / d;
		r = n % d;
	} else {
		q = d / n;
		r = d % n;
	}

	return make_tuple(q,r);
}
