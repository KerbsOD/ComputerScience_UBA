#include "../ejercicios.h"
#include "gtest/gtest.h"

TEST(puntoFijo, unElemento1){
	vector<int> v = {0};
	int res = puntoFijo(v);
	ASSERT_EQ(0, res);
}

TEST(puntoFijo, unElemento2){
	vector<int> v = {1};
	int res = puntoFijo(v);
	ASSERT_EQ(-1, res);
}

TEST(puntoFijo, noHay){
	vector<int> v = {5, 8, 14, 72};
	int res = puntoFijo(v);
	ASSERT_EQ(-1, res);
}

TEST(puntoFijo, enElMedio){
	vector<int> v = {-10,-8,-2,3,8,10};
	int res = puntoFijo(v);
	ASSERT_EQ(3, res);
}

TEST(puntoFijo, alFinal){
	vector<int> v = {-10,-8,-2,2,3,5};
	int res = puntoFijo(v);
	ASSERT_EQ(5, res);
}

TEST(puntoFijo, repes){
	vector<int> v = {-10,-8,-2,3,4,5};
	int res = puntoFijo(v);
	ASSERT_EQ(3, res);
}