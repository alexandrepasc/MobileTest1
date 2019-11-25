import 'package:flutter/material.dart';
import 'package:gsr_draft/model/ClassModel.dart' as clModel;
import 'package:gsr_draft/model/SessionsModel.dart' as seModel;

import '../common/Constants.dart';
import '../common/Profile.dart';
import '../common/RoutePaths.dart' as routes;
import 'LoadingCircle.dart';
import '../Locator.dart';
import '../model/ClassModel.dart';
import '../model/PresenceModel.dart';
import '../model/SessionModel.dart';
import '../model/SessionsModel.dart';
import '../service/ClassService.dart';
import '../service/NavigationService.dart';
import '../service/PresencesService.dart';
import '../service/SessionService.dart';

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
  List<SessionPresenceModel> presences;

  @override
  void initState() {
    super.initState();
    _getSessionStudents();
    print("init SessionDetailAttendanceTab");
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

  Future _getSessionStudents() async {

    getSessionPresences(widget.profile.getToken(), widget.profile.getSession().getId()).then((response) {

      if (response.statusCode == 200) {

        SessionPresencesModel sessionPresencesModel = seModel.getFromJson(response.body);

        presences = sessionPresencesModel.presences;
        print(presences.length);

        setState(() {

        });

      } else if (response.statusCode == 401) {
        print("cod 401");
        _navigationService.navigateToAndRemove(routes.loginPageTag);
      } else {
        print(response.statusCode);
      }
    }).catchError((error) {
      print(error);
    });
  }

  Future _postPresence() async {

    onLoading(context);

    presences.forEach((presence) {

      if (presence.presence) {

        if (presence.presenceId == null) {

          print("id null");

          PresenceAddModel presenceModel = new PresenceAddModel(
            sessionId: widget.profile.getSession().getId(),
            studentId: presence.studentId,
            classId: widget.profile.getSession().getClassId(),
            coachId: widget.profile.getCoachId(),
            date: DateTime
                .now()
                .millisecondsSinceEpoch,
          );

          postPresence(widget.profile.getToken(), presenceModel).then((
              response) {
            if (response.statusCode == 200) {
              print("ok");
              _getSessionStudents();
            } else if (response.statusCode == 401) {
              print("cod 401");
              _navigationService.navigateToAndRemove(routes.loginPageTag);
            } else {
              print(response.statusCode);
            }
          }).catchError((error) {
            print(error);
          });
        }
      } else {

        if (presence.presenceId != null) {

          print("id not null");

          deletePresence(widget.profile.getToken(), presence.presenceId).then((response) {
            if (response.statusCode == 200) {
              print("ok");
              _getSessionStudents();
            } else if (response.statusCode == 401) {
              print("cod 401");
              _navigationService.navigateToAndRemove(routes.loginPageTag);
            } else {
              print(response.statusCode);
            }
          }).catchError((error) {
            print(error);
          });
        }
      }
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 700,
        child: new Column(
          children: _getStudentsList(context),
        ),
      ),
    );
  }

  List<Widget> _getStudentsList(BuildContext context) {

    List<Widget> list = new List();

    /*studentsList.forEach((student) {
      list.add(_getStudentTile(student, false, 1));
    });*/

    /*studentsMap.forEach((id, check) {
      list.add(_getStudentTile(id, check));
    });*/

    /*for (int i = 0; i < studentsClass.length; i++) {
      list.add(_getStudentTile(studentsClass[i]._id, studentsClass[i]._presence, i));
    }*/

    for (int i =0; i < presences.length; i++) {
      list.add(_getStudentTile(presences[i].studentName, presences[i].presence, i));
    }

    list.add(SizedBox(height: buttonHeight));
    list.add(_getSaveButton(context));

    return list;
  }

  CheckboxListTile _getStudentTile(String name, bool check, int numb) => CheckboxListTile(
    title: Text(name),
    value: check,
    onChanged: (val) {
      presences[numb].presence = val;
      print(presences[numb].presence);
      setState(() {

      });
    },
  );

  Column _getSaveButton(BuildContext context) => Column(
    children: <Widget>[
      SizedBox(height: buttonHeight),
      Row(
        children: <Widget>[
          FloatingActionButton(
            child: Icon(Icons.check),
            backgroundColor: Colors.green,
            onPressed: () {
              _postPresence();
            }
          ),
          FloatingActionButton(
            child: Icon(Icons.clear),
            backgroundColor: Colors.red,
            onPressed: () {
              onLoading(context);
              _getSessionStudents();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ],
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
