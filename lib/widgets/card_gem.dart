import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gemboxapp/models/gem.dart';
import 'package:gemboxapp/widgets/image_network.dart';
import 'package:gemboxapp/widgets/spacers.dart';
import 'package:remixicon/remixicon.dart';

import '../themes/color.dart';

class CardGem extends StatelessWidget {
  final Gem data;
  final void Function(BuildContext context, {String? id}) delGem;
  final void Function(BuildContext context, {String? id}) openGem;

  const CardGem(
      {super.key,
      required this.data,
      required this.delGem,
      required this.openGem});

  String hideSecret(String s) {
    int len = s.length;

    if (len <= 3) return s;

    String visible = s.substring(0, 3);
    String stars = '*' * (len - 3);

    return '$visible$stars';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      child: Slidable(
        key: UniqueKey(),

        /////// DELETE GEM BUTTON ///////
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                delGem(context, id: data.id);
              },
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.red,
              icon: Remix.delete_bin_2_fill,
              label: 'Delete',
            )
          ],
        ),

        /////// OPEN GEM BUTTON ///////
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                openGem(context, id: data.id);
              },
              backgroundColor: Colors.transparent,
              foregroundColor: MyColors.PRIMARY,
              icon: Remix.eye_fill,
              label: 'Open',
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              color: MyColors.WHITE),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /////// GEM IMAGE ///////
                  SizedBox(
                    width: 54,
                    height: 54,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: ImageNetwork(data.imageurl!, 54, 54),
                    ),
                  ),
                  Horzspacing(16),

                  /////// GEM TYPE & TITLE ///////
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        data.type!,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        data.name!,
                        style: Theme.of(context).textTheme.headlineMedium,
                      )
                    ],
                  ))
                ],
              ),
              Separator(),

              /////// GEM SECRET ///////
              Text(
                hideSecret(data.secret!),
                style: Theme.of(context).textTheme.headlineSmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}
