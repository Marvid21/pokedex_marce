import 'package:flutter/material.dart';
import 'package:pokedex_marce/models/pokemon_basic_data.dart';
import 'package:pokedex_marce/models/pokemon_more_info_data.dart';
import 'package:pokedex_marce/services/pokemon_more_info_service.dart';

class PokemonMoreInfoController with ChangeNotifier {

  final pokeMoreDataService = PokemonMoreInfoService();

  Future<void> getPokemonMoreInfoData(PokemonBasicData pokemon) async {
    final response = await pokeMoreDataService.fetchPokemonMoreInfoData(pokemon);

    PokemonMoreInfoData pokeDetailedInfo = PokemonMoreInfoData(
      types: response['types'],
    );

    //agregamos el detalle del model a info basica pokemon
    pokemon.pokemonMoreInfoData = pokeDetailedInfo;
  }
}