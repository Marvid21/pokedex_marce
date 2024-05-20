import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokedex_marce/controllers/pokemon_basic_controller.dart';
import 'package:pokedex_marce/controllers/pokemon_favorite_controller.dart';
import 'package:pokedex_marce/models/pokemon_basic_data.dart';
import 'package:pokedex_marce/ui/widgets/pokemon_card_item.dart';
import 'package:provider/provider.dart';
import 'package:pokedex_marce/utils/constants.dart' as constants;

class CustomSliverListView extends StatelessWidget {
  final bool showFavorites;

  const CustomSliverListView({Key? key, this.showFavorites = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isFavorite = false;

    Future<void> checkFavorite(String name) async {
        isFavorite = await Provider.of<PokemonFavoriteController>(context).isPokemonFavorite(name);
      }

    return Consumer2<PokemonFavoriteController, PokemonBasicDataController>(
      builder: (_, favPokemonsProvider, allPokemonsProviders, ch) {
        List<PokemonBasicData> pokemons = allPokemonsProviders.pokemons;
        if (showFavorites) {
          pokemons = favPokemonsProvider.favoritePokemons;
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final pokemon = pokemons[index];
            String pokeIdPadLeft = '';
            String imageUrl = 'https://projectpokemon.org/images/sprites-models/bw-animated/$pokeIdPadLeft.gif';
            if (showFavorites) {
              imageUrl = pokemon.imageUrl;
              pokeIdPadLeft = pokemon.id;
            }
            return Padding(
              padding: const EdgeInsets.all(constants.mediumPadding),
              child: Row (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(
                    imageUrl,
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Text(
                      pokemon.name,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 16),
                  FutureBuilder(
                  future: checkFavorite(pokemon.name),
                  builder: (context, dataSnapShot) {
                    return IconButton(
                      padding: const EdgeInsets.only(
                        right: constants.mediumPadding
                      ),
                      onPressed: () async {
                        await Provider.of<PokemonFavoriteController>(
                          context,
                          listen: false
                        ).toogleFavoritePokemon(pokemon.name);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.grey,
                        size: 32,
                      )
                    );
                  }
                ),
                ],
              ),
            );
          }, childCount: pokemons.length),
        );
      }
    );
  }
}