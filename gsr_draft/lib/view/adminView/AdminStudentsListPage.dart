import 'package:flutter/material.dart';
import 'package:gsr_draft/model/StudentsModel.dart' as studModel;

import '../../common/AdminDrawerListEnum.dart';
import '../../common/Constants.dart';
import '../../common/Profile.dart';
import '../../common/RoutePaths.dart' as routes;
import '../../component/AdminDrawer.dart';
import '../../component/AppBar.dart';
import '../../component/BuildTable.dart';
import '../../component/LoadingCircle.dart';
import '../../Locator.dart';
import '../../model/StudentsModel.dart';
import '../../service/NavigationService.dart';
import '../../service/StudentsService.dart';

class AdminStudentsListPage extends StatefulWidget {
  final Profile profile;

  AdminStudentsListPage({Key key, this.profile}) : super(key: key);

  _AdminStudentsListPage createState() => _AdminStudentsListPage();
}

class _AdminStudentsListPage extends State<AdminStudentsListPage> {
  final NavigationService _navigationService = locator<NavigationService>();

  var _future;

  @override
  initState() {
    super.initState();
    _future = _getStudents(widget.profile);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: appWhiteColor,
        appBar: applicationBar(),
        drawer: adminDrawer(widget.profile, AdminDrawerListEnum.students, context),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new FutureBuilder(
                  future: _future,
                  builder: (context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        print("AdminStudentsListPage: none");
                        return loadingCircle();
                      case ConnectionState.waiting:
                        print("AdminStudentsListPage: waiting");
                        return loadingCircle();
                      case ConnectionState.active:
                        return Text("active");
                      case ConnectionState.done:
                        print("AdminStudentsListPage: yap1");
                        return _getStudentsTable();
                      default:
                        if (snapshot.hasError) {
                          print("AdminStudentsListPage: error: ${snapshot.error}");
                          return Text("Error");
                        }
                        print("AdminStudentsListPage: nop");
                        return loadingCircle();
                    }
                  }
              ),
            ],
          ),
        ),
    );
  }

  StudentsModel _students;

  Future<StudentsModel> _getStudents(Profile _profile) async {

    await getStudents(_profile.getToken()).then((response) {

      if (response.statusCode == 200) {

        StudentsModel studentsModel = studModel.getStudentsFromJson(response.body);

        if (studentsModel.students.length > 0) {

          _students = studentsModel;

          return _students;
        } else {
          return null;
        }

      } else if (response.statusCode == 401) {
        print("AdminStudentsListPage: cod 401");
        _navigationService.navigateToAndRemove(routes.loginPageTag);
        return null;
      } else {
        print("AdminStudentsListPage: " + response.statusCode.toString());
        return null;
      }

    }).catchError((error) {
      print("AdminStudentsListPage: " + error);
      return null;
    });
  }

  DataTable _getStudentsTable() => DataTable(
      columns: [
        topRowCell("First Name", 16.0),
        topRowCell("Last Name", 16.0),
        topRowCell("Birth Date", 16.0),
        topRowCell("Description", 16.0)
      ],
      rows: [...buildRowsAdminStudentsList(_students.students, widget.profile)]
  );
}