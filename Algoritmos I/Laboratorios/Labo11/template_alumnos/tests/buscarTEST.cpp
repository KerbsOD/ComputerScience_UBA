#include "../ejercicios.h"
#include "gtest/gtest.h"
#include <string>


TEST(buscar, unElemento){
	vector<int> v = {8};
	int x = 8;
	int res =  buscar(v, x);
	ASSERT_EQ(0, res);
}

TEST(buscar, unElementoNoEsta){
	vector<int> v = {8};
	int x = 7;
	int res =  buscar(v, x);
	ASSERT_EQ(-1, res);
}

TEST(buscar, dosElementos){
	vector<int> v = {8,6};
	int x = 6;
	int res =  buscar(v, x);
	ASSERT_EQ(1, res);
}

TEST(buscar, variosDesc){
	vector<int> v = {8,6,4,2,1,0};
	int x = 1;
	int res =  buscar(v, x);
	ASSERT_EQ(4, res);
}

TEST(buscar, variosAsc){
	vector<int> v = {10,15,16,48,52,79};
	int x = 48;
	int res =  buscar(v, x);
	ASSERT_EQ(3, res);
}

TEST(buscar, alPrincipio){
	vector<int> v = {10,15,16,48,52,79};
	int x = 10;
	int res =  buscar(v, x);
	ASSERT_EQ(0, res);
}

TEST(buscar, alFinal){
	vector<int> v = {10,15,16,48,52,79};
	int x = 79;
	int res =  buscar(v, x);
	ASSERT_EQ(5, res);
}

TEST(buscar, noEsta){
	vector<int> v = {10,15,16,48,52,79};
	int x = 40;
	int res =  buscar(v, x);
	ASSERT_EQ(-1, res);
}

