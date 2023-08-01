import 'package:flutter/material.dart';
import 'package:gemboxapp/models/gem.dart';
import 'package:gemboxapp/screens/bs_form.dart';
import 'package:gemboxapp/themes/color.dart';
import 'package:gemboxapp/widgets/card_gem.dart';
import 'package:remixicon/remixicon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // CONTROLLERS
  TextEditingController search_ctrl = TextEditingController(text: '');

  // STATES
  List<Gem> _gems = [
    // Gems(
    //     id: '1',
    //     name: "Google",
    //     secret: '12345',
    //     type: 'Pin',
    //     imageurl:
    //         'https://banner2.cleanpng.com/20180521/ers/kisspng-google-logo-5b02bbe1d5c6e0.2384399715269058258756.jpg'),
  ];
  String? _keyword;

  // UTILITIES
  bool validateInput(String str) {
    if (str.isEmpty) return false;

    List<String> words = str.split(' ');
    if (words.length < 2) return false;

    if (words.first != _keyword) return false;

    return true;
  }

  void searchChanged(String val) async {
    List<Gem> results = [];

    if (validateInput(val)) {
      // results = await DBgems.listGems(q.split(' ').sublist(1).join(' '));
      results = [];
    }

    setState(() {
      _gems = results;
    });
  }

  void delGem(BuildContext ctx, {String? id}) {}

  void openGem(BuildContext ctx, {String? id}) {}

  @override
  void dispose() {
    search_ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.SURFACE,
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 0),
            children: [
              for (Gem dat in _gems)
                CardGem(data: dat, delGem: delGem, openGem: openGem)
            ],
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
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 32),

              /////// SEARCH BAR ///////
              child: TextField(
                  controller: search_ctrl,
                  onChanged: searchChanged,
                  textInputAction: TextInputAction.search,
                  style: Theme.of(context).textTheme.bodyMedium,
                  onTapOutside: (evt) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Remix.search_2_line,
                        color: MyColors.GRAY,
                      ),

                      /////// OPEN FORM BUTTON ///////
                      suffixIcon: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: const BoxDecoration(
                            border: Border(
                                left: BorderSide(color: MyColors.SILVER))),
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                isDismissible: false,
                                enableDrag: true,
                                isScrollControlled: true,
                                builder: (BuildContext context) => FormGem());
                          },
                          child: const Icon(
                            Remix.add_fill,
                            size: 32,
                            color: MyColors.PRIMARY,
                          ),
                        ),
                      ),
                      /////// end: OPEN FORM BUTTON ///////

                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: MyColors.GRAY),
                      hintText: "Search here...",
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      border: InputBorder.none)),
            ),
          )
        ],
      ),
    );
  }
}
