import 'package:flutter/material.dart';

///Widget keys to identify each widget mostly used when testing,
///Or used to search for a widget on the widget tree
///
class AppWidgetKeys {
  AppWidgetKeys._();
  //Cry record page keys
  static Key horizontalCalender = const Key("horizontal_calender");
  static Key overview = const Key("overview");
  static Key hourlybreakdown = const Key("hourly_breakdown");
  static Key challenge = const Key("challenge");
  static Key parentScrollable = const Key("parent_scrollable");
  //Onboarding
  static Key scrollIndicator = const Key("scroll_indicator");

  static Key babyBottle = const Key("baby_bottle");
}
