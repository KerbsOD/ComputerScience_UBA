#include "../ejercicios.h"
#include "gtest/gtest.h"


TEST(menorMasGrande, unElemento){
	vector<int> v = {20};
	int x = 20;
	int res = menorMasGrande(v,x);
	ASSERT_EQ(0, res);
}

TEST(menorMasGrande, noHayMasGrande){
	vector<int> v = {18,19,31,46,47,48};
	int x = 49;
	int res = menorMasGrande(v,x);
	ASSERT_EQ(-1, res);
}

TEST(menorMasGrande, variosSeguidos){
	vector<int> v = {17,19,31,46,47,48};
	int x = 45;
	int res = menorMasGrande(v,x);
	ASSERT_EQ(3, res);
}

TEST(menorMasGrande, elMenor){
	vector<int> v = {17,19,31,46,47,48};
	int x = 2;
	int res = menorMasGrande(v,x);
	ASSERT_EQ(0, res);
}