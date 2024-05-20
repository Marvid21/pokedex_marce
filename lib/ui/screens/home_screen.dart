import 'package:flutter/material.dart';
import 'package:pokedex_marce/main.dart';
import 'package:pokedex_marce/models/pokemon_basic_data.dart';
import 'package:pokedex_marce/models/pokemon_stats_data.dart';
import 'package:pokedex_marce/ui/widgets/pokemon_card_item.dart';
import 'package:provider/provider.dart';
import 'package:pokedex_marce/controllers/pokemon_basic_controller.dart';
import 'package:pokedex_marce/controllers/pokemon_more_info_controller.dart';
import 'package:pokedex_marce/controllers/pokemon_stats_controller.dart';
import 'package:pokedex_marce/services/pokemon_basic_service.dart';
import 'package:pokedex_marce/services/pokemon_more_info_service.dart';
import 'package:pokedex_marce/services/pokemon_stats_service.dart';

class HomeScreen extends StatefulWidget {
  static const String routname = "HomeScreen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController();
  int offset = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchPokemons();
    _pageController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_pageController.position.pixels == _pageController.position.maxScrollExtent && !isLoading) {
      fetchPokemons();
    }
  }

  Future<void> fetchPokemons() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });

    await Provider.of<PokemonBasicDataController>(context, listen: false).getAllPokemons(offset);
    final pokemonStatsController = Provider.of<PokemonStatsController>(context, listen: false);
    final pokemonMoreInfoController = Provider.of<PokemonMoreInfoController>(context, listen: false);

    final pokemons = Provider.of<PokemonBasicDataController>(context, listen: false).pokemons;

    for (final pokemon in pokemons.sublist(offset)) {
      if (pokemon.pokemonStatsData == null) {
        await pokemonStatsController.getPokemonStats(pokemon);
      }
      if (pokemon.pokemonMoreInfoData == null) {
        await pokemonMoreInfoController.getPokemonMoreInfoData(pokemon);
      }
    }

    setState(() {
      isLoading = false;
      offset += 20; // Increment the offset to load the next set of Pokémon
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
        backgroundColor: Colors.red,
      ),
      drawer: const NavigationsDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Consumer<PokemonBasicDataController>(
          builder: (context, pokemonBasicDataController, child) {
            final pokemons = pokemonBasicDataController.pokemons;
            if (pokemons.isEmpty && isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                itemCount: pokemons.length,
                itemBuilder: (context, index) {
                  final pokemon = pokemons[index];
                  String pokeIdPadLeft = (index + 1).toString().padLeft(4, '0');
                  
                  String imageUrl = 'https://projectpokemon.org/images/sprites-models/sv-sprites-home/$pokeIdPadLeft.png';
                  //String imageUrl = 'https://assets.pokemon.com/assets/cms2/img/pokedex/full/$pokeIdPadLeft.png';

                  final pokeMoreInfo = pokemon.pokemonMoreInfoData;
                  final pokeStatsData = pokemon.pokemonStatsData;

                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: PokemonCardItem(
                      pokemon: pokemon,
                      pokeMoreInfo: pokeMoreInfo,
                      pokeStatsData: pokeStatsData,
                      imageUrl: imageUrl,
                      id: pokeIdPadLeft,
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}