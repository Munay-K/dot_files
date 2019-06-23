#include <SFML/Graphics.hpp>
#include <iostream>

int main()
{
    sf::RenderWindow window(sf::VideoMode(600, 600), "SFML window");
	sf::Texture texture;
	
	if(!texture.loadFromFile("img/background_pattern.png"))
		throw std::runtime_error("\nFile couldn't be loaded");
	
	texture.setRepeated(true);

	sf::Sprite sprite;
	sprite.setTexture(texture);
	sprite.setTextureRect(sf::IntRect(0, 0, window.getSize().x, window.getSize().y));

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
					sprite.setTextureRect(sf::IntRect(0, 0, window.getSize().x, window.getSize().y));
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
