import 'package:get/get.dart';
import 'package:pokedex_challenge_davidfernandes/src/controllers/pokedex_controller.dart';
import 'package:pokedex_challenge_davidfernandes/src/resources/repository.dart';

class PokedexBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<Repository>(Repository(), permanent: true);
    Get.put<PokedexController>(PokedexController(), permanent: true);
  }
}
