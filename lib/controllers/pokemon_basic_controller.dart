import 'package:flutter/material.dart';
import '../services/pokemon_basic_service.dart';
import '../models/pokemon_basic_data.dart';

class PokemonBasicDataController with ChangeNotifier {
  List<PokemonBasicData> _pokemons = [];

  List<PokemonBasicData> get pokemons {
    return [..._pokemons];
  }

  final basicDataService = PokemonBasicDataService();

  Future<void> getAllPokemons(int offset) async {

    final fetchedPokemons = await basicDataService.getAllPokemons(offset);

    for (var poke in fetchedPokemons) {
      _pokemons.add(poke);
    }

    notifyListeners();
  }
}