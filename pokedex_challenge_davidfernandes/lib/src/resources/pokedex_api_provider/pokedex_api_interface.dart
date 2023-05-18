import 'package:pokedex_challenge_davidfernandes/src/models/pokemon_model.dart';

abstract class PokedexApiInterface {
  Future<List<PokemonSimpleResult>> getPokemons({required int offSet});
  Future getPokemonDetails({required String pokemonUrl});
}
