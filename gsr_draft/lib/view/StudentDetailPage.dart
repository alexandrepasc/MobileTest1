import 'package:flutter/material.dart';
import 'package:gsr_draft/model/StudentsModel.dart' as studModel;

import '../common/AdminDrawerListEnum.dart';
import '../common/Constants.dart';
import '../common/Profile.dart';
import '../common/Student.dart';
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

  Student _student;

  bool _readOnly = true;

  @override
  initState() {
    super.initState();
    _student = widget.profile.getStudent();
  }

  @override
  Widget build(BuildContext context) {

    var firstNameController = TextEditingController();
    firstNameController.text = _student.getFirstName();
    TextFormField _getFirstNameInput() => TextFormField(
      controller: firstNameController,
      keyboardType: TextInputType.text,
      maxLines: 1,
      readOnly: _readOnly,
      decoration: formDecoration(),
    );

    var lastNameController = TextEditingController();
    lastNameController.text = _student.getLastName();
    TextFormField _getLastNameInput() => TextFormField(
      controller: lastNameController,
      keyboardType: TextInputType.text,
      maxLines: 1,
      readOnly: _readOnly,
      decoration: formDecoration(),
    );

    var birthDateController = TextEditingController();
    birthDateController.text = new DateTime.fromMillisecondsSinceEpoch(_student.getBirthDate()).toString();
    TextFormField _getBirthDateInput() => TextFormField(
      controller: birthDateController,
      keyboardType: TextInputType.text,
      maxLines: 1,
      readOnly: _readOnly,
      decoration: formDecoration(),
    );

    Card _getCard1() => Card(
      child: ListView(
        children: <Widget>[
          logo,
          SizedBox(height: bigRadius),
          _infoText("First Name:"),
          _getFirstNameInput(),
          SizedBox(height: buttonHeight),
          _infoText("Last Name:"),
          _getLastNameInput(),
          SizedBox(height: buttonHeight),
          _infoText("Birth Date:"),
          _getBirthDateInput(),
        ],
      ),
    );

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

    return Scaffold(
        backgroundColor: appWhiteColor,
        appBar: applicationBar(),
        drawer: adminDrawer(widget.profile, AdminDrawerListEnum.none, context),
        body: Center(
          child: _orientationBuilder(),
        ),
    );
  }

  final logo = CircleAvatar(
    backgroundColor: Colors.transparent,
    radius: bigRadius,
    child: studentLogo,
  );

  Text _infoText(String txt) => Text(
    txt,
    style: TextStyle(
        color: appDarkRedColor,
        fontWeight: FontWeight.bold,
        fontSize: 16.0),
    textAlign: TextAlign.left,
  );

  InputDecoration formDecoration() => InputDecoration(
    hintText: userNameHintText,
    hintStyle: TextStyle(color: Colors.black38),
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.0),
      borderSide: BorderSide(color: appDarkRedColor, width: 3.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.0),
      borderSide: BorderSide(color: appDarkRedColor, width: 3.0),
    ),
  );
}