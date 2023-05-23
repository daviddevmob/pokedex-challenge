import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pokedex_challenge_davidfernandes/src/controllers/pokedex_controller.dart';
import 'package:pokedex_challenge_davidfernandes/src/theme/font_style.dart';
import 'package:pokedex_challenge_davidfernandes/src/theme/responsive.dart';

import '../theme/colors.dart';
import '../theme/widgets/poke_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PokedexController pokedexController = Get.find();
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        pokedexController.getNewPokemons();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PokeColors.identity,
      appBar: AppBar(
        backgroundColor: PokeColors.identity,
        elevation: 0,
        title: Row(
          children: [
            SvgPicture.asset(
              "assets/pokeball.svg",
              color: Colors.white,
              width: 24,
              height: 24,
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              "Pokédex",
              style: PokeTextStyle.headlineBold.copyWith(
                color: PokeColors.greyWhite,
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          if (pokedexController.pokemons.isEmpty) {
            return Text("Error api");
          }
          return Container(
            margin: EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 4,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 24,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: GridView.builder(
              itemCount: pokedexController.pokemons.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 104 / 108,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                mainAxisExtent: MediaQuery.of(context).size.width / 3,
              ),
              shrinkWrap: true,
              controller: _scrollController,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                return PokeCardWidget(
                  pokemonModel: pokedexController.pokemons[index],
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
