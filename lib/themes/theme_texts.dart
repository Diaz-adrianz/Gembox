import 'package:flutter/material.dart';

import 'color.dart';

class ThemeText {
  static const TextTheme light = TextTheme(
      headlineLarge: TextStyle(
          fontFamily: 'Rubik',
          color: MyColors.BLACK,
          fontSize: 34,
          fontWeight: FontWeight.w700),
      headlineMedium: TextStyle(
          fontFamily: 'Rubik',
          color: MyColors.BLACK,
          fontSize: 28,
          fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(
          fontFamily: 'Rubik',
          color: MyColors.BLACK,
          fontSize: 22,
          fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(
          fontFamily: 'Rubik',
          color: MyColors.BLACK,
          fontSize: 17,
          height: 1.5,
          fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(
          fontFamily: 'Rubik',
          color: MyColors.BLACK,
          fontSize: 17,
          height: 1.5,
          fontWeight: FontWeight.w400),
      bodySmall: TextStyle(
          fontFamily: 'Rubik',
          color: MyColors.GRAY,
          fontSize: 13,
          fontWeight: FontWeight.w400));

  static const TextTheme dark = TextTheme(
      headlineLarge: TextStyle(
          fontFamily: 'Rubik',
          color: MyColors.WHITE,
          fontSize: 34,
          fontWeight: FontWeight.w700),
      headlineMedium: TextStyle(
          fontFamily: 'Rubik',
          color: MyColors.WHITE,
          fontSize: 28,
          fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(
          fontFamily: 'Rubik',
          color: MyColors.WHITE,
          fontSize: 22,
          fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(
          fontFamily: 'Rubik',
          color: MyColors.WHITE,
          fontSize: 17,
          height: 1.5,
          fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(
          fontFamily: 'Rubik',
          color: MyColors.WHITE,
          fontSize: 17,
          height: 1.5,
          fontWeight: FontWeight.w400),
      bodySmall: TextStyle(
          fontFamily: 'Rubik',
          color: MyColors.GRAY,
          fontSize: 13,
          fontWeight: FontWeight.w400));
}
