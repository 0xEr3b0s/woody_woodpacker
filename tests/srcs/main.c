#include "unity.h"
#include "test.h"

void setUp(void) {}
void tearDown(void) {}

int main(void)
{
	UNITY_BEGIN();

	// examples
	if (DEBUG) {
		RUN_TEST(test_simple);
		RUN_TEST(test_math);
	}

	return UNITY_END();
}
