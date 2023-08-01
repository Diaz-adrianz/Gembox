import 'package:flutter/material.dart';
import 'package:gemboxapp/themes/color.dart';

Widget ButtonFilled(
    BuildContext ctx, void Function()? ontap, String text, Color bg, Color fc,
    {bool disabled = false}) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
            color: disabled ? MyColors.GRAY : bg,
            borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: Text(
            text,
            style: Theme.of(ctx)
                .textTheme
                .bodyLarge
                ?.copyWith(color: disabled ? MyColors.SILVER : fc),
          ),
        )),
  );
}
