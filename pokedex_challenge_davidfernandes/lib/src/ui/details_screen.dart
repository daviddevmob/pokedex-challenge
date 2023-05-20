import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pokedex_challenge_davidfernandes/src/controllers/pokedex_controller.dart';
import 'package:pokedex_challenge_davidfernandes/src/models/pokemon_model.dart';
import 'package:pokedex_challenge_davidfernandes/src/resources/extractor.dart';
import 'package:pokedex_challenge_davidfernandes/src/ui/theme/colors.dart';
import 'package:pokedex_challenge_davidfernandes/src/ui/theme/font_style.dart';
import 'dart:math' as math;

import 'package:pokedex_challenge_davidfernandes/src/ui/theme/widgets/poke_about_basic_infos_widget.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  final PokedexController controller = Get.find();
  late PokemonModel pokemonModel;
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 15))
        ..repeat();

  @override
  void initState() {
    pokemonModel = Get.arguments;
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          PokeColors.getColorByPokeType(type: pokemonModel.types!.first),
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
                            child: Icon(
                              CupertinoIcons.chevron_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          pokemonModel.name.capitalizeFirst!,
                          style: PokeTextStyle.headlineBold.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Text(
                          PokeExtractor.getPokemonNumber(pokemonModel.id),
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
                                      pokemonModel: pokemonModel,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Hero(
                                tag: pokemonModel.id,
                                child: CachedNetworkImage(
                                  imageUrl: pokemonModel.image!,
                                  width: 200,
                                  height: 200,
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
  }
}
