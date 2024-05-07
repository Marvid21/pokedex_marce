import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class ColorsGenerator {

  Future<Color> generateCardColor(String pokeImageUrl, List<String> types) async {

    Color cardColor = Colors.black.withOpacity(0.5);

    try {
      final paletteGenerator = await PaletteGenerator.fromImageProvider(NetworkImage(pokeImageUrl));

      switch (types.firstWhere((type) => type.isNotEmpty, orElse: () => '')) {
        case 'grass':
          cardColor = Color.fromARGB(255, 2, 161, 7);
          break;
        case 'fire':
          cardColor = const Color.fromARGB(255, 231, 93, 0);
          break;
        case 'normal':
          cardColor = const Color.fromARGB(255, 192, 192, 192);
          break;
        case 'water':
          cardColor = const Color.fromARGB(255, 24, 151, 255);
          break;
        case 'bug':
          cardColor = const Color.fromARGB(255, 76, 241, 0);
          break;
        case 'electric':
          cardColor = const Color.fromARGB(255, 218, 196, 0);
          break;
        case 'rock':
          cardColor = const Color.fromARGB(255, 150, 102, 84);
          break;
        case 'psychic':
          cardColor = const Color.fromARGB(255, 243, 73, 129);
          break;
        case 'ground':
          cardColor = const Color.fromARGB(255, 197, 171, 123);
          break;
        case 'poison':
          cardColor = const Color.fromARGB(255, 140, 34, 158);
          break;
        case 'ghost':
          cardColor = const Color.fromARGB(255, 102, 27, 116);
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