import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class ColorsGenerator {

  Future<Color> generateCardColor(String pokeImageUrl) async {

    Color cardColor = Colors.black.withOpacity(0.5);

    try {
      final paletteGenerator = await PaletteGenerator.fromImageProvider(NetworkImage(pokeImageUrl));

      if (paletteGenerator.dominantColor != null) {
        cardColor = paletteGenerator.dominantColor!.color.withOpacity(0.25);
      }
    } catch (error) {
      rethrow;
    }
    return cardColor;
  }
}