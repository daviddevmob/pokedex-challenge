import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex_challenge_davidfernandes/src/controllers/pokedex_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PokedexController pokedexController = Get.find();

  getInitialData() async {
    Future.delayed(Duration(milliseconds: 1500)).then((value) async {
      await pokedexController.getNewPokemons();
      Get.offNamed('/home');
    });
  }

  @override
  void initState() {
    getInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/backgroud_splash.jpg'),
                  fit: BoxFit.cover,
                  opacity: .5),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Lottie.asset('assets/lottie/pokeball.json'),
            ),
          ),
        ],
      ),
    );
  }
}
