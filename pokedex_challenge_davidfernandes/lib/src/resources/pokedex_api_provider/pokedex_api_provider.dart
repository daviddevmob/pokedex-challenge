import 'package:dio/dio.dart';
import 'package:pokedex_challenge_davidfernandes/src/models/pokemon_model.dart';
import 'package:pokedex_challenge_davidfernandes/src/resources/pokedex_api_provider/pokedex_api_interface.dart';

class PokedexApiProvider implements PokedexApiInterface {
  final Dio dio = Dio();
  final String baseUrl = "https://pokeapi.co/api/v2/";

  @override
  Future<List<PokemonSimpleResult>> getPokemons({required int offSet}) async {
    try {
      Response response = await dio.get(
        baseUrl + "pokemon/?offset=$offSet&limit=20",
      );
      List<PokemonSimpleResult> pokemon = (response.data["results"] as List)
          .map((e) => PokemonSimpleResult.fromJson(e))
          .toList();
      return pokemon;
    } catch (e) {
      print(e);
      return <PokemonSimpleResult>[];
    }
  }

  @override
  Future getPokemonDetails({required String pokemonUrl}) async {
    try {
      Response response = await dio.get(pokemonUrl);
      return PokemonModel.fromJson(response.data);
    } catch (e) {
      print(e);
    }
  }
}
