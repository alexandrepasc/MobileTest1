import 'package:flutter/material.dart';

import '../../common/AdminDrawerListEnum.dart';
import '../../common/Constants.dart';
import '../../common/Profile.dart';
import '../../common/RoutePaths.dart' as routes;
import '../../component/AdminDrawer.dart';
import '../../component/AppBar.dart';
import '../../component/LoadingCircle.dart';
import '../../Locator.dart';
import '../../service/NavigationService.dart';

class UserMySessionsPage extends StatefulWidget {
  final Profile profile;

  UserMySessionsPage({Key key, this.profile}) : super(key: key);

  _UserMySessionsPage createState() => _UserMySessionsPage();
}

class _UserMySessionsPage extends State<UserMySessionsPage> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: appWhiteColor,
      appBar: applicationBar(),
      drawer: adminDrawer(widget.profile, AdminDrawerListEnum.mysessions, context),
      body: Text("My Sessions"),
    );
  }
}