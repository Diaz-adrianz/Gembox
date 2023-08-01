import 'package:flutter/material.dart';
import 'package:gemboxapp/themes/color.dart';

Widget MyTextField(BuildContext ctx, TextEditingController ctrl, String hint,
    {bool obscuretext = false,
    int maxlines = 1,
    ValueChanged<String>? onchanged,
    ValueChanged<String>? onsubmit,
    TextInputAction action = TextInputAction.done,
    bool ontapoutside = true}) {
  return TextField(
    controller: ctrl,
    obscureText: obscuretext,
    minLines: 1,
    maxLines: maxlines,
    onTapOutside: (evt) {
      if (ontapoutside) FocusManager.instance.primaryFocus?.unfocus();
    },
    onSubmitted: (val) {
      onsubmit!(val);
    },
    onChanged: (val) {
      onchanged!(val);
    },
    textInputAction: action,
    style: Theme.of(ctx).textTheme.bodyMedium,
    decoration: InputDecoration(
        hintStyle:
            Theme.of(ctx).textTheme.bodyMedium!.copyWith(color: MyColors.GRAY),
        hintText: hint,
        contentPadding: const EdgeInsets.all(0),
        border: InputBorder.none),
  );
}
