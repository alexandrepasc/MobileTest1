import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/Profile.dart';
import '../common/RoutePaths.dart' as routes;
import '../view/adminView/AdminCoachesListPage.dart';
import '../view/adminView/AdminCoordinatorsListPage.dart';
import '../view/adminView/AdminDashboardPage.dart';
import '../view/adminView/AdminStudentsListPage.dart';
import '../view/ClassDetailPage.dart';
import '../view/CoachDetailPage.dart';
import '../view/CoordinatorDetailPage.dart';
import '../view/LoginPage.dart';
import '../view/SessionDetailPage.dart';
import '../view/SplashPage.dart';
import '../view/StudentDetailPage.dart';
import '../view/userView/UserDashboardPage.dart';
import '../view/userView/UserMyClassesPage.dart';
import '../view/userView/UserMySessionsPage.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case routes.loginPageTag:
      return MaterialPageRoute(builder: (context) => LoginPage());
    case routes.adminDashboardPageTag:
      Profile _profile = settings.arguments as Profile;
      return MaterialPageRoute(builder: (context) => DashboardPage(profile: _profile,));
    case routes.userDashboardPageTag:
      Profile _profile = settings.arguments as Profile;
      return MaterialPageRoute(builder: (context) => UserDashboard(profile: _profile,));
    case routes.splashPageTag:
      return MaterialPageRoute(builder: (context) => SplashPage());
    case routes.adminCoachesListPageTag:
      Profile _profile = settings.arguments as Profile;
      return MaterialPageRoute(builder: (context) => AdminCoachesListPage(profile: _profile,));
    case routes.adminCoordinatorsListPageTag:
      Profile _profile = settings.arguments as Profile;
      return MaterialPageRoute(builder: (context) => AdminCoordinatorsListPage(profile: _profile,));
    case routes.adminStudentsListPageTag:
      Profile _profile = settings.arguments as Profile;
      return MaterialPageRoute(builder: (context) => AdminStudentsListPage(profile: _profile,));
    case routes.sessionDetailPageTag:
      Profile _profile = settings.arguments as Profile;
      return MaterialPageRoute(builder: (context) => SessionDetailPage(profile: _profile,));
    case routes.userMySessionsPageTag:
      Profile _profile = settings.arguments as Profile;
      return MaterialPageRoute(builder: (context) => UserMySessionsPage(profile: _profile,));
    case routes.userMyClassesPageTag:
      Profile _profile = settings.arguments as Profile;
      return MaterialPageRoute(builder: (context) => UserMyClassesPage(profile: _profile,));
    case routes.classDetailPageTag:
      Profile _profile = settings.arguments as Profile;
      return MaterialPageRoute(builder: (context) => ClassDetailPage(profile: _profile,));
    case routes.coachDetailPageTag:
      Profile _profile = settings.arguments as Profile;
      return MaterialPageRoute(builder: (context) => CoachDetailPage(profile: _profile,));
    case routes.coordinatorDetailPageTag:
      Profile _profile = settings.arguments as Profile;
      return MaterialPageRoute(builder: (context) => CoordinatorDetailPage(profile: _profile,));
    case routes.studentDetailPageTag:
      Profile _profile = settings.arguments as Profile;
      return MaterialPageRoute(builder: (context) => StudentDetailPage(profile: _profile,));
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