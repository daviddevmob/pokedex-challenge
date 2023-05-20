import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PokeTextStyle {
  PokeTextStyle._();

  static TextStyle headlineBold = GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );
  static TextStyle subtitle1Bold = GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  static TextStyle subtitle2Bold = GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );
  static TextStyle subtitle3Bold = GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    fontSize: 10,
  );

  static TextStyle body1Regular = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
  static TextStyle body2Regular = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );
  static TextStyle body3Regular = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 10,
  );
  static TextStyle captionRegular = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 8,
  );
}
