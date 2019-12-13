import 'package:flutter/material.dart';

import 'package:gsr_draft/model/UserModelRes.dart' as userModel;

import '../common/AdminDrawerListEnum.dart';
import '../common/Auth.dart';
import '../common/Coach.dart';
import '../common/Constants.dart';
import '../common/Profile.dart';
import '../common/RolesEnum.dart';
import '../common/RoutePaths.dart' as routes;
import '../component/coachDetail/CoachDetailAuthTab.dart';
import '../component/coachDetail/CoachDetailProfileTab.dart';
import '../component/AdminDrawer.dart';
import '../component/AppBar.dart';
import '../component/LoadingCircle.dart';
import '../Locator.dart';
import '../model/UserModelRes.dart';
import '../service/AuthService.dart';
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
        child: _getChildren(_currentIndex),
      ),
      bottomNavigationBar: _getBottomNavBar(),
    );
  }


  int _currentIndex = 0;

  _getChildren(int x) {
    switch (x) {
      case 0:
        return CoachDetailProfileTab(profile: widget.profile,);
      case 1:
        return _getAuthTab();
    }
  }



  UserModelRes _userModel;

  Widget _getAuthTab() {

    _apiGetAuth(widget.profile.getToken(), widget.profile.getCoach().getAuthId());

    Auth auth = new Auth(
        _userModel.id,
        _userModel.username,
        _userModel.name,
        _userModel.notes,
        _userModel.roles
    );

    Profile profile = widget.profile;
    profile.setAuth(auth);

    return CoachDetailAuthTab(profile: profile,);
  }

  Future _apiGetAuth(String token, String id) async {

    await getPost(id, token).then((response) {

      if (response.statusCode == 200) {

        _userModel = userModel.postFromJson(response.body);
        print(_userModel.id);
        return _userModel;

      } else if (response.statusCode == 401) {
        print("CoachDetailAuthTab: cod 401");
        _navigationService.navigateToAndRemove(routes.loginPageTag);
        return null;
      } else {
        print("CoachDetailAuthTab: " + response.statusCode.toString());
        return null;
      }

    }).catchError((error) {
      print("CoachDetailAuthTab: " + error);
      return null;
    });
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