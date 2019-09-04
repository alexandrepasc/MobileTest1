import 'package:flutter/material.dart';

import 'LoginPage.dart';
import 'common/Constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final routes = <String, WidgetBuilder>{
    loginPageTag: (context) => LoginPage(),
    //homePageTag: (context) => HomePage(),
  };

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
      routes: routes,
    );
  }
}
