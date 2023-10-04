#include <stdio.h>
#include <stdint.h>
#include <assert.h>

// Dadas dos posiciones del stack, imprime el stack desde la posición de inicio (inclusive)
// hasta la posición de llegada (exclusive).
void print_stack_from_a_to_b(uint64_t* from, uint64_t* to){
	printf("\n\n");
	printf("------------------ Snooper -----------------\n");
	printf("--------------------------------------------\n");
	printf("Printing stack from: %#010lx\n", (uint64_t) from);
	printf("                 to: %#010lx\n", (uint64_t) to);
	printf("============================================\n");
	int counter = 0;
  while (from < to) {
      printf("[%#010lx (from + %02d)] %#010lx\n", (uint64_t) from, counter, *from);
      from++;
			counter += 8;
  }
   
	printf("============================================\n\n");
	assert(from == to);
}