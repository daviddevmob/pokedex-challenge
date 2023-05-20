import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class PokeColors {
  PokeColors._();

  static Color identity = HexColor("#DC0A2D");
  static Color pkTypeBug = HexColor("#A7B723");
  static Color pkTypeDark = HexColor("#75574C");
  static Color pkTypeDragon = HexColor("#7037FF");
  static Color pkTypeElectric = HexColor("#F9CF30");
  static Color pkTypeFairy = HexColor("#E69EAC");
  static Color pkTypeFighting = HexColor("#C12239");
  static Color pkTypeFire = HexColor("#F57D31");
  static Color pkTypeFlying = HexColor("#A891EC");
  static Color pkTypeGhost = HexColor("#70559B");
  static Color pkTypeNormal = HexColor("#AAA67F");
  static Color pkTypeGrass = HexColor("#74CB48");
  static Color pkTypeGround = HexColor("#DEC16B");
  static Color pkTypeIce = HexColor("#9AD6DF");
  static Color pkTypePoison = HexColor("#A43E9E");
  static Color pkTypePsychic = HexColor("#FB5584");
  static Color pkTypeRock = HexColor("#B69E31");
  static Color pkTypeSteel = HexColor("#B7B9D0");
  static Color pkTypeWater = HexColor("#6493EB");
  static Color greyDark = HexColor("#1D1D1D");
  static Color greyMedium = HexColor("#666666");
  static Color greyLight = HexColor("#E0E0E0");
  static Color greyBackground = HexColor("#EFEFEF");
  static Color greyWhite = HexColor("#FFFFFF");

  static Color getColorByPokeType({required String type}) {
    late Color selectColor;
    switch (type) {
      case 'bug':
        selectColor = pkTypeBug;
        break;
      case 'dark':
        selectColor = pkTypeDark;
        break;
      case 'dragon':
        selectColor = pkTypeDragon;
        break;
      case 'eletric':
        selectColor = pkTypeElectric;
        break;
      case 'fairy':
        selectColor = pkTypeFairy;
        break;
      case 'fighting':
        selectColor = pkTypeFighting;
        break;
      case 'fire':
        selectColor = pkTypeFire;
        break;
      case 'flying':
        selectColor = pkTypeFlying;
        break;
      case 'ghost':
        selectColor = pkTypeGhost;
        break;
      case 'grass':
        selectColor = pkTypeGrass;
        break;
      case 'ice':
        selectColor = pkTypeIce;
        break;
      case 'normal':
        selectColor = pkTypeNormal;
        break;
      case 'poison':
        selectColor = pkTypePoison;
        break;
      case 'psychic':
        selectColor = pkTypePsychic;
        break;
      case 'rock':
        selectColor = pkTypeRock;
        break;
      case 'steel':
        selectColor = pkTypeSteel;
        break;
      case 'water':
        selectColor = pkTypeWater;
        break;
      default:
        selectColor = greyMedium;
    }
    return selectColor;
  }
}
