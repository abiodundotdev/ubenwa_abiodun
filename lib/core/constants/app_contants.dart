import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();
  static String logoUrl = "https://www.efgroup.ng/images/logo.png";
  static EdgeInsets contentPadding =
      const EdgeInsets.symmetric(horizontal: 15.0);
  static BorderRadius borderRadius = BorderRadius.circular(10.0);
  static Duration animationDuration = const Duration(milliseconds: 300);
  static Duration requestDuration = const Duration(seconds: 1000);
}
