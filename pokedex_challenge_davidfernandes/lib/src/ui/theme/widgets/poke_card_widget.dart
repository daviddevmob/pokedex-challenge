import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex_challenge_davidfernandes/src/models/pokemon_model.dart';
import 'package:pokedex_challenge_davidfernandes/src/resources/extractor.dart';
import 'package:pokedex_challenge_davidfernandes/src/ui/theme/colors.dart';
import 'package:pokedex_challenge_davidfernandes/src/ui/theme/font_style.dart';

class PokeCardWidget extends StatelessWidget {
  final PokemonModel pokemonModel;
  const PokeCardWidget({super.key, required this.pokemonModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          '/home/poke-details',
          arguments: {
            'id': pokemonModel.id,
          },
        );
      },
      child: Container(
        height: 108,
        width: 104,
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 44,
                  decoration: BoxDecoration(
                      color: PokeColors.greyBackground,
                      borderRadius: BorderRadius.circular(7)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      PokeExtractor.getPokemonNumber(pokemonModel.id),
                      textAlign: TextAlign.end,
                      style: PokeTextStyle.captionRegular.copyWith(
                        color: PokeColors.greyMedium,
                      ),
                    ),
                    CachedNetworkImage(
                      imageUrl: pokemonModel.image!,
                      height: 70,
                      width: 70,
                    ),
                    Text(
                      pokemonModel.name.capitalizeFirst!,
                      textAlign: TextAlign.center,
                      style: PokeTextStyle.body3Regular.copyWith(
                        color: PokeColors.greyDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
