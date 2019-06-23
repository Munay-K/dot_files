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
				case sf::Event::MouseButtonPressed:
				{
					std::cout<<"\nMouse button has been pressed -> ";
					switch(event.key.code)
					{
						case sf::Mouse::Right:
						{
							std::cout<<"Right button.";
							break;
						}
						case sf::Mouse::Left:
						{
							std::cout<<"Left button.";
							break;
						}
					}
					break;
				}
				case sf::Event::MouseButtonReleased:
				{
					std::cout<<"\nMouse button has been released -> ";
					switch(event.key.code)
					{
						case sf::Mouse::Right:
						{
							std::cout<<"Right button.";
							break;
						}
						case sf::Mouse::Left:
						{
							std::cout<<"Left button.";
							break;
						}
					}
					break;
				}
				case sf::Event::MouseWheelMoved:
				{
					std::cout	<<"\nMouse wheel has been scrolled: "
								<<event.mouseWheel.delta;
					break;
				}
				case sf::Event::MouseMoved:
				{
					std::cout<<"\n\nMouse has been moved";
					std::cout<<"\nmouseMove: (x = "<<event.mouseMove.x<<", y = "<<event.mouseMove.y<<")";
					std::cout<<"\ngetPosition(window): (x = "<<sf::Mouse::getPosition(window).x<<", y = "<<sf::Mouse::getPosition(window).y<<")";
					std::cout<<"\ngetPosition: (x = "<<sf::Mouse::getPosition().x<<", y = "<<sf::Mouse::getPosition().y<<")";
					break;
				}
				case sf::Event::MouseEntered:
				{
					std::cout<<"\nMouse entered the window";
					break;
				}
				case sf::Event::MouseLeft:
				{
					std::cout<<"\nMouse left the window";
					break;
				}
			}
        }
        window.clear();
        window.display();
    }
	return 0;
}
