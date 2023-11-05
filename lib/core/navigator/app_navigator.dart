import 'package:flutter/material.dart';

import 'auth_navigator.dart';

class AppNavigator {
  AppNavigator(GlobalKey<NavigatorState> navigatorKey)
      : auth = AuthNavigator(navigatorKey),
        dash = AuthNavigator(navigatorKey);
  final AuthNavigator auth;
  final DashNavigator dash;
}
