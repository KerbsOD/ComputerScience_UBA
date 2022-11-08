#include "../ejercicios.h"
#include "gtest/gtest.h"

TEST(encontrarRotado, unElemento){
	vector<int> v = {2};
	int index = encontrarRotado(v, 2);
	ASSERT_EQ(0, index);
}

TEST(encontrarRotado, sinElemento1){
	vector<int> v = {2};
	int index = encontrarRotado(v, 0);
	ASSERT_EQ(-1, index);
}

TEST(encontrarRotado, sinElemento2){
	vector<int> v = {21,42,78,152};
	int index = encontrarRotado(v, 10);
	ASSERT_EQ(-1, index);
}

TEST(encontrarRotado, sinRotarAsc){
	vector<int> v = {2,5,8,9,11,15};
	int index = encontrarRotado(v, 8);
	ASSERT_EQ(2, index);
}


TEST(encontrarRotado, rotadoAlPrincipio){
	vector<int> v = {15,2,4,13,14};
	int index = encontrarRotado(v, 15);
	ASSERT_EQ(0, index);
}

TEST(encontrarRotado, rotadoAlFinal){
	vector<int> v = {20,25,28,32,60,2};
	int index = encontrarRotado(v, 2);
	ASSERT_EQ(5, index);
}

TEST(encontrarRotado, rotadoMedio){
	vector<int> v = {15,16,7,9,11,14};
	int index = encontrarRotado(v, 9);
	ASSERT_EQ(3, index);
}
