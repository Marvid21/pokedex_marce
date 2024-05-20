import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex_marce/models/pokemon_basic_data.dart';

class PokemonMoreInfoService {
  Future<Map<String, dynamic>> fetchPokemonMoreInfoData(
    PokemonBasicData pokemon) async {

    Map<String, dynamic> moreInfo = {};

    String pokeNameLowerCase = pokemon.name.toLowerCase();

    try {
      final Uri url = Uri.https('pokeapi.co', 'api/v2/pokemon/$pokeNameLowerCase');
      final response = await http.get(url);

      if(response.statusCode == 200) {
        var pokeData = json.decode(response.body);

        //obtenemos tipos de pokemons
        List<String> typesNames = [];
        List types = pokeData['types'];
        for (var typeName in types) {
          typesNames.add(typeName['type']['name']);
        }

        moreInfo = {
          'types': typesNames,
        };
      }
      return moreInfo;
    } catch (error) {
      rethrow;
    }
  }
}