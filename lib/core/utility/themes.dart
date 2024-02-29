import 'package:ali_fouad_test/core/utility/strings_data.dart';
import 'package:flutter/material.dart';
import 'package:ali_fouad_test/core/utility/colors_data.dart';

class Themes {
  static const normalFooterTextStyle = TextStyle(
    color: ColorsData.primaryColor,
    fontSize: 16,
    fontFamily: 'AlexandriaFLF',
    fontWeight: FontWeight.w400,
  );
  static const specialFooterUnderLineStyle = TextStyle(
    color: ColorsData.primaryColor,
    fontSize: 18,
    decoration: TextDecoration.underline,
    fontFamily: 'AlexandriaFLF',
    fontWeight: FontWeight.bold,
  );

  static const specialFooterBoldStyle = TextStyle(
    color: ColorsData.primaryColor,
    fontSize: 18,
    fontFamily: 'AlexandriaFLF',
    fontWeight: FontWeight.bold,
  );

  static const appBarTheme = AppBarTheme(
    foregroundColor: Colors.white,
    backgroundColor: ColorsData.primaryColor,
    centerTitle: true,
    elevation: 0,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    titleTextStyle: TextStyle(
        fontFamily: StringsData.boldText,
        fontSize: 22,
        color: ColorsData.whiteColor),
  );
}
