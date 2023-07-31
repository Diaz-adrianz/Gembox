import 'package:flutter/material.dart';

import 'color.dart';

@immutable
class ThemeColor extends ThemeExtension<ThemeColor> {
  //
  const ThemeColor({
    required this.primary,
    required this.white,
    required this.black,
    required this.silver,
    required this.gray,
    required this.surface,
  });

  final Color? primary;
  final Color? white;
  final Color? black;
  final Color? silver;
  final Color? gray;
  final Color? surface;

  @override
  ThemeExtension<ThemeColor> copyWith({
    Color? primary,
    Color? white,
    Color? black,
    Color? silver,
    Color? gray,
    Color? surface,
  }) {
    return ThemeColor(
      primary: primary ?? this.primary,
      white: white ?? this.white,
      black: black ?? this.black,
      silver: silver ?? this.silver,
      gray: gray ?? this.gray,
      surface: surface ?? this.surface,
    );
  }

  @override
  ThemeExtension<ThemeColor> lerp(ThemeExtension<ThemeColor>? other, double t) {
    if (other is! ThemeColor) {
      return this;
    }
    return ThemeColor(
      primary: Color.lerp(primary, other.primary, t),
      white: Color.lerp(white, other.white, t),
      black: Color.lerp(black, other.black, t),
      silver: Color.lerp(silver, other.silver, t),
      gray: Color.lerp(gray, other.gray, t),
      surface: Color.lerp(surface, other.surface, t),
    );
  }

  static const ThemeColor light = ThemeColor(
      primary: MyColors.PRIMARY,
      white: MyColors.WHITE,
      black: MyColors.BLACK,
      silver: MyColors.SILVER,
      gray: MyColors.GRAY,
      surface: MyColors.SURFACE);

  static const ThemeColor dark = ThemeColor(
      primary: MyColors.PRIMARY,
      white: MyColors.WHITE,
      black: MyColors.BLACK,
      silver: MyColors.SILVER,
      gray: MyColors.GRAY,
      surface: MyColors.SURFACE);
}
