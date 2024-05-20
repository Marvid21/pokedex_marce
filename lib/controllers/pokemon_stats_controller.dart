import 'package:flutter/material.dart';
import 'package:pokedex_marce/models/pokemon_basic_data.dart';
import 'package:pokedex_marce/models/pokemon_stats_data.dart';
import 'package:pokedex_marce/services/pokemon_stats_service.dart';

class PokemonStatsController with ChangeNotifier {
  final pokeStatsService = PokemonStatsService();

  Future<void> getPokemonStats(PokemonBasicData pokemon) async {
    final response = await pokeStatsService.fetchPokemonStats(pokemon);

    //agregamos los model detalle pokemon a model info basica pokemon
    final PokemonStatsData pokeStatsData = PokemonStatsData(
      hp: response['hp'],
      attack: response['attack'],
      defense: response['defense'],
    );

    pokemon.pokemonStatsData = pokeStatsData;
  }
}