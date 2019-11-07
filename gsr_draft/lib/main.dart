import 'package:flutter/material.dart';
import 'package:gsr_draft/Locator.dart';
import 'package:gsr_draft/service/NavigationService.dart';

import 'DashboardPage.dart';
import 'common/Constants.dart';
import 'common/RoutePaths.dart' as routes;
import 'common/Router.dart' as router;
import 'LoginPage.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  /*final routes = <String, WidgetBuilder>{
    loginPageTag: (context) => LoginPage(),
    dashboardPageTag: (context) => DashboardPage(null),
  };*/

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: new ThemeData(
        primaryColor: appWhiteColor,
      ),
      home: LoginPage(),
      onGenerateRoute: router.generateRoute,
      initialRoute: routes.loginPageTag,
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}
