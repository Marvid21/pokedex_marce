import 'package:flutter/material.dart';
import 'package:pokedex_marce/models/pokemon_more_info_data.dart';
import 'package:pokedex_marce/models/pokemon_stats_data.dart';

class PokemonBasicData {
  final String name;
  final String url;
  String id;
  String imageUrl;
  Color? cardColor;
  PokemonMoreInfoData? pokemonMoreInfoData;
  PokemonStatsData? pokemonStatsData;

  PokemonBasicData({
    required this.name,
    required this.url,
    this.id = '000',
    this.imageUrl = '',
    this.cardColor = Colors.grey,
    this.pokemonMoreInfoData,
    this.pokemonStatsData,
  });
}