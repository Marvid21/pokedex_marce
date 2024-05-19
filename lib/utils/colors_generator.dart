import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class ColorsGenerator {

  Future<Color> generateCardColor(String pokeImageUrl, List<String> types) async {

    Color cardColor = Colors.black.withOpacity(0.5);

    try {
      final paletteGenerator = await PaletteGenerator.fromImageProvider(NetworkImage(pokeImageUrl));

      switch (types.firstWhere((type) => type.isNotEmpty, orElse: () => '')) {
        case 'grass':
          cardColor = const Color.fromARGB(255, 0, 116, 4);
          break;
        case 'fire':
          cardColor = const Color.fromARGB(255, 255, 51, 0);
          break;
        case 'normal':
          cardColor = const Color.fromARGB(255, 168, 165, 138);
          break;
        case 'water':
          cardColor = const Color.fromARGB(255, 0, 36, 240);
          break;
        case 'bug':
          cardColor = const Color.fromARGB(255, 169, 241, 0);
          break;
        case 'electric':
          cardColor = const Color.fromARGB(255, 255, 238, 0);
          break;
        case 'rock':
          cardColor = const Color.fromARGB(255, 150, 102, 84);
          break;
        case 'psychic':
          cardColor = const Color.fromARGB(255, 195, 0, 255);
          break;
        case 'ground':
          cardColor = const Color.fromARGB(255, 172, 127, 43);
          break;
        case 'poison':
          cardColor = const Color.fromARGB(255, 140, 34, 158);
          break;
        case 'ghost':
          cardColor = const Color.fromARGB(255, 68, 0, 80);
          break;
        case 'fighting':
          cardColor = const Color.fromARGB(255, 143, 0, 0);
          break;
        case 'ice':
          cardColor = const Color.fromARGB(255, 0, 255, 255);
          break;
        case 'flying':
          cardColor = const Color.fromARGB(255, 93, 190, 255);
          break;
        case 'fairy':
          cardColor = const Color.fromARGB(255, 255, 0, 191);
          break;
        case 'dragon':
          cardColor = const Color.fromARGB(255, 15, 0, 102);
          break;
        case 'dark':
          cardColor = const Color.fromARGB(255, 19, 0, 22);
          break;
        case 'steel':
          cardColor = const Color.fromARGB(255, 202, 202, 202);
          break;
        default:
          // Puedes asignar un color por defecto si el tipo no coincide con ninguno de los casos
          cardColor = paletteGenerator.dominantColor!.color.withOpacity(0.25);
          break;
      }

    } catch (error) {
      rethrow;
    }
    return cardColor;
  }
}