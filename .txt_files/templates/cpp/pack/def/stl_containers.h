#ifndef STL_CONTAINERS_UTILITIES
#define STL_CONTAINERS_UTILITIES

#include <vector>
#include <iostream>

template <typename T>
void print(std::vector<T> values)
{
	for(int i {0}; i<values.size(); i++)
		std::cout<<values[i];
}

#endif // STL_CONTAINERS_UTILITIES
