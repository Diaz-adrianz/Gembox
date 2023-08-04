import 'package:flutter/material.dart';
import 'package:gemboxapp/themes/color.dart';

import '../themes/theme_color.dart';

Widget ButtonNaked(
    BuildContext ctx, void Function()? ontap, String text, Color fc,
    {bool disabled = false}) {
  final ThemeColor clr = Theme.of(ctx).extension<ThemeColor>()!;

  return GestureDetector(
    onTap: ontap,
    child: Container(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
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
