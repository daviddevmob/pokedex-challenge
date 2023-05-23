import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'responsive.dart';

class PokeTextStyle {
  PokeTextStyle._();
  static TextStyle headlineBold = GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    fontSize: Responsive(Get.context!).isMobile() ? 24 : 32,
  );
  static TextStyle subtitle1Bold = GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    fontSize: Responsive(Get.context!).isMobile() ? 14 : 16,
  );
  static TextStyle subtitle2Bold = GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    fontSize: Responsive(Get.context!).isMobile() ? 12 : 16,
  );
  static TextStyle subtitle3Bold = GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    fontSize: Responsive(Get.context!).isMobile() ? 10 : 16,
  );

  static TextStyle body1Regular = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: Responsive(Get.context!).isMobile() ? 14 : 16,
  );
  static TextStyle body2Regular = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: Responsive(Get.context!).isMobile() ? 12 : 16,
  );
  static TextStyle body3Regular = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: Responsive(Get.context!).isMobile() ? 10 : 16,
  );
  static TextStyle captionRegular = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: Responsive(Get.context!).isMobile() ? 8 : 12,
  );
}
