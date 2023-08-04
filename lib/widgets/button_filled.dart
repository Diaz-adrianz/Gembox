import 'package:flutter/material.dart';
import 'package:gemboxapp/themes/color.dart';
import 'package:gemboxapp/themes/theme_color.dart';

Widget ButtonFilled(
    BuildContext ctx, void Function()? ontap, String text, Color bg, Color fc,
    {bool disabled = false}) {
  final ThemeColor clr = Theme.of(ctx).extension<ThemeColor>()!;

  return GestureDetector(
    onTap: ontap,
    child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
            color: disabled ? clr.GRAY : bg,
            borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: Text(
            text,
            style: Theme.of(ctx)
                .textTheme
                .bodyLarge
                ?.copyWith(color: disabled ? clr.SILVER : fc),
          ),
        )),
  );
}
