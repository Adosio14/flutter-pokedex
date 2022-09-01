import 'package:flutter/cupertino.dart';
import 'package:flutter_pokedex/models/pokemon_model.dart';
import 'package:flutter_pokedex/models/pokemons_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String _allPokemonsEndpoint =
    "https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0";

class HttpRequestsService extends ChangeNotifier {
  Future<dynamic> getApiData() async {
    try {
      final url = Uri.https("pokeapi.co", "api/v2/pokemon");
      print(url);
      final apiResponse = await http.get(url);
      final data = jsonDecode(apiResponse.body);
      return data['results'];
    } catch (err) {
      print("error negratso");
      return "database connection error";
    }
  }

  List pokemonList = [];

  Future<List> savePokemons() async {
    var apiData = await getApiData();
    if (apiData != "database connection error") {
      //mejorar validación ??????
      for (var item in apiData) {
        print(item);
        Result pokemon = Result.fromMap(item);
        pokemonList.add(pokemon);
      }
      print(pokemonList);
      return pokemonList;
    } else {
      return [];
    }
  }
}
