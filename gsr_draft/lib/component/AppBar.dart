import 'package:flutter/material.dart';

import '../common/Constants.dart';

Widget applicationBar() => AppBar(
  title: Text(
    appTitle,
    textAlign: TextAlign.center,
    style: TextStyle(
      color: appWhiteColor,
    ),
  ),
  centerTitle: true,
  backgroundColor: appDarkRedColor,
  iconTheme: new IconThemeData(color: appWhiteColor),
);