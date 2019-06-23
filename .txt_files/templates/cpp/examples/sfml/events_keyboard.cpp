#include <SFML/Graphics.hpp>

#include <iostream>

int main()
{
    sf::RenderWindow window(sf::VideoMode(800, 600), "SFML window");
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
				case sf::Event::KeyPressed:
				{
					switch(event.key.code)
					{
						case sf::Keyboard::A:
						{
							std::cout<<"\nKey A pressed";
							break;
						}
					}
					break;
				}
				case sf::Event::KeyReleased:
				{
					switch(event.key.code)
					{
						case sf::Keyboard::J:
						{
							std::cout<<"\nKey J released";
							break;
						}
					}
				}
			}
        }
        window.clear();
        window.display();
    }
	return 0;
}
