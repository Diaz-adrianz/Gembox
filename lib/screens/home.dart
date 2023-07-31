import 'package:flutter/material.dart';
import 'package:gemboxapp/themes/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.SURFACE,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 0),
          )
          , Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            ),
          )
        ],
      ),
    )
  }
}