import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pokedex_challenge_davidfernandes/src/controllers/pokedex_controller.dart';
import 'package:pokedex_challenge_davidfernandes/src/controllers/pokemon_details_controller.dart';
import 'package:pokedex_challenge_davidfernandes/src/models/pokemon_model.dart';
import 'package:pokedex_challenge_davidfernandes/src/resources/extractor.dart';
import 'package:pokedex_challenge_davidfernandes/src/theme/font_style.dart';
import 'package:pokedex_challenge_davidfernandes/src/theme/responsive.dart';
import 'dart:math' as math;

import '../theme/colors.dart';
import '../theme/widgets/poke_details/poke_about_base_stats_widget.dart';
import '../theme/widgets/poke_details/poke_about_basic_infos_widget.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  final PokemonDetailsController pokemonController = PokemonDetailsController();
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 15))
        ..repeat();

  @override
  void initState() {
    pokemonController.startController(
        pokemonModel: (Get.arguments as PokemonModel));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    pokemonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: PokeColors.getColorByPokeType(
            type: pokemonController.defaultPokemon.types!.first),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Positioned(
                  right: 9,
                  top: 8,
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (_, child) {
                      return Transform.rotate(
                        angle: _controller.value * 2 * math.pi,
                        child: child,
                      );
                    },
                    child: Opacity(
                      opacity: .3,
                      child: SvgPicture.asset(
                        "assets/pokeball.svg",
                        width: 205,
                        height: 208,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: 24,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              color: Colors.transparent,
                              padding: EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 2,
                              ),
                              child: SvgPicture.asset(
                                "assets/arrow_back.svg",
                                color: Colors.white,
                                width: 25,
                              ),
                            ),
                          ),
                          Text(
                            pokemonController
                                .defaultPokemon.name.capitalizeFirst!,
                            style: PokeTextStyle.headlineBold.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          Spacer(),
                          Text(
                            PokeExtractor.getPokemonNumber(
                                pokemonController.defaultPokemon.id),
                            style: PokeTextStyle.subtitle2Bold.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Flexible(
                      child: FadeInDown(
                        child: Container(
                          width: 300,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(
                                    top: 144,
                                  ),
                                  padding: EdgeInsets.only(
                                    top: 58,
                                    left: 20,
                                    right: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      PokeAboutBasicInfos(
                                        pokemonModel:
                                            pokemonController.defaultPokemon,
                                      ),
                                      PokeAboutBaseStatsWidget(
                                        pokemonModel:
                                            pokemonController.defaultPokemon,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 32,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Obx(() {
                                        if (pokemonController
                                                    .indexCurrentEvolution
                                                    .value >
                                                0 &&
                                            pokemonController
                                                .fetchedEvolutions.value) {
                                          return FadeInLeft(
                                            child: ScaleTap(
                                              onPressed: () {
                                                pokemonController
                                                    .indexCurrentEvolution
                                                    .value = pokemonController
                                                        .indexCurrentEvolution
                                                        .value -
                                                    1;
                                              },
                                              child: Container(
                                                color: Colors.transparent,
                                                padding: EdgeInsets.all(10),
                                                child: SvgPicture.asset(
                                                  "assets/back.svg",
                                                  color: Colors.white,
                                                  width: Responsive(context)
                                                          .isMobile()
                                                      ? 10
                                                      : 20,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        return Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: SizedBox(
                                            height:
                                                Responsive(context).isMobile()
                                                    ? 10
                                                    : 20,
                                            width:
                                                Responsive(context).isMobile()
                                                    ? 10
                                                    : 20,
                                          ),
                                        );
                                      }),
                                      Hero(
                                        tag:
                                            pokemonController.defaultPokemon.id,
                                        child: CachedNetworkImage(
                                          imageUrl: pokemonController
                                              .defaultPokemon.image!,
                                          width: 200,
                                          height: 200,
                                        ),
                                      ),
                                      Obx(() {
                                        if (pokemonController
                                                    .indexCurrentEvolution
                                                    .value <
                                                (pokemonController.pokemon.value
                                                        .others!.length -
                                                    1) &&
                                            pokemonController
                                                .fetchedEvolutions.value) {
                                          return FadeInRight(
                                            child: ScaleTap(
                                              onPressed: () {
                                                pokemonController
                                                    .indexCurrentEvolution
                                                    .value = pokemonController
                                                        .indexCurrentEvolution
                                                        .value +
                                                    1;
                                              },
                                              child: Container(
                                                color: Colors.transparent,
                                                padding: EdgeInsets.all(10),
                                                child: SvgPicture.asset(
                                                  "assets/next.svg",
                                                  color: Colors.white,
                                                  width: Responsive(context)
                                                          .isMobile()
                                                      ? 10
                                                      : 20,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        return Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: SizedBox(
                                            height:
                                                Responsive(context).isMobile()
                                                    ? 10
                                                    : 20,
                                            width:
                                                Responsive(context).isMobile()
                                                    ? 10
                                                    : 20,
                                          ),
                                        );
                                      })
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
