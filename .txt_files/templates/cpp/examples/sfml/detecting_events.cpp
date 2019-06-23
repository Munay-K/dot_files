#include <SFML/Graphics.hpp>

#define EVENT_DETECTER 1

int main()
{
    sf::RenderWindow window(sf::VideoMode(100, 100), "SFML window");
    while (window.isOpen())
    {
        sf::Event event;
        while (window.pollEvent(event))
        {
			#if EVENT_DETECTER == 1
				if (event.type == sf::Event::Closed)
				{
					window.close();
				}
			#elif EVENT_DETECTER == 2
				switch(event.type)
				{
					case sf::Event::Closed:
					{
						window.close();
						break;
					}
				}
			#endif
        }
        window.clear();
        window.display();
    }

	return 0;
}
