import 'package:flutter/material.dart';
import 'package:flutter_pokedex/main.dart';

class AppRoutes {
  static const initialRoute = "home";

  static Map<String, Widget Function(BuildContext)> routes = {
    "home": (BuildContext context) => const HolisScreen(),
    "list": (BuildContext context) => PokemonsList(),
  };
}
