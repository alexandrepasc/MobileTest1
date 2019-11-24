import 'package:flutter/material.dart';
import 'package:gsr_draft/model/ClassModel.dart' as clModel;

import '../common/Profile.dart';
import '../common/RoutePaths.dart' as routes;
import '../Locator.dart';
import '../model/ClassModel.dart';
import '../service/ClassService.dart';
import '../service/NavigationService.dart';

class SessionDetailAttendanceTab extends StatefulWidget {
  final Profile profile;

  SessionDetailAttendanceTab({Key key, this.profile}) : super(key: key);

  _SessionDetailAttendanceTab createState() => _SessionDetailAttendanceTab();
}

class _SessionDetailAttendanceTab extends State<SessionDetailAttendanceTab> {
  final NavigationService _navigationService = locator<NavigationService>();

  List<String> studentsList;
  Map<String, bool> studentsMap = new Map();
  List<Students> studentsClass = new List();

  @override
  void initState() {
    _getClassStudents();
    super.initState();
  }

  Future _getClassStudents() async {
    //onLoading(context);

    getClass(widget.profile.getToken(), widget.profile.getSession().getClassId()).then((response) {
      if (response.statusCode == 200) {
        ClassModel classModel = clModel.postFromJson(response.body);

        print(classModel.students);

        classModel.students.forEach((student) {
          //studentsMap.putIfAbsent(student, () => false);
          studentsClass.add(new Students(student, false));
        });


        studentsList = classModel.students;

        setState(() {

        });

        //Navigator.pop(context);

      } else if (response.statusCode == 401) {
        print("cod 401");
        _navigationService.navigateToAndRemove(routes.loginPageTag);

      } else {
        print(response.statusCode);
        //Navigator.pop(context);
      }
    }).catchError((error) {
      print(error);
      //Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 700,
        child: new Column(
          children: _getStudentsList(),
        ),
      ),
    );
  }

  List<CheckboxListTile> _getStudentsList() {

    List<CheckboxListTile> list = new List();

    /*studentsList.forEach((student) {
      list.add(_getStudentTile(student, false, 1));
    });*/

    /*studentsMap.forEach((id, check) {
      list.add(_getStudentTile(id, check));
    });*/

    for (int i = 0; i < studentsClass.length; i++) {
      list.add(_getStudentTile(studentsClass[i]._id, studentsClass[i]._presence, i));
    }

    return list;
  }

  CheckboxListTile _getStudentTile(String id, bool check, int numb) => CheckboxListTile(
    title: Text(id),
    value: check,
    onChanged: (val) {
      studentsClass[numb].setPresence(val);
      print(studentsClass[numb].getPresence());
      setState(() {

      });
    },
  );
}

class Students {

  String _id;
  String _name;
  bool _presence;

  Students(this._id, this._presence);

  getId() {
    return _id;
  }

  setId(String _id) {
    this._id = _id;
  }

  getName() {
    return _name;
  }

  setName(String _name) {
    this._name = _name;
  }

  getPresence() {
    return _presence;
  }

  setPresence(bool _presence) {
    this._presence = _presence;
  }
}
