import 'package:flutter/material.dart';
import 'package:gemboxapp/themes/color.dart';
import 'package:gemboxapp/themes/theme_color.dart';

Widget Separator(ThemeColor clr) {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 16),
    color: clr.SILVER,
  );
}

Widget SeparatorNoMargin(ThemeColor clr) {
  return Container(
    height: 1,
    color: clr.SILVER,
  );
}

Widget Vertspacing(double val) {
  return SizedBox(
    height: val,
  );
}

Widget Horzspacing(double val) {
  return SizedBox(
    width: val,
  );
}
