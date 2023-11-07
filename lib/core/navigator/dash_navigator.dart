import 'package:flutter/material.dart';
import 'package:ubenwa/presentation/presentation.dart';

import 'base_navigator.dart';

class DashNavigator extends BaseNavigator {
  DashNavigator(GlobalKey<NavigatorState> navigatorkey) : super(navigatorkey);
  void toLogin() {
    pushAndRemoveAllExceptThis(
      const Text(""),
    );
  }

  void toDashboard() {
    pushAndRemoveAllExceptThis(
      const Text(""),
    );
  }

  void toCryRecord() {
    push(
      const CryRecordPage(),
    );
  }

  void toLoader() {
    push(
      const PreloaderPage(),
    );
  }

  void toSignUp() {
    push(
      const Text(""),
    );
  }
}
