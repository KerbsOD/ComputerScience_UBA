
template<class T>
ColaPrior<T>::ColaPrior() : cardinal(0), elementos({}) {
}

template<class T>
int ColaPrior<T>::tam() const { 
	return cardinal; 
}

template<class T>
void ColaPrior<T>::encolar(const T& elem) { 
	elementos.push_back(elem);
	cardinal++; 
	
	siftUp(cardinal-1);
}

template<class T>
const T& ColaPrior<T>::proximo() const { 
	return elementos[0]; 	
}

template<class T>
void ColaPrior<T>::desencolar() { 
	swap(elementos[0], elementos[cardinal-1]);
	elementos.pop_back();
	cardinal--;
	
	siftDown(0);
}

template<class T>
ColaPrior<T>::ColaPrior(const vector<T>& elems) { 
	elementos.clear();  
	cardinal = 0;

	for (T e : elems) { 
		encolar(e);
	}
}

template<class T>
void ColaPrior<T>::siftUp(int i) {
	if (i == 0) {
		return;
	}

	int padre = (i-1) / 2;
	if (elementos[padre] < elementos[i]) {
		swap(elementos[padre], elementos[i]);
		siftUp(padre);
	}
}

template<class T>
void ColaPrior<T>::siftDown(int i) {
	int left = 2*i + 1;
	int right = 2*i + 2;
	int indiceMayorHijo = i;

	if (left < cardinal && elementos[indiceMayorHijo] < elementos[left]) {
		indiceMayorHijo = left;
	}
	if (right < cardinal && elementos[indiceMayorHijo] < elementos[right]) {
		indiceMayorHijo = right;
	}

	if (indiceMayorHijo != i) {
		swap(elementos[i], elementos[indiceMayorHijo]);
		siftDown(indiceMayorHijo);
	}
}