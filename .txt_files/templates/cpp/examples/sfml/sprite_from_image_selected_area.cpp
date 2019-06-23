#include <SFML/Graphics.hpp>

int main()
{
    sf::RenderWindow window(sf::VideoMode(100, 100), "SFML window");
	sf::Texture texture;

	if(!texture.loadFromFile("img/mario.png"))
		throw std::runtime_error("\nFile couldn't be loaded");

	sf::Sprite sprite(texture);

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
		window.draw(sprite);
        window.display();
    }

	return 0;
}
