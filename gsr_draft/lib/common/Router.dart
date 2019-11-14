import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/Profile.dart';
import '../common/RoutePaths.dart' as routes;
import '../view/adminView/AdminCoachesListPage.dart';
import '../view/DashboardPage.dart';
import '../view/LoginPage.dart';
import '../view/SplashPage.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case routes.loginPageTag:
      return MaterialPageRoute(builder: (context) => LoginPage());
    case routes.dashboardPageTag:
      Profile _profile = settings.arguments as Profile;
      return MaterialPageRoute(builder: (context) => DashboardPage(profile: _profile,));
    case routes.splashPageTag:
      return MaterialPageRoute(builder: (context) => SplashPage());
    case routes.adminCoachesListPageTag:
      Profile _profile = settings.arguments as Profile;
      return MaterialPageRoute(builder: (context) => AdminCoachesListPage(profile: _profile,));
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}