import 'package:flutter/material.dart';
import 'package:pokedex_marce/controllers/pokemon_favorite_controller.dart';
import 'package:provider/provider.dart';
import 'package:pokedex_marce/utils/constants.dart' as constants;
import 'package:pokedex_marce/ui/widgets/custom_sliver_list_view.dart';

class FavoriteScreen extends StatefulWidget {
  static const routeName = 'FavoriteScreen';

  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  Future<void> getFavPokemons() async {
    await Provider.of<PokemonFavoriteController>(context, listen: false).getFavoritePokemonsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getFavPokemons(),
        builder: (_, dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: constants.circularProgressIndicatorColor,
              )
            );
          } else {
            return const CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text('Mis Favoritos'),
                ),
                SliverPadding(
                  padding: EdgeInsets.all(constants.mediumPadding),
                  sliver: CustomSliverListView(showFavorites: true),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}