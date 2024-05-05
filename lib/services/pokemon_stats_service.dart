import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex_marce/models/pokemon_basic_data.dart';

class PokemonStatsService {
  Future<Map<String, dynamic>> fetchPokemonStats(PokemonBasicData pokemon) async {
    Map<String, dynamic> pokeStats = {};

    String pokeNameLowerCase = pokemon.name.toLowerCase();

    try {
      final Uri url = Uri.https('pokeapi.co', 'api/v2/pokemon/$pokeNameLowerCase');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        var pokeData = json.decode(response.body);
        List statsData = pokeData['stats'];
        int hp = 0;
        int attack = 0;
        int defense = 0;

        hp = statsData[0]['base_stat'];
        attack = statsData[1]['base_stat'];
        defense = statsData[2]['base_stat'];

        pokeStats = {
          'hp': hp,
          'attack': attack,
          'defense': defense,
        };
      }
      return pokeStats;
    } catch (error) {
      rethrow;
    }
  }
}