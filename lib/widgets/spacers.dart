import 'package:flutter/material.dart';
import 'package:gemboxapp/themes/color.dart';

Widget Separator() {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 16),
    color: MyColors.SILVER,
  );
}

Widget SeparatorNoMargin() {
  return Container(
    height: 1,
    color: MyColors.SILVER,
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
