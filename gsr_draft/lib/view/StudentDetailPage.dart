import 'package:flutter/material.dart';
import 'package:gsr_draft/model/StudentsModel.dart' as studModel;

import '../common/AdminDrawerListEnum.dart';
import '../common/Constants.dart';
import '../common/Profile.dart';
import '../common/RolesEnum.dart';
import '../common/Student.dart';
import '../component/AdminDrawer.dart';
import '../component/AppBar.dart';
import '../component/BuildTable.dart';
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

    var descriptionController = TextEditingController();
    descriptionController.text = _student.getDescription();
    TextField _getDescription() => TextField(
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      controller: descriptionController,
      readOnly: _readOnly,
      decoration: formDecoration(),
    );

    Card _getPersonalData() => Card(
      child: ListView(
        children: <Widget>[
          logo,
          SizedBox(height: mediumHeight),
          _infoText("First Name:"),
          SizedBox(height: smallHeight),
          _getFirstNameInput(),
          SizedBox(height: buttonHeight),
          _infoText("Last Name:"),
          SizedBox(height: smallHeight),
          _getLastNameInput(),
          SizedBox(height: buttonHeight),
          _infoText("Birth Date:"),
          SizedBox(height: smallHeight),
          _getBirthDateInput(),
          SizedBox(height: buttonHeight),
          _infoText("Description:"),
          SizedBox(height: smallHeight),
          _getDescription(),
        ],
      ),
    );



    var activeClassController = TextEditingController();
    activeClassController.text = _student.getActiveClass();
    TextFormField _getActiveClassInput() => TextFormField(
      controller: activeClassController,
      keyboardType: TextInputType.text,
      maxLines: 1,
      readOnly: _readOnly,
      decoration: formDecoration(),
    );

    Card _getClassData() => Card(
      child: ListView(
        children: <Widget>[
          SizedBox(height: bigRadius),
          _titleText("Active Class:"),
          SizedBox(height: smallHeight),
          _getActiveClassInput(),
          SizedBox(height: bigRadius),
          _getClassesHistory(),
        ],
      ),
    );

    OrientationBuilder _orientationBuilder() => OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
            crossAxisCount: orientation == Orientation.portrait ? 1 : 2,
            children: <Widget>[
              _getPersonalData(),
              _getClassData(),
              _getButtons(),
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

  Text _titleText(String txt) => Text(
    txt,
    style: TextStyle(
        color: appDarkRedColor,
        fontWeight: FontWeight.bold,
        fontSize: 20.0),
    textAlign: TextAlign.left,
  );

  DataTable _getClassesHistory() => DataTable(
    columns: [
      topRowCell("Classes History:", 20.0),
    ],
    rows: [...buildRowsStudentsDetailClassHistory(_student.getClasses())],
  );

  _getButtons() {
    if (hasCoordinator(widget.profile.getRoles())) {
      return _getEditButton();
    } else {
      return SizedBox(height: buttonHeight);
    }
  }

  Column _getEditButton() => Column(
    children: <Widget>[
      SizedBox(height: buttonHeight),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FloatingActionButton(
            child: Icon(Icons.edit),
            backgroundColor: appDarkRedColor,
            /*onPressed: () {
              setEdit(false, 1);
            },*/
            heroTag: "edit",
          ),
        ],
      ),
    ],
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