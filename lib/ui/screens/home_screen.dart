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
  final _scrollController = ScrollController();
  int offset = 0;

  @override
  void initState() {
    super.initState();
    pokemonLazyLoading();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
        child: FutureBuilder(
          future: fetchPokemons(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                controller: _scrollController,
                itemCount: Provider.of<PokemonBasicDataController>(context).pokemons.length,
                itemBuilder: (context, index) {
                  final pokemon = Provider.of<PokemonBasicDataController>(context).pokemons[index];
                  final pokeMoreInfoController = Provider.of<PokemonMoreInfoController>(context);
                  final pokeStatsDataController = Provider.of<PokemonStatsController>(context);
                  String pokeIdPadLeft = (index + 1).toString().padLeft(3, '0');
                  String imageUrl = 'https://assets.pokemon.com/assets/cms2/img/pokedex/full/$pokeIdPadLeft.png';

                  pokeMoreInfoController.getPokemonMoreInfoData(pokemon);
                  pokeStatsDataController.getPokemonStats(pokemon);

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

  Future<void> fetchPokemons() async {
    await Provider.of<PokemonBasicDataController>(context, listen: false).getAllPokemons(offset);
    final pokemonStatsController = Provider.of<PokemonStatsController>(context, listen: false);
    final pokemonMoreInfoController = Provider.of<PokemonMoreInfoController>(context, listen: false);

    for (final pokemon in Provider.of<PokemonBasicDataController>(context, listen: false).pokemons) {
      await pokemonStatsController.getPokemonStats(pokemon);
      await pokemonMoreInfoController.getPokemonMoreInfoData(pokemon);
    }
  }

  void pokemonLazyLoading() async {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool isTop = _scrollController.position.pixels == 0;

        if (!isTop) {
          offset += 20;
          fetchPokemons();
        }
      }
    });
  }

}