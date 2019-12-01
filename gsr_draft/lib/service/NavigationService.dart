import 'package:flutter/widgets.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateToAndRemove(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState.pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateToAndRemoveNoArgs(String routeName) {
    return navigatorKey.currentState.pushReplacementNamed(routeName);
  }

  Future<dynamic> navigateToAndClear(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState.pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false, arguments: arguments);
  }

  bool goBack() {
    return navigatorKey.currentState.pop();
  }
}