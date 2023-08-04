import 'package:flutter/material.dart';

import 'color.dart';

@immutable
class ThemeColor extends ThemeExtension<ThemeColor> {
  //
  const ThemeColor({
    required this.PRIMARY,
    required this.WHITE,
    required this.BLACK,
    required this.SILVER,
    required this.GRAY,
    required this.SURFACE,
  });

  final Color? PRIMARY;
  final Color? WHITE;
  final Color? BLACK;
  final Color? SILVER;
  final Color? GRAY;
  final Color? SURFACE;

  @override
  ThemeExtension<ThemeColor> copyWith({
    Color? PRIMARY,
    Color? WHITE,
    Color? BLACK,
    Color? SILVER,
    Color? GRAY,
    Color? SURFACE,
  }) {
    return ThemeColor(
      PRIMARY: PRIMARY ?? this.PRIMARY,
      WHITE: WHITE ?? this.WHITE,
      BLACK: BLACK ?? this.BLACK,
      SILVER: SILVER ?? this.SILVER,
      GRAY: GRAY ?? this.GRAY,
      SURFACE: SURFACE ?? this.SURFACE,
    );
  }

  @override
  ThemeExtension<ThemeColor> lerp(ThemeExtension<ThemeColor>? other, double t) {
    if (other is! ThemeColor) {
      return this;
    }
    return ThemeColor(
      PRIMARY: Color.lerp(PRIMARY, other.PRIMARY, t),
      WHITE: Color.lerp(WHITE, other.WHITE, t),
      BLACK: Color.lerp(BLACK, other.BLACK, t),
      SILVER: Color.lerp(SILVER, other.SILVER, t),
      GRAY: Color.lerp(GRAY, other.GRAY, t),
      SURFACE: Color.lerp(SURFACE, other.SURFACE, t),
    );
  }

  static const ThemeColor light = ThemeColor(
      PRIMARY: MyColors.PRIMARY,
      WHITE: MyColors.WHITE,
      BLACK: MyColors.BLACK,
      SILVER: MyColors.SILVER,
      GRAY: MyColors.GRAY,
      SURFACE: MyColors.SURFACE);

  static const ThemeColor dark = ThemeColor(
      PRIMARY: MyColors.PRIMARY,
      WHITE: MyColors.WHITE_DARK,
      BLACK: MyColors.BLACK_DARK,
      SILVER: MyColors.SILVER_DARK,
      GRAY: MyColors.GRAY_DARK,
      SURFACE: MyColors.SURFACE_DARK);
}
