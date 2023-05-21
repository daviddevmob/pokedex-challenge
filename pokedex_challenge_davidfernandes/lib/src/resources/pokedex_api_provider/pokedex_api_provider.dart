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
      var pokemon = PokemonModel.fromJson(response.data);
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
      String urlEvolutions =
          (await dio.get(baseUrl + "pokemon-species/${pokemon.name}"))
              .data["evolution_chain"]["url"];
      Response evolutions = await dio.get(urlEvolutions);
      String? stage1Name;
      String? stage2Name;
      String? stage3Name;
      try {
        stage1Name = evolutions.data["chain"]["species"]["name"];
      } catch (e) {}
      try {
        stage2Name =
            evolutions.data["chain"]["evolves_to"][0]["species"]["name"];
      } catch (e) {}
      try {
        stage3Name = evolutions.data["chain"]["evolves_to"][0]["evolves_to"][0]
            ["species"]["name"];
      } catch (e) {}
      if (stage1Name != pokemon.name && stage1Name != null) {
        Response response = await dio.get(baseUrl + "pokemon/$stage1Name");
        var pokeStage1 = PokemonModel.fromJson(response.data);
        pokemons.add(pokeStage1);
      } else {
        if (stage1Name != null) {
          pokemons.add(pokemon);
        }
      }
      if (stage2Name != pokemon.name && stage2Name != null) {
        Response response = await dio.get(baseUrl + "pokemon/$stage2Name");
        var pokeStage2 = PokemonModel.fromJson(response.data);
        pokemons.add(pokeStage2);
      } else {
        if (stage2Name != null) {
          pokemons.add(pokemon);
        }
      }
      if (stage3Name != pokemon.name && stage3Name != null) {
        Response response = await dio.get(baseUrl + "pokemon/$stage3Name");
        var pokeStage3 = PokemonModel.fromJson(response.data);
        pokemons.add(pokeStage3);
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
}
