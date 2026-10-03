#include "unity.h"

void test_simple(void)
{
    TEST_ASSERT_EQUAL_INT(42, 42);
    TEST_ASSERT_EQUAL_STRING("woody", "woody");
    TEST_ASSERT_TRUE(1);
    TEST_ASSERT_FALSE(0);
}

void test_math(void)
{
    int a = 10;
    int b = 32;
    TEST_ASSERT_EQUAL_INT(42, a + b);
}
