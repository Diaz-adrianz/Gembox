import 'package:flutter/material.dart';
import 'package:gemboxapp/screens/splash_screen.dart';
import 'package:gemboxapp/themes/theme_color.dart';
import 'package:gemboxapp/themes/theme_texts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
          textTheme: ThemeText.light,
          extensions: <ThemeExtension<dynamic>>[ThemeColor.light]),
      darkTheme: ThemeData.dark().copyWith(
          textTheme: ThemeText.dark,
          extensions: <ThemeExtension<dynamic>>[ThemeColor.dark]),
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
