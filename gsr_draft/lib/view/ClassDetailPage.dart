import 'package:flutter/material.dart';
import 'package:gsr_draft/model/SessionsModel.dart' as sessModel;
import 'package:gsr_draft/model/StudentsModel.dart' as studModel;

import '../common/AdminDrawerListEnum.dart';
import '../common/Constants.dart';
import '../common/Profile.dart';
import '../common/RoutePaths.dart' as routes;
import '../component/AdminDrawer.dart';
import '../component/AppBar.dart';
import '../component/LoadingCircle.dart';
import '../Locator.dart';
import '../model/SessionsModel.dart';
import '../model/StudentsModel.dart';
import '../service/NavigationService.dart';
import '../service/SessionService.dart';
import '../service/StudentsService.dart';

class ClassDetailPage extends StatefulWidget {
  final Profile profile;

  ClassDetailPage({Key key, this.profile}) : super(key: key);

  _ClassDetailPage createState() => _ClassDetailPage();
}

class _ClassDetailPage extends State<ClassDetailPage> {
  final NavigationService _navigationService = locator<NavigationService>();

  var _future;
  @override
  initState() {
    super.initState();
    _future = _getData(widget.profile);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: appWhiteColor,
        appBar: applicationBar(),
        drawer: adminDrawer(widget.profile, AdminDrawerListEnum.none, context),
        body: Center(
          child:
              new FutureBuilder(
                future: _future,
                //initialData: new SessionsModel(),
                builder: (context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      print("ClassDetailPage: none");
                      return loadingCircle();
                    case ConnectionState.waiting:
                      print("ClassDetailPage: waiting");
                      return loadingCircle();
                    case ConnectionState.active:
                      return Text("active");
                    case ConnectionState.done:
                      print("ClassDetailPage: yap1");
                      return _orientationBuilder();
                    default:
                      if (snapshot.hasError) {
                        print("UserMyClassesPage: error: ${snapshot.error}");
                        return Text("Error");
                      }
                      print("ClassDetailPage: nop");
                      return loadingCircle();
                  }
                }
          ),
        ),
    );
  }

  Future _getData(Profile _profile) async {

    await _getStudents(_profile);

    await _getSessions(_profile);
  }

  SessionsModel _sessionsModel;

  Future<SessionsModel> _getSessions(Profile _profile) async {

    await getSessionsByClass(_profile.getToken(), _profile.getClass().getId())
        .then((response) {

      if (response.statusCode == 200) {

        SessionsModel sessionsModel = sessModel.postFromJson(response.body);

        _sessionsModel = sessionsModel;

        return _sessionsModel;

      } else if (response.statusCode == 401) {
        print("ClassDetailPage: cod 401");
        _navigationService.navigateToAndRemove(routes.loginPageTag);
        return null;
      } else {
        print("ClassDetailPage: " + response.statusCode.toString());
        return null;
      }
    }).catchError((error) {
      print("ClassDetailPage: " + error);
      return null;
    });
  }

  OrientationBuilder _orientationBuilder() => OrientationBuilder(
      builder: (context, orientation) {
        return GridView.count(
          crossAxisCount: orientation == Orientation.portrait ? 1 : 2,
          children: <Widget>[
            _getHeader(),
            _getStudentsCard(),
          ],
        );
      }
  );

  Card _getHeader() => Card(
    child: ListView(
      shrinkWrap: true,
      children: <Widget>[
        _getClassDetail(),
        _getSessionsContainer(),
      ],
    ),
  );

  Container _getClassDetail() => Container(
    height: 200.0,
    child: ListView(
      children: <Widget>[
        SizedBox(height: buttonHeight),
        Text(
          widget.profile.getClass().getName(),
          style: TextStyle(
            color: appDarkRedColor,
            fontWeight: FontWeight.bold,
            fontSize: 40.0),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: bigRadius),
        Text(
          widget.profile.getClass().getDescription(),
          style: TextStyle(
            //color: appDarkRedColor,
            //fontWeight: FontWeight.bold,
            fontSize: 20.0),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );

  Container _getSessionsContainer() => Container(
    height: 300.0,
    child: _getSessionsTable(),
  );
  
  DataTable _getSessionsTable() => DataTable(
      columns: [
        topRowCell("Name", 16.0),
        topRowCell("Summary", 16.0),
        topRowCell("Date", 16.0),
      ], 
      rows: [..._buildSessionsRow(_sessionsModel)],
  );

  List<DataRow> _buildSessionsRow(var _model) {

    List<DataRow> rows = new List();

    _model.sessions.forEach((session) {
      rows.add(
          DataRow(
            cells: [
              dataRowCell(session.name, session),
              dataRowCell(session.summary, session),
              dataRowCell(new DateTime.fromMillisecondsSinceEpoch(session.date).toString(), session),
            ],
          )
      );
    });

    return rows;
  }

  DataCell dataRowCell(String txt, var _class) => DataCell(
      Text(
        txt,
        style: TextStyle(
          fontSize: 17.0,
        ),
      ),
      /*onTap: () {
        _openClassDetail(_class);
      }*/
  );

  Card _getStudentsCard() => Card(
    child: new FutureBuilder(
      future: _future,
      //initialData: new SessionsModel(),
      builder: (context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            print("ClassDetailPage: none");
            return loadingCircle();
          case ConnectionState.waiting:
            print("ClassDetailPage: waiting");
            return loadingCircle();
          case ConnectionState.active:
            return Text("active");
          case ConnectionState.done:
            print("ClassDetailPage: yap1");
            return _getStudentsTable();
          default:
            if (snapshot.hasError) {
              print("UserMyClassesPage: error: ${snapshot.error}");
              return Text("Error");
            }
            print("ClassDetailPage: nop");
            return loadingCircle();
        }
      },
    )
  );

  List<Text> _getStudentsTxt() {

    List<String> students = widget.profile.getClass().getStudents();
    List<Text> txt = List();

    students.forEach((student) {
      print(students[0]);
      txt.add(
        _txt(student)
      );
    });

    return txt;
  }
  
  Text _txt(String data) => Text(data);

  List<StudentModel> _students;

  Future<List<StudentModel>> _getStudents(Profile _profile) async {

    List<String> _studentsId = _profile.getClass().getStudents();

    List<StudentModel> _studentsModel = new List();

    _studentsId.forEach((_student) async {

      await getStudent(_profile.getToken(), _student).then((response) {

        if (response.statusCode == 200) {

          StudentModel _model = studModel.getFromJson(response.body);

          _studentsModel.add(_model);

        } else if (response.statusCode == 401) {
          print("ClassDetailPage: cod 401");
          _navigationService.navigateToAndRemove(routes.loginPageTag);
          return null;
        } else {
          print("ClassDetailPage: " + response.statusCode.toString());
          return null;
        }
      }).catchError((error) {
        print("ClassDetailPage: " + error);
        return null;
      });
    });

    _students = _studentsModel;

    return _students;
  }

  DataTable _getStudentsTable() => DataTable(
      columns: [
        topRowCell("First Name", 12.0),
        topRowCell("Last Name", 12.0),
        topRowCell("Birth Date", 12.0),
        topRowCell("Description", 12.0)
      ],
      rows: [..._buildStudentsRow(_students)]
  );

  List<DataRow> _buildStudentsRow(List<StudentModel> _studentsModel) {

    List<DataRow> rows = new List();

    _studentsModel.forEach((student) {
      rows.add(
        DataRow(
          cells: [
            studentsDataRowCell(student.firstName, student),
            studentsDataRowCell(student.lastName, student),
            studentsDataRowCell(new DateTime.fromMillisecondsSinceEpoch(student.birthDate).toString(), student),
            studentsDataRowCell(student.description, student)
          ],
        )
      );
    });

    return rows;
  }

  DataCell studentsDataRowCell(String txt, StudentModel studentModel) => DataCell(
    Text(
      txt,
      style: TextStyle(
        fontSize: 16.0,
      ),
    ),
    /*onTap: () {
        _openClassDetail(_class);
      }*/
  );

  DataColumn topRowCell(String txt, double size) => DataColumn(
    label: Text(
      txt,
      style: TextStyle(
          color: Colors.redAccent,
          fontWeight: FontWeight.bold,
          fontSize: size
      ),
      textAlign: TextAlign.center,
    ),
  );
}