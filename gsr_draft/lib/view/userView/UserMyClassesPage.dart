import 'package:flutter/material.dart';
import 'package:gsr_draft/model/ClassModel.dart' as clasModel;

import '../../common/AdminDrawerListEnum.dart';
import '../../common/Constants.dart';
import '../../common/Profile.dart';
import '../../common/RoutePaths.dart' as routes;
import '../../component/AdminDrawer.dart';
import '../../component/AppBar.dart';
import '../../component/LoadingCircle.dart';
import '../../Locator.dart';
import '../../model/ClassModel.dart';
import '../../service/ClassService.dart';
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

  ClassesModel classesModel;

  Future<ClassesModel> _getClasses(Profile profile) async {

    await getClassByCoach(profile.getToken(), profile.getCoachId()).then((response) async {

      if (response.statusCode == 200) {

        ClassesModel classes = clasModel.getFromJson(response.body);

        if (classes.classes.length > 0) {

        } else {
          
        }

      } else if (response.statusCode == 401) {
        print("cod 401");
        _navigationService.navigateToAndRemove(routes.loginPageTag);
        return null;
      } else {
        print(response.statusCode);
        return null;
      }

    }).catchError((error) {
      print(error);
      return null;
    });
  }
}