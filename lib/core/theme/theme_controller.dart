import 'package:flutter/material.dart';

class ThemeController {
  /// Uygulamanın TEK tema kaynağı
  static final ValueNotifier<ThemeMode> themeMode = ValueNotifier<ThemeMode>(
    ThemeMode.dark,
  );

  static bool get isDark => themeMode.value == ThemeMode.dark;

  static void setDark(bool isDark) {
    themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
  }
}
