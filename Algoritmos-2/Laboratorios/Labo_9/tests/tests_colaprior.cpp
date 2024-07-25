#include <iostream>
#include <algorithm>
#include "gtest-1.8.1/gtest.h"

#include "../src/ColaPrior.h"

using namespace std;

TEST(ColaPrior, DosElementos) {
    ColaPrior<int> q;
    q.encolar(17);
    q.encolar(18);
    ASSERT_EQ(q.proximo(), 18);
    q.desencolar();
    ASSERT_EQ(q.proximo(), 17);
}

TEST(ColaPrior, vacio) {
    ColaPrior<int> q;
    ASSERT_EQ(q.tam(), 0);
}

TEST(ColaPrior, encolarUno) {
    ColaPrior<int> q;
    ASSERT_EQ(q.tam(), 0);
    q.encolar(10);
    ASSERT_EQ(q.tam(), 1);
    ASSERT_EQ(q.proximo(), 10);
}

TEST(ColaPrior, encolarMenor) {
    ColaPrior<int> q;
    ASSERT_EQ(q.tam(), 0);
    q.encolar(5);
    ASSERT_EQ(q.tam(), 1);
    ASSERT_EQ(q.proximo(), 5);
    q.encolar(3);
    ASSERT_EQ(q.tam(), 2);
    ASSERT_EQ(q.proximo(), 5);
    q.encolar(4);
    ASSERT_EQ(q.tam(), 3);
    ASSERT_EQ(q.proximo(), 5);
}

TEST(ColaPrior, encolarMayor) {
    ColaPrior<int> q;
    ASSERT_EQ(q.tam(), 0);
    q.encolar(5);
    ASSERT_EQ(q.tam(), 1);
    ASSERT_EQ(q.proximo(), 5);
    q.encolar(6);
    ASSERT_EQ(q.tam(), 2);
    ASSERT_EQ(q.proximo(), 6);
    q.encolar(7);
    ASSERT_EQ(q.tam(), 3);
    ASSERT_EQ(q.proximo(), 7);
}

TEST(ColaPrior, desencolarMenor) {
    ColaPrior<int> q;
    ASSERT_EQ(q.tam(), 0);
    q.encolar(51);
    q.encolar(42);
    q.encolar(33);
    q.encolar(24);
    q.encolar(15);
    ASSERT_EQ(q.proximo(), 51);
    ASSERT_EQ(q.tam(), 5);
    q.desencolar();
    ASSERT_EQ(q.proximo(), 42);
    ASSERT_EQ(q.tam(), 4);
    q.desencolar();
    ASSERT_EQ(q.proximo(), 33);
    ASSERT_EQ(q.tam(), 3);
    q.desencolar();
    ASSERT_EQ(q.proximo(), 24);
    ASSERT_EQ(q.tam(), 2);
    q.desencolar();
    ASSERT_EQ(q.proximo(), 15);
    ASSERT_EQ(q.tam(), 1);
    q.desencolar();
    ASSERT_EQ(q.tam(), 0);
}

TEST(ColaPrior, desencolarMayor) {
    ColaPrior<int> q;
    ASSERT_EQ(q.tam(), 0);
    q.encolar(15);
    q.encolar(24);
    q.encolar(33);
    q.encolar(42);
    q.encolar(51);
    ASSERT_EQ(q.proximo(), 51);
    ASSERT_EQ(q.tam(), 5);
    q.desencolar();
    ASSERT_EQ(q.proximo(), 42);
    ASSERT_EQ(q.tam(), 4);
    q.desencolar();
    ASSERT_EQ(q.proximo(), 33);
    ASSERT_EQ(q.tam(), 3);
    q.desencolar();
    ASSERT_EQ(q.proximo(), 24);
    ASSERT_EQ(q.tam(), 2);
    q.desencolar();
    ASSERT_EQ(q.proximo(), 15);
    ASSERT_EQ(q.tam(), 1);
    q.desencolar();
    ASSERT_EQ(q.tam(), 0);
}

void mostrar(vector<int>& vec) {
	for (int i = 0; i < vec.size(); i++) {
		cout << vec[i] << " ";
	}
	cout << endl;
}

void siguiente_permutacion(vector<int>& vec, int i) {
    int p = 1;
    while (i > 0 && i % (p + 1) == 0) {
        p++;
        i /= p;
    }
    swap(vec[0], vec[p]);
}

const int MAX_T = 7;

TEST(ColaPrior, encolarDesencolarPermutaciones) {
    // Encola y desencola probando todas las permutaciones
    // posibles de t elementos para t = 1..MAX_T.
    for (int t = 1; t <= MAX_T; t++) {
        vector<int> v;
        int t_factorial = 1;
        for (int i = 1; i <= t; i++) {
            v.push_back(i);
            t_factorial *= i;
        }
        for (int i = 1; i <= t_factorial; i++) {
            ColaPrior<int> q;
            for (int j = 0; j < t; j++) {
                q.encolar(v[j]);
            }
            for (int j = t; j > 0; j--) {
                ASSERT_EQ(q.proximo(), j);
                q.desencolar();
	    }
            siguiente_permutacion(v, i);
        }
    }
}

const int NCLAVES = 1000;

int clave(int i) {
	return NCLAVES * ((i * i - 100 * i) % NCLAVES) + i;
}

TEST(ColaPrior, encolarDesencolar1000) {
    vector<int> v;
    for (int i = 0; i < NCLAVES; i++) {
	v.push_back(clave(i));
    }
    sort(v.begin(), v.end());
    ColaPrior<int> q;
    for (int i = 0; i < NCLAVES; i++) {
        q.encolar(clave(i));
    }
    for (int i = NCLAVES; i > 0; i--) {
	ASSERT_EQ(q.proximo(), v[i - 1]);
	q.desencolar();
    }
}

TEST(ColaPrior, heapifyPermutaciones) {
    // Heapifica y desencola probando todas las permutaciones
    // posibles de t elementos para t = 1..MAX_T.
    for (int t = 1; t <= MAX_T; t++) {
        vector<int> v;
        int t_factorial = 1;
        for (int i = 1; i <= t; i++) {
            v.push_back(i);
            t_factorial *= i;
        }
        for (int i = 1; i <= t_factorial; i++) {
            ColaPrior<int> q(v);
            for (int j = t; j > 0; j--) {
                ASSERT_EQ(q.proximo(), j);
                q.desencolar();
	    }
            siguiente_permutacion(v, i);
        }
    }
}

TEST(ColaPrior, heapify1000) {
    vector<int> v, w;
    for (int i = 0; i < NCLAVES; i++) {
	v.push_back(clave(i));
	w.push_back(clave(i));
    }
    sort(v.begin(), v.end());
    ColaPrior<int> q(w);
    for (int i = NCLAVES; i > 0; i--) {
	ASSERT_EQ(q.proximo(), v[i - 1]);
	q.desencolar();
    }
}

