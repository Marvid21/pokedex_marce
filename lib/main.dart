import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pokedex_marce/controllers/pokemon_basic_controller.dart';
import 'package:pokedex_marce/controllers/pokemon_more_info_controller.dart';
import 'package:pokedex_marce/controllers/pokemon_stats_controller.dart';
import 'package:pokedex_marce/controllers/pokemon_favorite_controller.dart';
import 'package:pokedex_marce/ui/screens/home_screen.dart';
import 'package:pokedex_marce/ui/screens/favorite_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PokemonBasicDataController()),
        ChangeNotifierProvider(create: (_)=> PokemonMoreInfoController()),
        ChangeNotifierProvider(create: (_) => PokemonStatsController()),
        ChangeNotifierProvider(create: (_) => PokemonFavoriteController()),
      ],
      child: Consumer (
        builder: (context, provider, ch) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Pokedex',
            home: const HomeScreen(),
            routes: {
              FavoriteScreen.routeName: (context) => const FavoriteScreen(),
            },
          );
        },
      ),
    );
  }
}

  
class NavigationsDrawer extends StatelessWidget {
  const NavigationsDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Drawer(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeader(context),
          buildMenuItems(context),
        ],
      ),
    ),
  );
  Widget buildHeader(BuildContext context) => Container();
  Widget buildMenuItems(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 40.0),
    child: Column(
      children: [
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Pokedex'),
          onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          )),
        ),
        ListTile(
          leading: const Icon(Icons.catching_pokemon_outlined),
          title: const Text('Mis Favoritos'),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const FavoriteScreen(),
            ));
          },
        ),
      ],
    ),
  );
}