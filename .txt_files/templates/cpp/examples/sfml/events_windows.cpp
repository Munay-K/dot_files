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
				case sf::Event::Resized:
				{
					std::cout<<"\nevent.size: (width: "<<event.size.width<<", height: "<<event.size.height<<")";
					std::cout<<"\nwindow.getSize(): (width: "<<window.getSize().x<<", height: "<<window.getSize().y<<")";
					break;
				}
				case sf::Event::LostFocus:
				{
					std::cout<<"\nLost focus";
					break;
				}
				case sf::Event::GainedFocus:
				{
					std::cout<<"\nGained focus";
					break;
				}
			}
        }
        window.clear();
        window.display();
    }

	return 0;
}
