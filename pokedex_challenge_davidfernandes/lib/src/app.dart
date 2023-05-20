import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex_challenge_davidfernandes/src/blinds/pokedex_blind.dart';

import 'ui/details_screen.dart';
import 'ui/home_screen.dart';
import 'ui/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PokeDex Challenge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: PokedexBinding(),
      getPages: [
        GetPage(
          name: '/',
          page: () => SplashScreen(),
          binding: PokedexBinding(),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: '/home',
          page: () => HomeScreen(),
          binding: PokedexBinding(),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: '/home/poke-details',
          page: () => DetailsScreen(),
          binding: PokedexBinding(),
          transitionDuration: Duration(milliseconds: 700),
          transition: Transition.noTransition,
        ),
      ],
      home: SplashScreen(),
    );
  }
}
