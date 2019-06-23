#include <iostream>

int main()
{
	char my_value {' '};
	std::cin>>my_value;
	switch(my_value)
	{
		case 'a':
		{
			std::cout<<"\n[var] \"my_value\" := \""<<my_value<<"\".";
			break;
		}
		default:
		{
			std::cout<<"\n[var] \"my_value\" := \""<<my_value<<"\".";
			break;
		}
	}
}
