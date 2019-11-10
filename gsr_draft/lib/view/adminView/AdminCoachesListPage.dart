import 'dart:core';
import 'package:flutter/material.dart';

import '../../common/AdminDrawerListEnum.dart';
import '../../common/Constants.dart';
import '../../common/Profile.dart';
import '../../component/AdminDrawer.dart';
import '../../component/AppBar.dart';
import '../../Locator.dart';
import '../../service/NavigationService.dart';

class AdminCoachesListPage extends StatelessWidget {

  final NavigationService _navigationService = locator<NavigationService>();

  final Profile profile;

  AdminCoachesListPage({Key key, this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: appWhiteColor,
      appBar: applicationBar(),
      drawer: adminDrawer(profile, AdminDrawerListEnum.coaches, context),
    );
  }
}