import 'package:get/get.dart';
import 'package:pokedex_challenge_davidfernandes/src/models/pokemon_model.dart';
import 'package:pokedex_challenge_davidfernandes/src/resources/repository.dart';

class PokemonDetailsController extends GetxController {
  final Repository repository = Get.find();
  late Rx<PokemonModel> pokemon;

  RxBool fetchedEvolutions = false.obs;
  RxInt indexCurrentEvolution = 0.obs;

  startController({required PokemonModel pokemonModel}) async {
    pokemon = pokemonModel.obs;
    pokemon.refresh();
    getEvolutions();
  }

  getEvolutions() async {
    try {
      List<PokemonModel> pokemons =
          await repository.fetchEvolutions(pokemon: pokemon.value);
      pokemon.value.others = pokemons;
      indexCurrentEvolution.value = pokemon.value.others!
          .indexWhere((element) => element.name == pokemon.value.name);
      fetchedEvolutions.value = true;
      pokemon.refresh();
    } catch (e) {}
  }

  PokemonModel get defaultPokemon {
    if (fetchedEvolutions.value) {
      return pokemon.value.others![indexCurrentEvolution.value];
    }
    return pokemon.value;
  }
}
