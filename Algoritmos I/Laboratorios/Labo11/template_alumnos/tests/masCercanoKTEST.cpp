#include "../ejercicios.h"
#include "gtest/gtest.h"

TEST(masCercanoK, unoDeDiferencia){
	vector<int> v = {16,17,18};
	int x = 17;
	int k = 1;
	vector<int> res = masCercanoK(v, k, x);
	vector<int> expected = {16};
	ASSERT_EQ(expected, res);
}

TEST(masCercanoK, ordenAsc){
	vector<int> v = {16,17,19,21,22,23};
	int x = 18;
	int k = 3;
	vector<int> res = masCercanoK(v, k, x);
	vector<int> expected = {16,17,19};
	ASSERT_EQ(expected, res);
}

TEST(masCercanoK, ordenDesc){
	vector<int> v = {35,30,28,26,24,17,8};
	int x = 18;
	int k = 4;
	vector<int> res = masCercanoK(v, k, x);
	vector<int> expected = {8,17,24,26};
	ASSERT_EQ(expected, res);
}

TEST(masCercanoK, enVector){
	vector<int> v = {35,30,28,26,24,17,8};
	int x = 30;
	int k = 1;
	vector<int> res = masCercanoK(v, k, x);
	vector<int> expected = {28};
	ASSERT_EQ(expected, res);
}

TEST(masCercanoK, pideMasDeLosQueHay){
	vector<int> v = {24,17,8};
	int x = 30;
	int k = 4;
	vector<int> res = masCercanoK(v, k, x);
	vector<int> expected = {8,17,24};
	ASSERT_EQ(expected, res);
}