import 'dart:core';
import 'package:flutter/material.dart';

import '../common/Constants.dart';
import '../common/Profile.dart';

/*final accountDrawerHead = UserAccountsDrawerHeader(
  accountName: ,
);*/

Widget adminAccountDrawerHead(Profile _profile) => UserAccountsDrawerHeader(
  accountName: Text(_profile.getName()),
  accountEmail: Text(_profile.getUsername()),
  currentAccountPicture: CircleAvatar(
    backgroundColor: appDarkRedColor,
    child: Text(
      _profile.getName().substring(0, 1),
      style: TextStyle(
        color: appWhiteColor,
      ),
    ),
  ),
);
