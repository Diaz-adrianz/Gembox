// d
import 'package:flutter/material.dart';
import 'package:gemboxapp/themes/color.dart';
import 'package:remixicon/remixicon.dart';

Widget ImageNetwork(String url, double width, double height,
    {BoxFit fit = BoxFit.cover}) {
  return Image.network(
    url,
    fit: BoxFit.cover,
    loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) {
        return child;
      } else {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(MyColors.PRIMARY),
          ),
        );
      }
    },
    errorBuilder: (context, error, stackTrace) {
      return SizedBox(
        width: width,
        height: height,
        child: const Icon(
          Remix.emotion_sad_fill,
          color: MyColors.GRAY,
          size: 64,
        ),
      );
    },
  );
}
