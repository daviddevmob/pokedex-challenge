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

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  final PokedexController controller = Get.find();
  PokemonModel? pokemonModel;
  int loadStatus = 0;
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 15))
        ..repeat();

  fetchPokeModel() async {
    pokemonModel = await controller.getPokemonModel(id: Get.arguments["id"]);
    pokemonModel == null ? loadStatus = 1 : loadStatus = 2;
    setState(() {});
  }

  @override
  void initState() {
    fetchPokeModel();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: loadStatus == 0 || loadStatus == 1
          ? PokeColors.greyMedium
          : PokeColors.getColorByPokeType(type: pokemonModel!.types!.first),
      body: loadStatus == 0
          ? Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : loadStatus == 1
              ? Text("Error")
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Positioned(
                          left: MediaQuery.of(context).size.width * .42,
                          top: MediaQuery.of(context).size.height * .01,
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
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.chevron_back,
                                ),
                                Text(
                                  pokemonModel!.name,
                                  style: PokeTextStyle.headlineBold.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  PokeExtractor.getPokemonNumber(
                                      pokemonModel!.id),
                                  style: PokeTextStyle.subtitle2Bold.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Flexible(
                              child: Container(
                                width: 300,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Flexible(
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.only(
                                            top: 144,
                                          ),
                                          padding: EdgeInsets.only(
                                            top: 58,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: pokemonModel!.types!
                                                    .map((e) => Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                            right: 10,
                                                          ),
                                                          child: Text(
                                                            e.capitalizeFirst!,
                                                            style: PokeTextStyle
                                                                .subtitle3Bold
                                                                .copyWith(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: PokeColors
                                                                .getColorByPokeType(
                                                              type: e,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                        ))
                                                    .toList(),
                                              ),
                                              SizedBox(
                                                height: 16,
                                              ),
                                              Container(
                                                child: Text(
                                                  "About",
                                                  style: PokeTextStyle
                                                      .subtitle1Bold
                                                      .copyWith(
                                                    color: PokeColors
                                                        .getColorByPokeType(
                                                      type: pokemonModel!
                                                          .types!.first,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 16,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: CachedNetworkImage(
                                        imageUrl: pokemonModel!.image!,
                                        width: 200,
                                        height: 200,
                                      ),
                                    ),
                                  ],
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
