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

ContentData contentData = new ContentData();

class _StudentDetailPage extends State<StudentDetailPage> {
  final NavigationService _navigationService = locator<NavigationService>();

  Student _student;

  bool _readOnly = true;

  @override
  initState() {
    super.initState();
    _student = widget.profile.getStudent();
    contentData.setFirstName(_student.getFirstName());
    contentData.setLastName(_student.getLastName());

    contentData.setDescription(_student.getDescription());
    contentData.setActiveClass(_student.getActiveClass());
  }

  @override
  Widget build(BuildContext context) {

    var firstNameController = TextEditingController();
    firstNameController.text = contentData.getFirstName();
    TextFormField _getFirstNameInput() => TextFormField(
      controller: firstNameController,
      onChanged: (text) {
        contentData.setFirstName(text);
      },
      keyboardType: TextInputType.text,
      maxLines: 1,
      readOnly: _readOnly,
      decoration: formDecoration(),
    );

    var lastNameController = TextEditingController();
    lastNameController.text = contentData.getLastName();
    TextFormField _getLastNameInput() => TextFormField(
      controller: lastNameController,
      onChanged: (text) {
        contentData.setLastName(text);
      },
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
    descriptionController.text = contentData.getDescription();
    TextField _getDescription() => TextField(
      onChanged: (text) {
        contentData.setDescription(text);
      },
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
    activeClassController.text = contentData.getActiveClass();
    TextFormField _getActiveClassInput() => TextFormField(
      controller: activeClassController,
      onChanged: (text) {
        contentData.setActiveClass(text);
      },
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
              _checkPermissions(),
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



  int _index = 0;

  setEdit(bool _notRead, int _show) {
    _readOnly = _notRead;
    _index = _show;

    setState(() {

    });
    print("setEdit");
  }

  _checkPermissions() {
    if (hasCoordinator(widget.profile.getRoles())) {
      return _getButtons();
    } else {
      return SizedBox(height: buttonHeight);
    }
  }

  _getButtons() {
    switch (_index) {
      case 0:
        return _getEditButton();
      case 1:
        return _getSaveCancelButton();
      default:
        return null;
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
            onPressed: () {
              setEdit(false, 1);
            },
            heroTag: "edit",
          ),
        ],
      ),
    ],
  );

  Column _getSaveCancelButton() => Column(
    children: <Widget>[
      SizedBox(height: buttonHeight),
      Row(
        children: <Widget>[
          FloatingActionButton(
            child: Icon(Icons.check),
            backgroundColor: Colors.green,
            onPressed: () {
              //print(_summaryController.text);
              //summaryData.set(_summaryController.text);
              //_callApi(widget.profile.getToken(), widget.profile.getSession().getId(), summaryData.get(), context);
              setEdit(true, 0);
            },
            heroTag: "save",
          ),
          FloatingActionButton(
            child: Icon(Icons.clear),
            backgroundColor: Colors.red,
            onPressed: () {
              contentData.setFirstName(_student.getFirstName());
              contentData.setLastName(_student.getLastName());

              contentData.setDescription(_student.getDescription());
              contentData.setActiveClass(_student.getActiveClass());
              setEdit(true, 0);
            },
            heroTag: "cancel",
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

class ContentData {

  String _firstName;
  String _lastName;
  int _birthDate;
  String _description;
  String _activeClass;

  getFirstName() {
    return _firstName;
  }

  setFirstName(String _firstName) {
    this._firstName = _firstName;
  }

  getLastName() {
    return _lastName;
  }

  setLastName(String _lastName) {
    this._lastName = _lastName;
  }

  getBirthDate() {
    return _birthDate;
  }

  setBirthDate(int _birthDate) {
    this._birthDate = _birthDate;
  }

  getDescription() {
    return _description;
  }

  setDescription(String _description) {
    this._description = _description;
  }

  getActiveClass() {
    return _activeClass;
  }

  setActiveClass(String _activeClass) {
    this._activeClass = _activeClass;
  }
}