import 'package:flutter/material.dart';
import 'package:gsr_draft/model/StudentsModel.dart' as studModel;

import '../common/AdminDrawerListEnum.dart';
import '../common/Constants.dart';
import '../common/Profile.dart';
import '../component/AdminDrawer.dart';
import '../component/AppBar.dart';
import '../component/LoadingCircle.dart';
import '../Locator.dart';
import '../model/StudentsModel.dart';
import '../service/NavigationService.dart';
import '../service/StudentsService.dart';

class StudentDetailPage extends StatefulWidget {
  final Profile profile;

  StudentDetailPage({Key key, this.profile}) : super(key: key);

  _StudentDetailPage createState() => _StudentDetailPage();
}

class _StudentDetailPage extends State<StudentDetailPage> {
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
        drawer: adminDrawer(widget.profile, AdminDrawerListEnum.none, context),
        body: Center(
          child: _orientationBuilder(),
        ),
    );
  }

  OrientationBuilder _orientationBuilder() => OrientationBuilder(
      builder: (context, orientation) {
        return GridView.count(
          crossAxisCount: orientation == Orientation.portrait ? 1 : 2,
          children: <Widget>[
            _getCard1(),
          ],
        );
      }
  );

  Card _getCard1() => Card(
    child: ListView(
      children: <Widget>[
        logo
      ],
    ),
  );

  final logo = CircleAvatar(
    backgroundColor: Colors.transparent,
    radius: bigRadius,
    child: studentLogo,
  );
}