import 'package:flutter/material.dart';

import '../../common/AdminDrawerListEnum.dart';
import '../../common/Constants.dart';
import '../../common/Profile.dart';
import '../../common/RolesEnum.dart';
import '../../common/RoutePaths.dart' as routes;
import '../../component/AdminDrawer.dart';
import '../../component/AppBar.dart';
import '../../component/BuildTable.dart';
import '../../component/LoadingCircle.dart';
import '../../Locator.dart';
import '../../service/NavigationService.dart';

class AdminCoordinatorsListPage extends StatefulWidget {
  final Profile profile;

  AdminCoordinatorsListPage({Key key, this.profile}) : super(key: key);

  _AdminCoordinatorsListPage createState() => _AdminCoordinatorsListPage();
}

class _AdminCoordinatorsListPage extends State<AdminCoordinatorsListPage> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: appWhiteColor,
      appBar: applicationBar(),
      drawer: adminDrawer(widget.profile, AdminDrawerListEnum.coordinators, context),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text("Coordinators")
          ],
        ),
      ),
    );
  }
}