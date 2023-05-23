import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:get/get.dart';
import 'package:pokedex_challenge_davidfernandes/src/controllers/pokedex_controller.dart';
import 'package:pokedex_challenge_davidfernandes/src/models/pokemon_model.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../resources/extractor.dart';
import '../colors.dart';
import '../font_style.dart';

class PokeCardWidget extends StatefulWidget {
  final PokemonModel pokemonModel;
  const PokeCardWidget({super.key, required this.pokemonModel});

  @override
  State<PokeCardWidget> createState() => _PokeCardWidgetState();
}

class _PokeCardWidgetState extends State<PokeCardWidget> {
  bool enableShimmer = false;
  @override
  Widget build(BuildContext context) {
    final PokedexController controller = Get.find();
    return ScaleTap(
      scaleMinValue: 1.2,
      onPressed: () async {
        setState(() {
          enableShimmer = true;
        });
        PokemonModel? pokemon =
            await controller.getPokemonModel(id: widget.pokemonModel.id);
        setState(() {
          enableShimmer = false;
        });
        if (pokemon != null) {
          Get.toNamed(
            '/home/poke-details',
            arguments: pokemon,
          );
        }
      },
      child: FittedBox(
        fit: BoxFit.contain,
        child: Container(
          height: 108,
          width: 104,
          child: Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                Shimmer(
                  enabled: enableShimmer,
                  duration: Duration(seconds: 2),
                  color: PokeColors.greyMedium,
                  colorOpacity: .2,
                  child: Padding(
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
                          PokeExtractor.getPokemonNumber(
                              widget.pokemonModel.id),
                          textAlign: TextAlign.end,
                          style: PokeTextStyle.captionRegular.copyWith(
                            color: PokeColors.greyMedium,
                            fontSize: 8,
                          ),
                        ),
                        Hero(
                          tag: widget.pokemonModel.id,
                          child: CachedNetworkImage(
                            imageUrl: widget.pokemonModel.image!,
                            height: 64.5,
                            width: 64.5,
                          ),
                        ),
                        Text(
                          widget.pokemonModel.name.capitalizeFirst!,
                          textAlign: TextAlign.center,
                          style: PokeTextStyle.body3Regular.copyWith(
                            color: PokeColors.greyDark,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
