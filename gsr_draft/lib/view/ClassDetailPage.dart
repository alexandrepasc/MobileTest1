import 'package:flutter/material.dart';

import '../common/AdminDrawerListEnum.dart';
import '../common/Constants.dart';
import '../common/Profile.dart';
import '../common/RoutePaths.dart' as routes;
import '../component/AdminDrawer.dart';
import '../component/AppBar.dart';
import '../component/LoadingCircle.dart';
import '../Locator.dart';
import '../service/NavigationService.dart';

class ClassDetailPage extends StatefulWidget {
  final Profile profile;

  ClassDetailPage({Key key, this.profile}) : super(key: key);

  _ClassDetailPage createState() => _ClassDetailPage();
}

class _ClassDetailPage extends State<ClassDetailPage> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: appWhiteColor,
        appBar: applicationBar(),
        drawer: adminDrawer(widget.profile, AdminDrawerListEnum.none, context),
        body: _orientationBuilder(),
    );
  }

  OrientationBuilder _orientationBuilder() => OrientationBuilder(
      builder: (context, orientation) {
        return GridView.count(
          crossAxisCount: orientation == Orientation.portrait ? 1 : 2,
          children: <Widget>[
            _getHeader(),
            _getStudents(),
          ],
        );
      }
  );

  Card _getHeader() => Card(
    child: ListView(
      children: <Widget>[
        Text(widget.profile.getClass().getName()),
        Text(widget.profile.getClass().getDescription()),
      ],
    ),
  );

  Card _getStudents() => Card(
    child: ListView(
      children: _getStudentsTxt(),
    ),
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
}