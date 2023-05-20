import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pokedex_challenge_davidfernandes/src/models/pokemon_model.dart';
import 'package:pokedex_challenge_davidfernandes/src/ui/theme/colors.dart';
import 'package:pokedex_challenge_davidfernandes/src/ui/theme/font_style.dart';

class PokeAboutBasicInfos extends StatelessWidget {
  final PokemonModel pokemonModel;
  const PokeAboutBasicInfos({super.key, required this.pokemonModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: pokemonModel.types!
                .map((e) => Container(
                      height: 20,
                      margin: EdgeInsets.only(
                        right: 10,
                      ),
                      child: Text(
                        e.capitalizeFirst!,
                        style: PokeTextStyle.subtitle3Bold.copyWith(
                          color: PokeColors.greyWhite,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: PokeColors.getColorByPokeType(
                          type: e,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ))
                .toList(),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            child: Text(
              "About",
              style: PokeTextStyle.subtitle1Bold.copyWith(
                color: PokeColors.getColorByPokeType(
                  type: pokemonModel.types!.first,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: (MediaQuery.of(context).size.width / 3) - 26,
                  child: PokeCardMeasureWidget(
                    svgPath: "assets/weight.svg",
                    value:
                        "${(pokemonModel.wight! / 10).toStringAsFixed(1).replaceAll(".", ",")} kg",
                    title: "Weight",
                  ),
                ),
                Container(
                  width: 2,
                  margin: EdgeInsets.symmetric(),
                  color: PokeColors.greyLight,
                ),
                Container(
                  width: (MediaQuery.of(context).size.width / 3) - 26,
                  child: PokeCardMeasureWidget(
                    svgPath: "assets/height.svg",
                    value:
                        "${(pokemonModel.height! / 10).toStringAsFixed(1).replaceAll(".", ",")} m",
                    title: "Height",
                  ),
                ),
                Container(
                  width: 2,
                  margin: EdgeInsets.symmetric(),
                  color: PokeColors.greyLight,
                ),
                Container(
                  width: (MediaQuery.of(context).size.width / 3) - 26,
                  child: PokeCardMeasureWidget(
                    title: "Moves",
                    moves: pokemonModel.moves,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "There is a plant seed on its back right from the day this Pokémon is born. The seed slowly grows larger.",
            style: PokeTextStyle.body3Regular.copyWith(
              color: PokeColors.greyDark,
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

class PokeCardMeasureWidget extends StatelessWidget {
  final String? svgPath;
  final String? value;
  final String title;
  final List<String>? moves;
  const PokeCardMeasureWidget({
    super.key,
    required this.title,
    this.value,
    this.svgPath,
    this.moves,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (svgPath != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                svgPath!,
                width: 10,
                height: 12,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "${value}",
                style: PokeTextStyle.body3Regular.copyWith(
                  color: PokeColors.greyDark,
                ),
              ),
            ],
          )
        else
          Container(
            height: 32,
            child: ListView.separated(
              itemCount: moves!.length,
              separatorBuilder: (context, index) => SizedBox(
                height: 2,
              ),
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => Text(
                moves![index],
                textAlign: TextAlign.center,
                style: PokeTextStyle.body3Regular.copyWith(
                  color: PokeColors.greyDark,
                ),
              ),
            ),
          ),
        SizedBox(
          height: svgPath == null ? 4 : 15,
        ),
        Text(
          title,
          style: PokeTextStyle.captionRegular.copyWith(
            color: PokeColors.greyMedium,
          ),
        ),
      ],
    );
  }
}
