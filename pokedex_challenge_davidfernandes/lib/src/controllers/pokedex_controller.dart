import 'package:get/get.dart';
import 'package:pokedex_challenge_davidfernandes/src/models/pokemon_model.dart';
import 'package:pokedex_challenge_davidfernandes/src/resources/extractor.dart';
import 'package:pokedex_challenge_davidfernandes/src/resources/repository.dart';

class PokedexController extends GetxController {
  final Repository repository = Get.find();
  RxList<PokemonModel> pokemons = <PokemonModel>[].obs;

  getNewPokemons() async {
    List<PokemonSimpleResult> newPokemons =
        await repository.fetchPokemons(offSet: pokemons.length);
    pokemons.addAll(
      newPokemons.map(
        (e) {
          return PokemonModel(
            name: e.name,
            id: int.parse(PokeExtractor.getId(e.url)),
            image: PokeExtractor.getImageUrl(e.url),
          );
        },
      ),
    );
    pokemons.refresh();
  }

  getPokemonModel({required int id}) async {
    PokemonModel? result = await repository.fetchPokemonModel(id: id);
    return result;
  }

}
