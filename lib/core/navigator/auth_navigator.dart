import 'package:flutter/material.dart';
import 'package:ubenwa/presentation/presentation.dart';

import 'base_navigator.dart';

class AuthNavigator extends BaseNavigator {
  AuthNavigator(GlobalKey<NavigatorState> navigatorkey) : super(navigatorkey);
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

  void toOnboarding() {
    push(
      const OnboardingPage(),
    );
  }
}
