import 'package:flutter/material.dart';

import 'package:gsr_draft/model/ClassModel.dart' as clasModel;

import '../../common/AdminDrawerListEnum.dart';
import '../../common/Class.dart';
import '../../common/Constants.dart';
import '../../common/Profile.dart';
import '../../common/RoutePaths.dart' as routes;
import '../../component/AdminDrawer.dart';
import '../../component/AppBar.dart';
import '../../component/BuildTable.dart';
import '../../component/LoadingCircle.dart';
import '../../Locator.dart';
import '../../model/ClassModel.dart';
import '../../service/ClassService.dart';
import '../../service/NavigationService.dart';

class AdminClassesListPage extends StatefulWidget {
  final Profile profile;

  AdminClassesListPage({Key key, this.profile}) : super(key: key);

  _AdminClassesListPage createState() => _AdminClassesListPage();
}

class _AdminClassesListPage extends State<AdminClassesListPage> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: appWhiteColor,
      appBar: applicationBar(),
      drawer: adminDrawer(widget.profile, AdminDrawerListEnum.classes, context),
      body: Scrollbar(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new FutureBuilder(
                    future: _apiGetClasses(widget.profile.getToken()),
                    builder: (context, AsyncSnapshot snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          print("AdminClassesListPage: none");
                          return loadingCircle();
                        case ConnectionState.waiting:
                          print("AdminClassesListPage: waiting");
                          return loadingCircle();
                        case ConnectionState.active:
                          return loadingCircle();
                        case ConnectionState.done:
                          print("AdminClassesListPage: yap1");
                          return _getData();
                        default:
                          if (snapshot.hasError) {
                            print("AdminClassesListPage: error: ${snapshot.error}");
                            return _getData();
                          }
                          print("AdminClassesListPage: nop");
                          return loadingCircle();
                      }
                    }
                ),
              ],
            )
          )
      ),
    );
  }
  
  ClassesModel _classesModel;

  _getData() {

    if (_classesModel != null) {
      return _getTable();
    } else {
      return Text("No data");
    }
  }

  DataTable _getTable() => DataTable(
      columns: [
        topRowCell("Name", 16.0),
        topRowCell("Description", 16.0),
        topRowCell("Students #", 16.0),
      ],
      rows: [...buildRowsAdminClassesList(_classesModel.classes, widget.profile)]
  );
  
  Future _apiGetClasses(String token) async {
    
    await getClasses(token).then((response) {

      if (response.statusCode == 200) {

        ClassesModel classes = clasModel.getFromJson(response.body);

        if (classes.classes.length > 0) {

          _classesModel = classes;

          return _classesModel;
        } else {
          return null;
        }

      } else if (response.statusCode == 401) {
        print("AdminClassesListPage: cod 401");
        _navigationService.navigateToAndRemove(routes.loginPageTag);
        return null;
      } else {
        print("AdminClassesListPage: " + response.statusCode.toString());
        return null;
      }

    }).catchError((error) {
      print("AdminClassesListPage: " + error);
      return null;
    });
  }
}