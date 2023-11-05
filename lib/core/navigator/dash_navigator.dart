import 'package:flutter/material.dart';

import 'base_navigator.dart';

class DashNavigator extends BaseNavigator {
  DashNavigator(GlobalKey<NavigatorState> navigatorkey) : super(navigatorkey);
  void toLogin() {
    pushAndRemoveAllExceptThis(
      const Text(""),
    );
  }

  void toSignUp() {
    push(
      const Text(""),
    );
  }
}
