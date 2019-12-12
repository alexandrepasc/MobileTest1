import 'package:flutter/material.dart';

import 'package:gsr_draft/model/UserModelRes.dart' as userModel;

import '../../common/Constants.dart';
import '../../common/Profile.dart';
import '../../common/RolesEnum.dart';
import '../../common/RoutePaths.dart' as routes;
import '../../Locator.dart';
import '../../model/UserModelRes.dart';
import '../../service/AuthService.dart';
import '../../service/NavigationService.dart';

class CoachDetailAuthTab extends StatefulWidget {

  final Profile profile;

  CoachDetailAuthTab({Key key, this.profile}) : super(key: key);

  _CoachDetailAuthTab createState() => _CoachDetailAuthTab();
}

ContentData contentData = new ContentData();

class _CoachDetailAuthTab extends State<CoachDetailAuthTab> {
  final NavigationService _navigationService = locator<NavigationService>();

  bool _readOnly = true;

  UserModelRes _userModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    OrientationBuilder _orientationBuilder() => OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
            padding: EdgeInsets.all(15.0),
            crossAxisCount: orientation == Orientation.portrait ? 1 : 2,
            children: <Widget>[],
          );
        }
    );

    return Scrollbar(
      child: _orientationBuilder(),
    );
  }

  Future _apiGetAuth(String token, String id) async {

    await getPost(id, token).then((response) {

      if (response.statusCode == 200) {

        _userModel = userModel.postFromJson(response.body);

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
}

class ContentData {

  String _username;
  String _name;
  String _notes;

  //TO IMPLEMENT
  String _password;

  getUsername() {
    return _username;
  }

  setUsername(String _username) {
    this._username = _username;
  }

  getName() {
    return _name;
  }

  setName(String _name) {
    this._name = _name;
  }

  getNotes() {
    return _notes;
  }

  setNotes(String _notes) {
    this._notes = _notes;
  }
}