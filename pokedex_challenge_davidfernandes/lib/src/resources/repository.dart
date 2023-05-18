import 'package:pokedex_challenge_davidfernandes/src/models/pokemon_model.dart';
import 'package:pokedex_challenge_davidfernandes/src/resources/pokedex_api_provider/pokedex_api_provider.dart';

class Repository {
  final PokedexApiProvider pokedexApiProvider = PokedexApiProvider();
  Future<List<PokemonSimpleResult>> fetchPokemons({required int offSet}) =>
      pokedexApiProvider.getPokemons(offSet: offSet);
}
