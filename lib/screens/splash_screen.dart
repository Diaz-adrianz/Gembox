import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gemboxapp/screens/home.dart';
import 'package:gemboxapp/themes/color.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // redirect condition by owner keyword
    Timer(const Duration(seconds: 2), () async {
      String? keyword = null;

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return keyword == null ? HomePage() : HomePage();
      }));
    });

    return Container(
      color: MyColors.PRIMARY,
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
                  .copyWith(color: MyColors.WHITE),
            )
          ],
        ),
      ),
    );
  }
}
