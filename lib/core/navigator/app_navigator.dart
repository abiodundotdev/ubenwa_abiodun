import 'package:flutter/material.dart';

import 'auth_navigator.dart';
import 'dash_navigator.dart';

class AppNavigator {
  AppNavigator(GlobalKey<NavigatorState> navigatorKey)
      : auth = AuthNavigator(navigatorKey),
        dash = DashNavigator(navigatorKey);
  final AuthNavigator auth;
  final DashNavigator dash;
}
