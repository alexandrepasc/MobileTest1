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

class UserMyClassesPage extends StatefulWidget {
  final Profile profile;

  UserMyClassesPage({Key key, this.profile}) : super(key: key);

  _UserMyClassesPage createState() => _UserMyClassesPage();
}

class _UserMyClassesPage extends State<UserMyClassesPage> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {

  }
}