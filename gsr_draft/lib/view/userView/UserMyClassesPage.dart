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

    return Scaffold(
      backgroundColor: appWhiteColor,
      appBar: applicationBar(),
      drawer: adminDrawer(widget.profile, AdminDrawerListEnum.myclasses, context),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new FutureBuilder<ClassesModel>(
                future: _getClasses(widget.profile),
                initialData: new ClassesModel(),
                builder: (context, AsyncSnapshot<ClassesModel> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      print("none");
                      //return Text("none");
                      return loadingCircle();
                    case ConnectionState.waiting:
                      print("waiting");
                      return loadingCircle();
                    case ConnectionState.active:
                      return Text("active");
                    case ConnectionState.done:
                      print("yap1");
                      //print(snapshot.data.classes.length);
                      //String a = snapshot.data;
                      //print(sessions.sessions[0].name);
                      //sessions = snapshot.data;
                      //return Text(snapshot.data.toString());
                      return _getClassesTable();
                    default:
                      if (snapshot.hasError) {
                        print("error: ${snapshot.error}");
                        return Text("Error");
                      }
                      print("nop");
                      return loadingCircle();
                  }
                }
            )
          ],
        ),
      ),
    );
  }

  ClassesModel classesModel;

  Future<ClassesModel> _getClasses(Profile profile) async {

    await getClassByCoach(profile.getToken(), profile.getCoachId()).then((response) async {

      if (response.statusCode == 200) {

        ClassesModel classes = clasModel.getFromJson(response.body);

        if (classes.classes.length > 0) {

          classesModel = classes;

          return classesModel;
        } else {
          return null;
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

  Widget _getClassesTable() => DataTable(
    columns: [
      topRowCell("Name"),
      topRowCell("Description"),
      topRowCell("Students #"),
    ],
    rows: [..._buildRow()],
  );

  DataColumn topRowCell(String txt) => DataColumn(
    label: Text(
      txt,
      style: TextStyle(
          color: Colors.redAccent,
          fontWeight: FontWeight.bold,
          fontSize: 16.0
      ),
    ),
  );

  List<DataRow> _buildRow() {

    List<DataRow> rows = new List();

    classesModel.classes.forEach((_class) {
      rows.add(
          DataRow(
            cells: [
              dataRowCell(_class.name, _class),
              dataRowCell(_class.description, _class),
              dataRowCell(_class.students.length.toString(), _class),
            ],
          )
      );
    });

    return rows;
  }

  DataCell dataRowCell(String txt, ClassModel _class) => DataCell(
      Text(
        txt,
        style: TextStyle(
          fontSize: 17.0,
        ),
      ),
      onTap: () {
        //_openSessionDetail(sessionModel);
      }
  );

  /*_openClassDetail(ClassModel _class) {
    if (sessionModel != null) {
      Session session = new Session(
          sessionModel.id,
          sessionModel.classId,
          sessionModel.coachId,
          sessionModel.name,
          sessionModel.summary,
          sessionModel.date,
          sessionModel.className
      );

      Profile profile = widget.profile;
      profile.setSession(session);

      _navigationService.navigateTo(routes.sessionDetailPageTag, arguments: profile);
    }
  }*/
}