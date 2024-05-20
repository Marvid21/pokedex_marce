import 'package:flutter/cupertino.dart';
import 'package:pokedex_marce/services/pokemon_basic_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pokedex_marce/models/pokemon_basic_data.dart';

class PokemonFavoriteController with ChangeNotifier {

  PokemonBasicDataService pokeBasicDataService = PokemonBasicDataService();

  late SharedPreferences prefs;

  List<String> _favoritePokemonsNames = [];

  List<PokemonBasicData> _favoritePokemons = [];

  List<PokemonBasicData> get favoritePokemons {
    return [... _favoritePokemons];
  }

  void sortList(List<String> savedPokemons) {
    savedPokemons.sort((item1, item2) => item1.compareTo(item2));
  }

  Future<void> toogleFavoritePokemon(String pokeName) async {
    prefs = await SharedPreferences.getInstance();

    List<String>? savedPokemons = [];

    savedPokemons = prefs.getStringList('favoritePokemons');

    savedPokemons ??= [];

    if (savedPokemons.contains(pokeName)) {
      savedPokemons.removeWhere((name) => pokeName == name);

      _favoritePokemons.removeWhere((pokemon) => pokemon.name == pokeName);
    } else {
      savedPokemons.add(pokeName);
    }
    prefs.setStringList('favoritePokemons', savedPokemons);
    _favoritePokemonsNames = savedPokemons;

    notifyListeners();
  }

  Future<void> loadFavoritePokemonsNamesFromSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    List<String>? savedPokemons = [];
    savedPokemons = prefs.getStringList('favoritePokemons');

    savedPokemons ??= [];

    sortList(savedPokemons);
    _favoritePokemonsNames = savedPokemons;

    notifyListeners();
  }

  Future<bool> isPokemonFavorite(String pokemonName) async {
    prefs = await SharedPreferences.getInstance();

    List<String>? savedPokemons = [];
    savedPokemons = prefs.getStringList('favoritePokemons');

    savedPokemons ??= [];
    if (savedPokemons.contains(pokemonName)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> getFavoritePokemonsData() async {
    List<PokemonBasicData> favPokemons = [];

    await loadFavoritePokemonsNamesFromSharedPref();

    for (String name in _favoritePokemonsNames) {
      final pokemonData = await pokeBasicDataService.getPokemonByName(name);
      final PokemonBasicData pokeBasicData = PokemonBasicData(
        name: pokemonData['name'],
        url: pokemonData['url'],
        id: pokemonData['id'],
        imageUrl: pokemonData['imageUrl']
      );
      favPokemons.add(pokeBasicData);
    }
    _favoritePokemons = favPokemons;
    
    notifyListeners();
  }
}