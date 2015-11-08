#include "minunit.h"
#include <stdlib.h>


/**
    Binary search algorithm playground in C language
    Using MinUnit library for testing

    TODO: 
        0. Push the code to Bitbucket
        1. hook up bsearch function from stdlib.h and invoke it 
        2. write tests to understand better how it behaves
        3. write my own implementation of binary sort
        4. use the same test suite to verify it
 */


static int array[] = { 5, 6, 7 };


MU_TEST(test_check_fail) {
	mu_assert(5 == 7, "5 should equal 7!");	
}

MU_TEST(another_fail) {
    mu_assert_int_eq(4, 7);
}

MU_TEST_SUITE(test_suite) {
    MU_RUN_TEST(test_check_fail);
    MU_RUN_TEST(another_fail);
}

int main(int argc, char *argv[]) {
    MU_RUN_SUITE(test_suite);
    MU_REPORT();
    return 0;
}

