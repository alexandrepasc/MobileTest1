import 'package:flutter/material.dart';

import '../common/Class.dart';
import '../common/Constants.dart';
import '../common/Coordinator.dart';
import '../common/Profile.dart';
import '../common/RoutePaths.dart' as routes;
import '../common/Session.dart';
import '../common/Student.dart';
import '../Locator.dart';
import '../model/ClassModel.dart';
import '../model/SessionModel.dart';
import '../model/StudentsModel.dart';
import '../model/UserModelRes.dart';
import '../service/NavigationService.dart';

final NavigationService _navigationService = locator<NavigationService>();

DataColumn topRowCell(String txt, double size) => DataColumn(
  label: Text(
    txt,
    style: TextStyle(
        color: appDarkRedColor,
        fontWeight: FontWeight.bold,
        fontSize: size
    ),
    textAlign: TextAlign.center,
  ),
);



List<DataRow> buildRowsStudentsDetailClassHistory(List<String> _classHistory) {

  List<DataRow> rows = new List();

  _classHistory.forEach((_class) {
    rows.add(
        DataRow(
          cells: [
            _buildCellStudentsDetailClassHistory(_class),
          ],
        )
    );
  });

  return rows;
}

DataCell _buildCellStudentsDetailClassHistory(String txt) => DataCell(
    Text(
      txt,
      style: TextStyle(
        fontSize: 16.0,
      ),
    ),
);



List<DataRow> buildRowsAdminStudentsList(List<StudentModel> _students, Profile profile) {

  List<DataRow> rows = new List();

  _students.forEach((_student) {
    rows.add(
        DataRow(
          cells: [
            _buildCellAdminStudentsList(_student.firstName, _student, profile),
            _buildCellAdminStudentsList(_student.lastName, _student, profile),
            _buildCellAdminStudentsList(new DateTime.fromMillisecondsSinceEpoch(_student.birthDate).toString(), _student, profile),
            _buildCellAdminStudentsList(_student.description, _student, profile),
          ],
        )
    );
  });

  return rows;
}

DataCell _buildCellAdminStudentsList(String txt, StudentModel student, Profile profile) => DataCell(
  Text(
    txt,
    style: TextStyle(
      fontSize: 17.0,
    ),
  ),
  onTap: () {
    _openStudentDetail(student, profile);
  }
);

_openStudentDetail(StudentModel student, Profile profile) {

  Student _student = new Student(
      student.id,
      student.firstName,
      student.lastName,
      student.birthDate,
      student.description,
      new ActiveClass(student.activeClass.classId, student.activeClass.className),
      student.classes
  );

  Profile _profile = profile;
  _profile.setStudent(_student);

  _navigationService.navigateTo(routes.studentDetailPageTag, arguments: _profile);
}



List<DataRow> buildRowsAdminCoordinatorsList(List<UserModelRes> users, Profile profile) {

  List<DataRow> rows = new List();

  users.forEach((user) {
    rows.add(
      DataRow(
        cells: [
          _buildCellAdminCoordinatorsList(user.username, user, profile),
          _buildCellAdminCoordinatorsList(user.name, user, profile),
          _buildCellAdminCoordinatorsList(user.notes, user, profile)
        ]
      )
    );
  });

  return rows;
}

DataCell _buildCellAdminCoordinatorsList(String txt, UserModelRes user, Profile profile) => DataCell(
    Text(
      txt,
      style: TextStyle(
        fontSize: 17.0,
      ),
    ),
    onTap: () {
      _openCoordinatorDetail(user, profile);
    }
);

_openCoordinatorDetail(UserModelRes user, Profile profile) {

  Coordinator _coordinator = new Coordinator(
      user.id,
      user.username,
      user.name,
      user.notes,
      user.roles
  );

  Profile _profile = profile;
  _profile.setCoordinator(_coordinator);

  _navigationService.navigateTo(routes.coordinatorDetailPageTag, arguments: _profile);
}



List<DataRow> buildRowsCoachDetailClassesList(List<ClassModel> classes, Profile profile) {

  List<DataRow> rows = new List();

  classes.forEach((classModel) {
    rows.add(
        DataRow(
            cells: [
              _buildCellCoachDetailClassesList(classModel.name, classModel, profile),
              _buildCellCoachDetailClassesList(classModel.description, classModel, profile),
            ]
        )
    );
  });

  return rows;
}

DataCell _buildCellCoachDetailClassesList(String txt, ClassModel classModel, Profile profile) => DataCell(
    Text(
      txt,
      style: TextStyle(
        fontSize: 17.0,
      ),
    ),
    onTap: () {
      _openClassDetail(classModel, profile);
    }
);

_openClassDetail(ClassModel classModel, Profile profile) {

  Class _class = new Class(
      classModel.id,
      classModel.name,
      classModel.description,
      classModel.coachId,
      classModel.students
  );

  Profile _profile = profile;
  _profile.setClass(_class);

  _navigationService.navigateTo(routes.classDetailPageTag, arguments: _profile);
}



List<DataRow> buildRowsCoachDetailSessionsList(List<SessionModel> sessions, Profile profile) {

  List<DataRow> rows = new List();

  sessions.forEach((session) {
    rows.add(
        DataRow(
            cells: [
              _buildCellCoachDetailSessionsList(session.name, session, profile),
              _buildCellCoachDetailSessionsList(session.className, session, profile),
              _buildCellCoachDetailSessionsList(session.summary, session, profile),
            ]
        )
    );
  });

  return rows;
}

DataCell _buildCellCoachDetailSessionsList(String txt, SessionModel session, Profile profile) => DataCell(
    Text(
      txt,
      style: TextStyle(
        fontSize: 17.0,
      ),
    ),
    onTap: () {
      _openSessionDetail(session, profile);
    }
);

_openSessionDetail(SessionModel session, Profile profile) {

  Session _session = new Session(
      session.id,
      session.classId,
      session.coachId,
      session.name,
      session.summary,
      session.date,
      session.className
  );

  Profile _profile = profile;
  _profile.setSession(_session);

  _navigationService.navigateTo(routes.sessionDetailPageTag, arguments: _profile);
}