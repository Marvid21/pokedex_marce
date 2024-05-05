import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pokedex_marce/controllers/pokemon_basic_controller.dart';
import 'package:pokedex_marce/controllers/pokemon_more_info_controller.dart';
import 'package:pokedex_marce/controllers/pokemon_stats_controller.dart';
import 'package:pokedex_marce/ui/screens/home_screen.dart';

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
      ],
      child: Consumer (
        builder: (context, provider, ch) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Pokedex',
            initialRoute: HomeScreen.routname,
            routes: {
              HomeScreen.routname:(context) => const HomeScreen(),
            },
          );
        },
      ),
    );
  }
}