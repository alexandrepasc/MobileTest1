import 'package:flutter/material.dart';
import 'package:gsr_draft/Login.dart';
import 'package:gsr_draft/common/Constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
    );
  }
}
