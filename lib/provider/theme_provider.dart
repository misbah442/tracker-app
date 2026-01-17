import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkmode = false;

  bool getValue() =>
      _isDarkmode; // create the function for the private varaible

  ThemeProvider() {
    loadData(); // call the function here
  }
  Future<void> updateTheme({required bool value}) async {
    _isDarkmode = value; // update the value  and store the theme locally
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("ThemeKey", value);
    notifyListeners();
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkmode = prefs.getBool("ThemeKey") ?? false;
    notifyListeners();
  }
}
