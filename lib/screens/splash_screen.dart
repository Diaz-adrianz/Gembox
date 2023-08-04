import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gemboxapp/screens/home.dart';
import 'package:gemboxapp/screens/setup.dart';
import 'package:gemboxapp/services/prefs.dart';
import 'package:gemboxapp/themes/color.dart';

import '../themes/theme_color.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeColor clr = Theme.of(context).extension<ThemeColor>()!;

    // redirect condition by owner keyword
    Timer(const Duration(seconds: 2), () async {
      String? keyword = await Prefs().read('keywordd');

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              keyword == null ? const SetupPage() : const HomePage()));
    });

    return Container(
      color: clr.PRIMARY,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 136,
              child: Image.asset('assets/images/logo_white.png'),
            ),
            Text(
              'GEMBOX',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: clr.WHITE),
            )
          ],
        ),
      ),
    );
  }
}
