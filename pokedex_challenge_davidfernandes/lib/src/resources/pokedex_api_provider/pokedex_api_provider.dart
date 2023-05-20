import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pokedex_challenge_davidfernandes/src/models/pokemon_model.dart';
import 'package:pokedex_challenge_davidfernandes/src/resources/pokedex_api_provider/pokedex_api_interface.dart';

class PokedexApiProvider implements PokedexApiInterface {
  final Dio dio = Dio();
  final box = GetStorage();
  final String baseUrl = "https://pokeapi.co/api/v2/";

  @override
  Future<List<PokemonSimpleResult>> getPokemons({required int offSet}) async {
    try {
      String path = baseUrl + "pokemon/?offset=$offSet&limit=20";
      var localJson = await box.read(path);
      late Map result;
      if (localJson != null) {
        result = localJson;
      } else {
        Response response = await dio.get(
          path,
        );
        if (response.statusCode == 200) {
          result = response.data;
          await box.write(path, result);
        }
      }
      List<PokemonSimpleResult> pokemon = (result["results"] as List)
          .map((e) => PokemonSimpleResult.fromJson(e))
          .toList();
      return pokemon;
    } catch (e) {
      print(e);
      return <PokemonSimpleResult>[];
    }
  }

  @override
  Future<PokemonModel?> getPokemonDetails({required int id}) async {
    try {
      Response response = await dio.get(baseUrl + "pokemon/$id/");
      return PokemonModel.fromJson(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
