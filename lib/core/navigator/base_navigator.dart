import 'package:flutter/material.dart';
import 'route_transition.dart';

abstract class BaseNavigator {
  final GlobalKey<NavigatorState> navigatorkey;
  BaseNavigator(this.navigatorkey);

  Future push(Widget widget, {String? name}) async {
    return navigatorkey.currentState?.push(
      RouteTransition.slideIn(widget),
    );
  }

  Future pop() async {
    return navigatorkey.currentState?.pop();
  }

  Future pushFadeIn(Widget widget) async {
    return navigatorkey.currentState?.push(
      RouteTransition.fadeIn(widget),
    );
  }

  void pushAndRemoveAllExceptThis(Widget widget) {
    navigatorkey.currentState?.pushAndRemoveUntil(
      RouteTransition.slideIn(widget),
      ((route) => false),
    );
  }
}
