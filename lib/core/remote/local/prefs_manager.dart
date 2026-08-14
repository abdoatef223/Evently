import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static saveTheme(ThemeMode theme) {
    if (theme == ThemeMode.dark) {
      sharedPreferences.setString("theme", "dark");
    } else {
      sharedPreferences.setString("theme", "light");
    }
  }

  static ThemeMode getTheme() {
    String savedTheme = sharedPreferences.getString("theme") ?? "light";
    if (savedTheme == "dark") {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }

  // ── Onboarding ────────────────────────────────────────────────────
  static Future<void> setOnboardingSeen() async {
    await sharedPreferences.setBool("onboarding_seen", true);
  }

  static bool isOnboardingSeen() {
    return sharedPreferences.getBool("onboarding_seen") ?? false;
  }
}