import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex_challenge_davidfernandes/src/controllers/pokedex_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PokedexController pokedexController = Get.find();
    return Scaffold(
      body: Obx(() {
        if (pokedexController.pokemons.isEmpty) {
          return Text("Error api");
        }
        return Text(
          pokedexController.pokemons.length.toString(),
        );
      }),
    );
  }
}
