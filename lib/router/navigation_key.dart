import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  static navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  static navigateToWithArguments(String routeName, dynamic argument) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: argument);
  }

  static replaceTo(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }
}
