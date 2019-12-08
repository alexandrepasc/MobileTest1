import 'package:flutter/material.dart';

import '../common/AdminDrawerListEnum.dart';
import '../common/Constants.dart';
import '../common/Profile.dart';
import '../common/RoutePaths.dart' as routes;
import '../component/AdminDrawer.dart';
import '../component/AppBar.dart';
import '../Locator.dart';
import '../service/NavigationService.dart';

class CoordinatorDetailPage extends StatefulWidget {
  final Profile profile;

  CoordinatorDetailPage({Key key, this.profile}) : super(key: key);

  _CoordinatorDetailPage createState() => _CoordinatorDetailPage();
}

class _CoordinatorDetailPage extends State<CoordinatorDetailPage> {
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
        drawer: adminDrawer(widget.profile, AdminDrawerListEnum.none, context),
        body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[Text("detail")]
            )
        )
    );
  }
}