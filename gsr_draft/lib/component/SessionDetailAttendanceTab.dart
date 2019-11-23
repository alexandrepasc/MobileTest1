import 'package:flutter/material.dart';
import 'package:gsr_draft/model/ClassModel.dart' as clModel;

import '../common/Profile.dart';
import '../model/ClassModel.dart';
import '../service/ClassService.dart';

class SessionDetailAttendanceTab extends StatefulWidget {

  final Profile profile;

  SessionDetailAttendanceTab({Key key, this.profile}) : super(key: key);

  _SessionDetailAttendanceTab createState() => _SessionDetailAttendanceTab();
}

class _SessionDetailAttendanceTab extends State<SessionDetailAttendanceTab> {

  final List<String> studentsList = new List();

  @override
  void initState() {
    _getClassStudents();
    super.initState();
  }

  Future _getClassStudents() async {
    getClass(widget.profile.getToken(), widget.profile.getSession().getClassId()).then((response) {

      if (response.statusCode == 200) {
        ClassModel classModel = clModel.postFromJson(response.body);
        print(classModel.students);
      } else {
        print(response.statusCode);
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text("attendance");
  }
}