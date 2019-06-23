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
				case sf::Event::TextEntered:
				{
					std::cout<<"\nText has been entered ("<<event.text.unicode<<")";
				}
			}
        }
        window.clear();
        window.display();
    }

	return 0;
}
