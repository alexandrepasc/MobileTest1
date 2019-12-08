import 'package:flutter/material.dart';

import 'package:gsr_draft/model/UserModelRes.dart' as userModel;

import '../../common/AdminDrawerListEnum.dart';
import '../../common/Constants.dart';
import '../../common/Profile.dart';
import '../../common/RoutePaths.dart' as routes;
import '../../component/AdminDrawer.dart';
import '../../component/AppBar.dart';
import '../../component/BuildTable.dart';
import '../../component/LoadingCircle.dart';
import '../../Locator.dart';
import '../../model/UserModelRes.dart';
import '../../service/AuthService.dart';
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
            new FutureBuilder(
                future: _getCoordinators(widget.profile),
                builder: (context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      print("AdminCoordinatorsListPage: none");
                      return loadingCircle();
                    case ConnectionState.waiting:
                      print("AdminCoordinatorsListPage: waiting");
                      return loadingCircle();
                    case ConnectionState.active:
                      return loadingCircle();
                    case ConnectionState.done:
                      print("AdminCoordinatorsListPage: yap1");
                      return _getData();
                    default:
                      if (snapshot.hasError) {
                        print("AdminCoordinatorsListPage: error: ${snapshot.error}");
                        return Text("Error");
                      }
                      print("AdminCoordinatorsListPage: nop");
                      return loadingCircle();
                  }
                }
            )
          ],
        ),
      ),
    );
  }

  UsersModel _users;

  Future<UsersModel> _getCoordinators(Profile profile) async {

    await getCoordinators(profile.getToken()).then((response) {

      if (response.statusCode == 200) {

        UsersModel usersModel = userModel.getUsersFromJson(response.body);

        _users = usersModel;

        return _users;

      } else if (response.statusCode == 401) {
        print("AdminCoordinatorsListPage: cod 401");
        _navigationService.navigateToAndRemove(routes.loginPageTag);
        return null;
      } else {
        print("AdminCoordinatorsListPage: " + response.statusCode.toString());
        return null;
      }
    }).catchError((error) {
      print("AdminCoordinatorsListPage: " + error);
      return null;
    });
  }

  Widget _getData() {

    if (_users.users.length > 0) {
      return _getTable();
    } else {
      return Text("No data");
    }
  }

  DataTable _getTable() => DataTable(
      columns: [
        topRowCell("Username", 16.0),
        topRowCell("Name", 16.0),
        topRowCell("Notes", 16.0)
      ],
      rows: [...buildRowsAdminCoordinatorsList(_users.users, widget.profile)]
  );
}