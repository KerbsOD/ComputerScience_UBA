#ifndef _COLAPRIOR_H_
#define _COLAPRIOR_H_

#include <vector>

using namespace std;

template<class T>
class ColaPrior {
public:
	ColaPrior();
	int tam() const;
	void encolar(const T& elem);
	const T& proximo() const;
	void desencolar();
	ColaPrior(const vector<T>& elems);

private:
	int cardinal;
	vector<T> elementos;
	void siftUp(int i);
	void siftDown(int i);
};

#include "ColaPrior.hpp"

#endif /*_COLAPRIOR_H_*/
