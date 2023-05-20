import 'package:flutter/material.dart';
import 'package:pokedex_challenge_davidfernandes/src/models/pokemon_model.dart';
import 'package:pokedex_challenge_davidfernandes/src/ui/theme/colors.dart';
import 'package:pokedex_challenge_davidfernandes/src/ui/theme/font_style.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

class PokeCustomChartBarWidget extends StatelessWidget {
  final PokemonBaseStatsModel baseStatsModel;
  final Color color;
  const PokeCustomChartBarWidget({
    super.key,
    required this.baseStatsModel,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 96,
          child: PokeChardBarTitlesWidget(
            color: color,
            titles: ["HP", "ATK", "DEF", "SATK", "SDEF", "SPD"],
          ),
        ),
        Container(
          width: 1,
          height: 96,
          margin: EdgeInsets.symmetric(
            horizontal: 8,
          ),
          color: PokeColors.greyLight,
        ),
        Container(
          height: 96,
          child: PokeChardBarValuesWidget(
            values: [
              baseStatsModel.hp,
              baseStatsModel.atk,
              baseStatsModel.def,
              baseStatsModel.satk,
              baseStatsModel.sdef,
              baseStatsModel.spd,
            ],
            color: color,
          ),
        ),
      ],
    ) /* Column(
        children: [
          PokeChardBarWidget(
            title: "HP",
            value: baseStatsModel.hp,
            color: color,
          ),
        ],
      ), */
        );
  }
}

class PokeChardBarTitlesWidget extends StatelessWidget {
  final Color color;
  final List<String> titles;
  const PokeChardBarTitlesWidget(
      {super.key, required this.color, required this.titles});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: titles
          .map((e) => Text(
                e,
                style: PokeTextStyle.subtitle3Bold.copyWith(
                  color: color,
                ),
              ))
          .toList(),
    );
  }
}

class PokeChardBarValuesWidget extends StatelessWidget {
  final List<double> values;
  final Color color;
  const PokeChardBarValuesWidget({
    super.key,
    required this.values,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: values
          .map(
            (e) => Row(
              children: [
                Text(
                  (e < 100 ? "0" : "") + e.toStringAsFixed(0),
                  style: PokeTextStyle.body3Regular.copyWith(
                    color: PokeColors.greyDark,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                SimpleAnimationProgressBar(
                  height: 4,
                  width: 265,
                  backgroundColor: color.withOpacity(.2),
                  foregrondColor: color,
                  ratio: (e / 400) > 1 ? 1 : (e / 400),
                  direction: Axis.horizontal,
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: Duration(seconds: 6),
                  borderRadius: BorderRadius.circular(10),
                )
                /* Container(
                  height: 4,
                  width: 265,
                  decoration: BoxDecoration(
                    color: color.withOpacity(.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AnimatedContainer(
                      duration: Duration(seconds: 3),
                      child: Container(
                        width: e,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ), */
              ],
            ),
          )
          .toList(),
    );
  }
}
