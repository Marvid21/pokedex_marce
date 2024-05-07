import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:pokedex_marce/models/pokemon_basic_data.dart';
import 'package:pokedex_marce/models/pokemon_more_info_data.dart';
import 'package:pokedex_marce/models/pokemon_stats_data.dart';
import 'package:pokedex_marce/utils/constants.dart' as constants;
import 'package:pokedex_marce/utils/colors_generator.dart';
import 'package:pokedex_marce/controllers/pokemon_favorite_controller.dart';

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
  bool isFavorite = false;

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

    
      bool isFavorite = false;

      Future<void> checkFavorite(String name) async {
        isFavorite = await Provider.of<PokemonFavoriteController>(context).isPokemonFavorite(name);
      }


    return GestureDetector(
      child: Builder(builder: (context) {
        if (colorReady) {
          return Container(
            padding: const EdgeInsets.all(constants.mediumPadding),
            decoration: BoxDecoration(
              color: cardColor,
              border: Border.all(),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Pokemon nro ${widget.id}",
                      style: TextStyle(
                        fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
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
                      child: CachedNetworkImage(
                        imageUrl: widget.imageUrl,
                        fit: BoxFit.cover,
                        height: 200,
                        width: 200,
                        fadeInDuration: const Duration(milliseconds: 150),
                        fadeOutDuration: const Duration(milliseconds: 150),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 50.0, bottom: 50.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(7),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,        
                        children: [             
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: cardColor,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      )
                                    ),
                                    child: Text(
                                      "Attack:",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                      color:  Color.fromARGB(255, 240, 240, 240),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      )
                                    ),
                                    child: Text(
                                    pokeStatsData.attack.toString(),
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
                                    ),
                                  ),
                                  ),
                                
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: cardColor,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      )
                                    ),
                                    child: Text(
                                      "Defense:",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                      color:  Color.fromARGB(255, 240, 240, 240),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      )
                                    ),
                                    child: Text(
                                      pokeStatsData.defense.toString(),
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: cardColor,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      )
                                    ),
                                    child: Text(
                                      "HP:",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                      color:  Color.fromARGB(255, 240, 240, 240),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      )
                                    ),
                                    child: Text(
                                      pokeStatsData.hp.toString(),
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: cardColor,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      )
                                    ),
                                    child: Text(
                                      "Tipo:",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                      color:  Color.fromARGB(255, 240, 240, 240),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      )
                                    ),
                                    child: Text(
                                    pokeMoreInfoData.types?.isNotEmpty ?? false ? pokeMoreInfoData.types![0] : '',
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: FutureBuilder(
                    future: checkFavorite(pokeBasicInfo.name),
                    builder: (context, dataSnapShot) {
                      return IconButton(
                        padding: const EdgeInsets.only(right: constants.mediumPadding),
                        onPressed: () async {
                          await Provider.of<PokemonFavoriteController>(
                            context,
                            listen: false,
                          ).toogleFavoritePokemon(pokeBasicInfo.name);
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: isFavorite ? Colors.pink : Colors.white,
                          size: constants.homeScreenIconSize,
                        ),
                      );
                    },
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
    final pokeMoreInfoData = widget.pokeMoreInfo ?? PokemonMoreInfoData();
    List<String> types = pokeMoreInfoData.types ?? [];
    Color generatedColor = await colorsGenerator.generateCardColor(widget.imageUrl, types);
    if (mounted) {
      setState(() {
        colorReady = true;
        cardColor = generatedColor;
      });
    }
  }
}