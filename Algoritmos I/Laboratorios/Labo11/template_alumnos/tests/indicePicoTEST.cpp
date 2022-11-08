#include "../ejercicios.h"
#include "gtest/gtest.h"


TEST(indicePico, unElemento){
	vector<int> v = {8};
	int res =  indicePico(v);
	ASSERT_EQ(0, res);
}

TEST(indicePico, bordes){
	vector<int> v = {8,7,9,10};
	bool res =  (0==indicePico(v)) || (3==indicePico(v));
	ASSERT_TRUE(res);
}

TEST(indicePico, mitad){
	vector<int> v = {1,2,3,4,3,2,1};
	int res = indicePico(v);
	ASSERT_EQ(3, res);
}

TEST(indicePico, dosIguales){
	vector<int> v = {1,2,3,4,4,2,1};
	bool res =  (4==indicePico(v)) || (3==indicePico(v));
	ASSERT_TRUE(res);
}

TEST(indicePico, dosPicos){
	vector<int> v = {1,2,3,4,3,5,1};
	bool res =  (3==indicePico(v)) || (5==indicePico(v));
	ASSERT_TRUE(res);
}

TEST(indicePico, MiTest){
    vector<int> v = {1,2,4,8,0};
    bool res =  (3==indicePico(v));
    ASSERT_TRUE(res);
}