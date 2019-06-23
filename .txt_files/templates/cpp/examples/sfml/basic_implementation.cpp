#include <SFML/Graphics.hpp>

int main()
{
    sf::RenderWindow window(sf::VideoMode(100, 100), "SFML window");
	sf::CircleShape shape(100.f);

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
        window.clear();
		window.draw(shape);
        window.display();
    }

	return 0;
}
