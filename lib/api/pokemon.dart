import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokemon_flutter/const/pokeapi.dart';
import 'package:pokemon_flutter/models/pokemon.dart';

Future<Pokemon> fetchPokemon(int id) async {
  final res = await http.get(Uri.parse('$pokeApiRoute/pokemon/$id'));
  if (res.statusCode == 200) {
    return Pokemon.fromJson(jsonDecode(res.body));
  } else {
    throw Exception('Failed to Load Pokemon');
  }
}
