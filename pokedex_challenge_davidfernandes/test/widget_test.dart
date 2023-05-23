// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex_challenge_davidfernandes/src/controllers/pokedex_controller.dart';
import 'package:pokedex_challenge_davidfernandes/src/models/pokemon_model.dart';
import 'package:pokedex_challenge_davidfernandes/src/resources/pokedex_api_provider/pokedex_api_interface.dart';
import 'package:pokedex_challenge_davidfernandes/src/resources/repository.dart';
import 'package:pokedex_challenge_davidfernandes/src/theme/widgets/poke_card_widget.dart';
import 'package:pokedex_challenge_davidfernandes/src/theme/widgets/poke_details/poke_about_base_stats_widget.dart';
import 'package:pokedex_challenge_davidfernandes/src/theme/widgets/poke_details/poke_about_basic_infos_widget.dart';
import 'package:pokedex_challenge_davidfernandes/src/ui/details_screen.dart';
import 'package:pokedex_challenge_davidfernandes/src/ui/home_screen.dart';
import 'package:pokedex_challenge_davidfernandes/src/ui/splash_screen.dart';

class PokedexControllerTest extends Mock implements PokedexController {}

class RepositoryTest extends Mock implements Repository {}

@GenerateMocks([PokedexControllerTest])
@GenerateMocks([RepositoryTest])
void main() {
  late RepositoryTest repositoryTest;
  late PokedexControllerTest pokedexControllerTest;

  setUp(() async {
    pokedexControllerTest = PokedexControllerTest();
    repositoryTest = RepositoryTest();
    Get.testMode = true;
    /*   when(repositoryTest.fetchPokemons(offSet: 0))
        .thenAnswer((realInvocation) async => <PokemonSimpleResult>[]); */
    when(pokedexControllerTest.getNewPokemons())
        .thenAnswer((realInvocation) async => <PokemonSimpleResult>[]);
  });

  Widget createWidgetForTesting({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets("SplashScreen test", (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: SplashScreen()));
    expect(find.byType(AssetImage), findsOneWidget);
    expect(find.byType(Lottie), findsOneWidget);
    Get.delete<PokedexController>();
    Get.delete<Repository>();
  });

  testWidgets("HomeScreen test", (WidgetTester tester) async {
    await tester.pumpWidget(HomeScreen());
    expect(find.byType(SvgPicture), findsOneWidget);
    expect(find.text("Pokédex"), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
    final pokemon = find.byType(PokeCardWidget);
    expect(pokemon, findsWidgets);
    await tester.tap(pokemon);
    await tester.pumpAndSettle();
    expect(find.byType(DetailsScreen), findsOneWidget);
    expect(find.byType(SvgPicture), findsWidgets);
    expect(find.byType(PokeAboutBasicInfos), findsOneWidget);
    expect(find.byType(PokeAboutBaseStatsWidget), findsOneWidget);
  });
}
