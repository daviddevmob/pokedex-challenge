import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex_challenge_davidfernandes/src/controllers/pokedex_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PokedexController pokedexController = Get.find();

  getInitialData() async {
    await pokedexController.getNewPokemons();
    Get.toNamed('/home');
  }

  @override
  void initState() {
    getInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Load"),
      ),
    );
  }
}
