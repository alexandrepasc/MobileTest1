import 'package:flutter/material.dart';

import '../common/AdminDrawerListEnum.dart';
import '../common/Coach.dart';
import '../common/Constants.dart';
import '../common/Profile.dart';
import '../common/RolesEnum.dart';
import '../common/RoutePaths.dart' as routes;
import '../component/coachDetail/CoachDetailProfileTab.dart';
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

    return Scaffold(
      backgroundColor: appWhiteColor,
      appBar: applicationBar(),
      drawer: adminDrawer(widget.profile, AdminDrawerListEnum.none, context),
      body: Center(
        child: ListView(
          children: <Widget>[
              _getChildren(_currentIndex),
          ],
        ),
      ),
      bottomNavigationBar: _getBottomNavBar(),
    );
  }


  int _currentIndex = 0;

  _getChildren(int x) {
    switch (x) {
      case 0:
        return CoachDetailProfileTab(profile: widget.profile,);
      /*case 1:
        return SessionDetailAttendanceTab(profile: widget.profile,);*/
    }
  }

  BottomNavigationBar _setBottomNavBar() => BottomNavigationBar(
    currentIndex: _currentIndex,
    onTap: onTabTapped,
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        title: Text("Profile"),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.lock),
        title: Text("Authentication"),
      ),
    ],
  );

  Theme _getBottomNavBar() => Theme(
    data: Theme.of(context).copyWith(
      canvasColor: appDarkRedColor,
      primaryColor: appDarkGreyColor,
      textTheme: Theme.of(context).textTheme.copyWith(
        caption: TextStyle(color: appWhiteColor),
      ),
    ),
    child: _setBottomNavBar(),
  );

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}