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
      Map<String, dynamic>? result = await getCache(
        path: baseUrl + "pokemon/?offset=$offSet&limit=20",
      );
      if (result == null) return <PokemonSimpleResult>[];
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
      Map<String, dynamic>? result =
          await getCache(path: baseUrl + "pokemon/$id/");
      if (result == null) return null;
      var pokemon = PokemonModel.fromJson(result);
      return pokemon;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<List<PokemonModel>> getEvolutions(
      {required PokemonModel pokemon}) async {
    try {
      List<PokemonModel> pokemons = [];
      String? urlEvolutions = (await getCache(
          path: baseUrl +
              "pokemon-species/${pokemon.name}"))?["evolution_chain"]["url"];
      if (urlEvolutions == null) return <PokemonModel>[];
      Map<String, dynamic>? evolutions = await getCache(path: urlEvolutions);
      if (evolutions == null) return <PokemonModel>[];
      String? stage1Name;
      String? stage2Name;
      String? stage3Name;
      try {
        stage1Name = evolutions["chain"]["species"]["name"];
      } catch (e) {}
      try {
        stage2Name = evolutions["chain"]["evolves_to"][0]["species"]["name"];
      } catch (e) {}
      try {
        stage3Name = evolutions["chain"]["evolves_to"][0]["evolves_to"][0]
            ["species"]["name"];
      } catch (e) {}
      if (stage1Name != pokemon.name && stage1Name != null) {
        Map<String, dynamic>? response =
            await getCache(path: baseUrl + "pokemon/$stage1Name");
        if (response != null) {
          var pokeStage1 = PokemonModel.fromJson(response);
          pokemons.add(pokeStage1);
        }
      } else {
        if (stage1Name != null) {
          pokemons.add(pokemon);
        }
      }
      if (stage2Name != pokemon.name && stage2Name != null) {
        Map<String, dynamic>? response =
            await getCache(path: baseUrl + "pokemon/$stage2Name");
        if (response != null) {
          var pokeStage2 = PokemonModel.fromJson(response);
          pokemons.add(pokeStage2);
        }
      } else {
        if (stage2Name != null) {
          pokemons.add(pokemon);
        }
      }
      if (stage3Name != pokemon.name && stage3Name != null) {
        Map<String, dynamic>? response =
            await getCache(path: baseUrl + "pokemon/$stage3Name");
        if (response != null) {
          var pokeStage3 = PokemonModel.fromJson(response);
          pokemons.add(pokeStage3);
        }
      } else {
        if (stage3Name != null) {
          pokemons.add(pokemon);
        }
      }
      return pokemons;
    } catch (e) {
      print(e);
      return <PokemonModel>[];
    }
  }

  @override
  Future<Map<String, dynamic>?> getCache({required String path}) async {
    try {
      var localJson = await box.read(path);
      late Map<String, dynamic> result;
      if (localJson != null) {
        result = localJson;
      } else {
        Response response = await dio.get(
          path,
        );
        if (response.statusCode == 200) {
          result = response.data;
          await box.write(path, result);
        } else {
          return null;
        }
      }
      return result;
    } catch (e) {
      return null;
    }
  }
}
