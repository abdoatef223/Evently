import 'package:evently_c19/core/remote/local/prefs_manager.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode selectedTheme = ThemeMode.light;
  init(){
    selectedTheme = PrefsManager.getTheme();
    notifyListeners();
  }
  changeTheme(ThemeMode newTheme){
    if(newTheme==selectedTheme) return;
    selectedTheme = newTheme;
    PrefsManager.saveTheme(selectedTheme);
    notifyListeners();
  }
}