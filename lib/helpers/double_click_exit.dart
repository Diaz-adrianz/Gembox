import 'package:fluttertoast/fluttertoast.dart';

Future<bool> doubleClickExit(DateTime? _currentBackPressTime) async {
  DateTime now = DateTime.now();

  if (_currentBackPressTime == null ||
      now.difference(_currentBackPressTime) > const Duration(seconds: 2)) {
    Fluttertoast.showToast(msg: 'Press back button again to exit');

    return false;
  }
  return true;
}
