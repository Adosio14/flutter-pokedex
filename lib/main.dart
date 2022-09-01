import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_pokedex/extensions/string_casing.dart';
import 'package:flutter_pokedex/models/pokemons_model.dart';
import 'package:flutter_pokedex/providers/api_requests_handler.dart';
import 'package:flutter_pokedex/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HttpRequestsService(),
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Pokedex',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: PokemonsList(),
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.initialRoute,
    );
  }
}

class HolisScreen extends StatefulWidget {
  const HolisScreen({Key? key}) : super(key: key);

  @override
  State<HolisScreen> createState() => _HolisScreenState();
}

class _HolisScreenState extends State<HolisScreen> {
  @override
  void initState() {
    super.initState();
    final requestsProvider =
        Provider.of<HttpRequestsService>(context, listen: false);
    if (mounted) requestsProvider.savePokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          InkWell(
            onTap: () => {Navigator.popAndPushNamed(context, "list")},
            child: Container(
              child: Text("loading"),
            ),
          ),
        ],
      ),
    );
  }
}

class PokemonsList extends StatefulWidget {
  PokemonsList({
    Key? key,
  }) : super(key: key);

  @override
  State<PokemonsList> createState() => _PokemonsListState();
}

class _PokemonsListState extends State<PokemonsList> {
  List<Result> pokemonList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final requestsProvider =
        Provider.of<HttpRequestsService>(context, listen: false);
    pokemonList = requestsProvider.pokemonList.cast<Result>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex but is a flutter app"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Expanded(
              child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: pokemonList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://wallpaperaccess.com/full/3551101.png"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(100),
                              topRight: Radius.circular(100)),
                        ),
                        child: PokemonListTile(
                            pokemonName: pokemonList[index].name.capitalize()),
                      ),
                    ],
                  );
                },
              )
            ],
          )),
        ),
      )),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 200);
    path.lineTo(200, 200);
    path.lineTo(260, 0);
    path.lineTo(30, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class PokemonListTile extends StatelessWidget {
  final String pokemonName;

  PokemonListTile({
    Key? key,
    required this.pokemonName,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(left: 48),
        child: ClipPath(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.blueGrey.withOpacity(0.75),
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                pokemonName,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          clipper: CustomClipPath(),
        ),
      ),
      onTap: () {},
      hoverColor: Colors.indigo,
    );
  }
}
