import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gemboxapp/helpers/double_click_exit.dart';
import 'package:gemboxapp/models/gem.dart';
import 'package:gemboxapp/screens/bs_form.dart';
import 'package:gemboxapp/screens/setup.dart';
import 'package:gemboxapp/services/database_gems.dart';
import 'package:gemboxapp/services/prefs.dart';
import 'package:gemboxapp/themes/color.dart';
import 'package:gemboxapp/widgets/card_gem.dart';
import 'package:gemboxapp/widgets/confirmation_dialog.dart';
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
  List<Gem> _gems = [];
  String? _keyword;
  DateTime? _currentBackPressTime;

  // UTILITIES
  bool validateInput(String str) {
    if (str.isEmpty || !str.contains(' ')) return false;

    if (str.split(' ')[1] == '') return false;

    if (str.split(' ')[0] != _keyword) return false;

    return true;
  }

  void searchChanged(String val) async {
    List<Gem> results = [];

    if (validateInput(val)) {
      results = await DatabaseGems.list(val.split(' ').sublist(1).join(' '));
    }

    setState(() {
      _gems = results;
    });
  }

  void delGem(BuildContext ctx, {String? id}) async {
    bool confirm = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return const ConfirmDialog(
              'Delete permanently this Gem?', 'You cannot undo this action');
        });

    if (!confirm || id == null) return;

    bool res = await DatabaseGems.delete(id);

    if (res) {
      setState(() {
        _gems = _gems.where((Gem gem) => gem.id != id).toList();
      });
    }

    Fluttertoast.showToast(msg: res ? 'Gem deleted' : 'Something wrong :(');
  }

  void openGem(BuildContext ctx, {String? id}) {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        backgroundColor: Colors.transparent,
        enableDrag: true,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return FormGem(id);
        });
  }

  void loadKeyword() async {
    String? keyword = await Prefs().read('keywordd');

    keyword != null
        ? setState(() {
            _keyword = keyword;
          })
        : Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const SetupPage()),
            (route) => false);
  }

  @override
  void initState() {
    super.initState();

    loadKeyword();
  }

  @override
  void dispose() {
    search_ctrl.dispose();
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
          backgroundColor: MyColors.SURFACE,
          body: Stack(
            children: [
              RefreshIndicator(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 48, 16, 0),
                    children: [
                      for (Gem dat in _gems)
                        CardGem(data: dat, delGem: delGem, openGem: openGem)
                    ],
                  ),
                  onRefresh: () async {
                    searchChanged(search_ctrl.text);
                  }),
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
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                    builder: (BuildContext context) =>
                                        const FormGem(null));
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
        ));
  }
}
