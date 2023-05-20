import 'package:flutter/material.dart';
import 'package:pokedex_challenge_davidfernandes/src/models/pokemon_model.dart';
import 'package:pokedex_challenge_davidfernandes/src/ui/theme/colors.dart';
import 'package:pokedex_challenge_davidfernandes/src/ui/theme/font_style.dart';
import 'package:pokedex_challenge_davidfernandes/src/ui/theme/widgets/poke_chart_widget.dart';

class PokeAboutBaseStatsWidget extends StatelessWidget {
  final PokemonModel pokemonModel;
  const PokeAboutBaseStatsWidget({
    super.key,
    required this.pokemonModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Text(
              "Base Stats",
              style: PokeTextStyle.subtitle1Bold.copyWith(
                color: PokeColors.getColorByPokeType(
                  type: pokemonModel.types!.first,
                ),
              ),
            ),
          ),
          PokeCustomChartBarWidget(
            baseStatsModel: pokemonModel.baseStats!,
            color:
                PokeColors.getColorByPokeType(type: pokemonModel.types!.first),
          ),
        ],
      ),
    );
  }
}

