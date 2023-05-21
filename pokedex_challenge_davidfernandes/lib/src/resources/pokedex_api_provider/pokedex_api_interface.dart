import 'package:pokedex_challenge_davidfernandes/src/models/pokemon_model.dart';

abstract class PokedexApiInterface {
  Future<List<PokemonSimpleResult>> getPokemons({required int offSet});
  Future<PokemonModel?> getPokemonDetails({required int id});
  Future<List<PokemonModel>> getEvolutions({required PokemonModel pokemon});
}
