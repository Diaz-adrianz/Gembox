import 'package:flutter/material.dart';

class MyColors {
  static const Color PRIMARY = Color(0xFF0079FF);
  static const Color WHITE = Color(0xFFFEFEFE);
  static const Color BLACK = Color(0xFF212121);
  static const Color SILVER = Color(0xFFE0E0E0);
  static const Color GRAY = Color(0xFF77767E);
  static const Color SURFACE = Color(0xFFF1F0F6);

  static const Color PRIMARY_DARK = Color(0xFF0079FF);
  static const Color WHITE_DARK = Color(0xFF1C1C1E);
  static const Color BLACK_DARK = Color(0xFFF8F9FA);
  static const Color SILVER_DARK = Color(0xFF39393C);
  static const Color GRAY_DARK = Color(0xFF69696E);
  static const Color SURFACE_DARK = Color(0xFF000000);

  static bool isDarkMode(BuildContext ctx) =>
      Theme.of(ctx).brightness == Brightness.dark;
}
