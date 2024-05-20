import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon_basic_data.dart';

class PokemonBasicDataService {

  Future<List<PokemonBasicData>> getAllPokemons(int offset) async {
    List<PokemonBasicData> pokemons = [];
    try {
      if (offset >= 1000) {
        return pokemons;
      }

      //url para los primeros 20 pokemons de la poke api
      Uri basicUrl = Uri.https('pokeapi.co', '/api/v2/pokemon',
        {'limit': '20', 'offset': offset.toString()});

      final response = await http.get(basicUrl);
      List<dynamic> fetchData = [];

      //checkeamos si la respuesta esta OK
      if (response.statusCode == 200) {
        fetchData = json.decode(response.body)['results'];

        for (var poke in fetchData) {
          //Los nombres de los pokemons empiecen con mayusculas
          final pokeName = poke['name'].substring(0, 1).toUpperCase() +
            poke['name'].substring(1);

          pokemons.add(PokemonBasicData(name: pokeName, url: poke['url']));
        }
      }

      return pokemons;
    } catch (error) {
      rethrow;
    }
  }

  //obtenemos pokemon data por nombre
  Future<Map<String, dynamic>> getPokemonByName(String name) async {
    Map<String, dynamic> pokemon = {};
    final nameLowerCase = name.toLowerCase();
    try {
      Uri basicUrl = Uri.https('pokeapi.co', '/api/v2/pokemon/$nameLowerCase');

      final response = await http.get(basicUrl);
      if (response.statusCode == 200) {
        final pokeData = json.decode(response.body);

        //convertimos id a 3 digitos tales como: 001, 002, 003, etc
        String pokeIdPadLeft = '';
        int id = pokeData['id'];
        pokeIdPadLeft = (id).toString().padLeft(3, '0');
        String imageUrl = 'https://projectpokemon.org/images/sprites-models/bw-animated/$pokeIdPadLeft.gif';
        final pokeUrl = 'htpps://pokeapi.co/api/v2/$nameLowerCase';

        pokemon = {
          'name' : name,
          'id' : pokeIdPadLeft,
          'url' : pokeUrl,
          'imageUrl' : imageUrl,
        };
      }
      return pokemon;
    } catch (error) {
      rethrow;
    }
  }


}