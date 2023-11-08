import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  bool get isLightMode => Theme.of(this).brightness == Brightness.light;
}

extension XThemeMode on ThemeMode {
  bool get isDark => this == ThemeMode.dark;
}
