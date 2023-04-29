//#include "headerDeLasFunciones"
#include <gtest/gtest.h>

// TESTS ////////////////////////////


/////////////////////////////////////


// IMPORTANTE: argc y argv. Si no, no lo detecta la extension.
int main(int argc, char* argv[]) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}