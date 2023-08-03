import 'dart:async';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gemboxapp/helpers/double_click_exit.dart';
import 'package:gemboxapp/screens/home.dart';
import 'package:gemboxapp/services/prefs.dart';
import 'package:gemboxapp/widgets/spacers.dart';
import 'package:remixicon/remixicon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../themes/color.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({super.key});

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  // CONTROLLER
  TextEditingController keyword_ctrl = TextEditingController();

  // STATE
  bool _button_disable = true;
  String _hint = 'key';
  DateTime? _currentBackPressTime;

  // VALUES
  List<String> hints = [
    'blue',
    'cat',
    'mercy',
    'glass',
    'key',
    'choco',
    'bro',
    'cool',
    'dev'
  ];
  String guide_link =
      'https://docs.google.com/document/d/1BSBBqM1fX58eT8mwgFloQFOZM68whprT-KVE6rp2778/edit?usp=sharing';
  Timer? hint_timer;

  bool validateInput(String val) {
    if (val.length < 3) return false;

    if (val.contains(' ')) {
      Fluttertoast.showToast(msg: 'Keyword cant contain any white space');
      return false;
    }

    if (val != val.toLowerCase()) {
      Fluttertoast.showToast(msg: 'Keyword must be in lowercase');
      return false;
    }

    if (val.length > 5) {
      Fluttertoast.showToast(msg: 'Keyword max length of 5 characters');
      return false;
    }

    return true;
  }

  void inputChanged(String val) {
    setState(() {
      _button_disable = !validateInput(val);
    });
  }

  void submitKeyword() async {
    if (_button_disable) return;

    await Prefs().save('keywordd', keyword_ctrl.text);

    Fluttertoast.showToast(msg: 'Your keyword saved!');
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  void initState() {
    super.initState();

    hint_timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _hint = hints[Random().nextInt(hints.length)];
      });
    });
  }

  @override
  void dispose() {
    hint_timer?.cancel();
    keyword_ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          bool res = await doubleClickExit(_currentBackPressTime);

          if (!res) {
            setState(() {
              _currentBackPressTime = DateTime.now();
            });
          }

          return res;
        },
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 48, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: SizedBox(
                        width: 280,
                        height: 280,
                        child: Image.asset(
                            'assets/images/setup_illustration.png',
                            fit: BoxFit.cover),
                      ),
                    ),
                    Vertspacing(16),
                    Text(
                      'Lets Get Started',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Vertspacing(8),
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                              text:
                                  'Set your own secret keyword. It is recommended to use short and easy to remember. Use your keyword at the beginning of every search you do. More in the ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: MyColors.GRAY)),
                          TextSpan(
                              text: 'User Guide',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: MyColors.PRIMARY,
                                      decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  if (!await launch(guide_link,
                                      forceWebView: false)) {
                                    Fluttertoast.showToast(
                                        msg: "Link cant be opened");
                                  }
                                  ;
                                })
                        ]))
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(20, 0, 0, 0),
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10,
                          spreadRadius: 3,
                        ), //BoxShadow
                      ],
                      color: MyColors.WHITE,
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),

                  /////// KEYWORD INPUT ///////
                  child: TextField(
                      controller: keyword_ctrl,
                      onChanged: inputChanged,
                      textInputAction: TextInputAction.done,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(

                          /////// SUBMIT BUTTON ///////
                          suffix: GestureDetector(
                            onTap: submitKeyword,
                            child: Text(
                              'Submit',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: _button_disable
                                          ? MyColors.GRAY
                                          : MyColors.PRIMARY),
                            ),
                          ),
                          /////// end: SUBMIT BUTTON ///////

                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: MyColors.GRAY),
                          hintText: _hint,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          border: InputBorder.none)),
                ),
              )
            ],
          ),
        ));
  }
}
