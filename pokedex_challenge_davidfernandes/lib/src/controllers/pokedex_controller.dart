import 'package:get/get.dart';
import 'package:pokedex_challenge_davidfernandes/src/models/pokemon_model.dart';
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
          String id = e.url.substring(10, 0);
          return PokemonModel(
            name: e.name,
            id: 1,
          );
        },
      ),
    );
    syncPokemons();
  }

  syncPokemons() async {
    pokemons.refresh();
  }
}
