#include <iostream>

#define EXAMPLE 1

int main()
{
	#if EXAMPLE == 1
		std::cout<<"Example 1";
	#elif EXAMPLE == 2
		std::cout<<"Example 2";
	#else
		std::cout<<"None of the examples";
	#endif
	return 0;
}
