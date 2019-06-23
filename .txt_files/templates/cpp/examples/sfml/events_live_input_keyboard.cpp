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

		if(sf::Keyboard::isKeyPressed(sf::Keyboard::Space))
		{
			std::cout<<"\nJump player"<<std::endl;
		}
		else
		{
			std::cout<<"\nNot jumping";
		}
        window.clear();
        window.display();
    }

	return 0;
}
