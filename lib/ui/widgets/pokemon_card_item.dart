import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pokedex_marce/models/pokemon_basic_data.dart';
import 'package:pokedex_marce/models/pokemon_more_info_data.dart';
import 'package:pokedex_marce/models/pokemon_stats_data.dart';
import 'package:pokedex_marce/utils/constants.dart' as constants;
import 'package:pokedex_marce/utils/colors_generator.dart';

class PokemonCardItem extends StatefulWidget {
  final PokemonBasicData pokemon;
  final PokemonMoreInfoData? pokeMoreInfo;
  final PokemonStatsData? pokeStatsData;
  final String imageUrl;
  final String id;

  const PokemonCardItem(
    {Key? key,
      required this.pokemon,
      this.pokeMoreInfo,
      this.pokeStatsData,
      required this.imageUrl,
      required this.id
    }
  ): super(key: key);

  @override
  State<PokemonCardItem> createState() => _PokemonCardItemState();
}

class _PokemonCardItemState extends State<PokemonCardItem> {
  Color cardColor = Colors.transparent;
  late Map<String, String> getPokemonIdAndImage;
  bool colorReady = false;

  @override
  void initState() {
    generateContainerColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pokeBasicInfo = widget.pokemon;
    final pokeMoreInfoData = widget.pokeMoreInfo ?? PokemonMoreInfoData();
    final pokeStatsData = widget.pokeStatsData ?? PokemonStatsData(attack: 0, defense: 0, hp: 0);

    return GestureDetector(
      child: Builder(builder: (context) {
        if (colorReady) {
          return Container(
            padding: const EdgeInsets.all(constants.mediumPadding),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: 
                BorderRadius.circular(constants.containerCornerRadius)
            ),
            child: 
              Column(
                children: [
                  Text("Pokemon nro ${widget.id}",
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.bodySmall?.fontSize
                    ),
                  ),
                  Text(
                    pokeBasicInfo.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize,
                    ),
                  ),
                  Hero(
                    tag: pokeBasicInfo.name,
                    child: 
                      CachedNetworkImage(
                        imageUrl: widget.imageUrl,
                        fit: BoxFit.cover,
                        height: 110,
                        width: 100,
                        fadeInDuration: const Duration(milliseconds: 150),
                        fadeOutDuration: const Duration(milliseconds: 150),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                  ),
                  Text(
                    "Attack: ${pokeStatsData.attack}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
                    ),
                  ),
                  Text(
                    "Defense: ${pokeStatsData.defense}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
                    ),
                  ),
                  Text(
                    "HP: ${pokeStatsData.hp}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
                    ),
                  ),
                  Text(
                    pokeMoreInfoData.types?.join(', ') ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
                    ),
                  ),
                ],
              ),
          );
        } else {
          return const Center(child: CircularProgressIndicator(color: constants.circularProgressIndicatorColor));
        }
      }),
    );
  }

  Future<void> generateContainerColor() async {
    ColorsGenerator colorsGenerator = ColorsGenerator();
    Color generatedColor = await colorsGenerator.generateCardColor(widget.imageUrl);
    if (mounted) {
      setState(() {
        colorReady = true;
        cardColor = generatedColor;
      });
    }
  }
}