import 'package:flutter/material.dart';
import 'package:gemboxapp/themes/color.dart';
import 'package:gemboxapp/widgets/button_naked.dart';
import 'package:gemboxapp/widgets/spacers.dart';

import 'button_filled.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;

  const ConfirmDialog(this.title, this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                  color: MyColors.WHITE,
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    content,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Separator(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /////// NEGATIVE BUTTON ///////
                      Expanded(
                          child: ButtonNaked(
                        context,
                        () {
                          Navigator.of(context).pop(false);
                        },
                        'No',
                        Colors.red,
                      )),
                      Horzspacing(16),

                      /////// POSITIVE BUTTON ///////
                      Expanded(
                          child: ButtonNaked(
                        context,
                        () {
                          Navigator.of(context).pop(true);
                        },
                        'Yes',
                        MyColors.PRIMARY,
                      )),
                    ],
                  )
                ],
              ),
            )));
  }
}
