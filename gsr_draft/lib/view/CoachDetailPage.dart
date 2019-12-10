import 'package:flutter/material.dart';

import '../common/AdminDrawerListEnum.dart';
import '../common/Constants.dart';
import '../common/Coordinator.dart';
import '../common/Profile.dart';
import '../common/RolesEnum.dart';
import '../common/RoutePaths.dart' as routes;
import '../component/AdminDrawer.dart';
import '../component/AppBar.dart';
import '../component/LoadingCircle.dart';
import '../Locator.dart';
import '../service/NavigationService.dart';

class CoachDetailPage extends StatefulWidget {
  final Profile profile;

  CoachDetailPage({Key key, this.profile}) : super(key: key);

  _CoachDetailPage createState() => _CoachDetailPage();
}

class _CoachDetailPage extends State<CoachDetailPage> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

  }
}