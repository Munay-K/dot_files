#include <SFML/Graphics.hpp>
#include <iostream>

int main()
{
    sf::RenderWindow window(sf::VideoMode(100, 100), "SFML window");

    while (window.isOpen())
    {
        sf::Event event;
        while (window.pollEvent(event))
        {
			switch(event.type)
			{
				case sf::Event::Closed:
				{
					window.close();
					break;
				}
			}
        }

		if(sf::Mouse::isButtonPressed(sf::Mouse::Left))
		{
			std::cout<<"\nFire!"<<std::endl;
		}
		else
		{
			std::cout<<"\nDon't fire";
		}
        window.clear();
        window.display();
    }

	return 0;
}
