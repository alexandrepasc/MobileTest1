import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:gsr_draft/model/ClassModel.dart';
import 'package:gsr_draft/model/ClassModel.dart' as clasModel;
import 'package:gsr_draft/model/StudentsModel.dart' as studModel;
import 'package:intl/intl.dart';

import '../common/AdminDrawerListEnum.dart';
import '../common/Constants.dart';
import '../common/Profile.dart';
import '../common/RolesEnum.dart';
import '../common/RoutePaths.dart' as routes;
import '../common/Student.dart';
import '../component/AdminDrawer.dart';
import '../component/AppBar.dart';
import '../component/BuildTable.dart';
import '../component/LoadingCircle.dart';
import '../Locator.dart';
import '../model/StudentsModel.dart';
import '../service/ClassService.dart';
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

  var _future;

  @override
  initState() {
    super.initState();

    _future = _apiGetClasses(widget.profile.getToken());

    _student = widget.profile.getStudent();
    contentData.setFirstName(_student.getFirstName());
    contentData.setLastName(_student.getLastName());
    contentData.setBirthDate(_student.getBirthDate());
    contentData.setDescription(_student.getDescription());
    contentData.setActiveClass(_student.getActiveClass().getName());
    contentData.setActiveClassId(_student.getActiveClass().getId());
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

    _getDatePicker() {
      DatePicker.showDatePicker(
          context,
          showTitleActions: true,
          minTime: DateTime(1800, 1, 1),
          maxTime: DateTime.now(),
          currentTime: _getDate(_student.getBirthDate()),
          locale: LocaleType.pt,
          onChanged: (date) {
            contentData.setBirthDate(date.millisecondsSinceEpoch);
          },
          onConfirm: (date) {
            birthDateController.text = new DateFormat('dd-MM-yyyy').format(new DateTime.fromMillisecondsSinceEpoch(contentData.getBirthDate()));
            setState(() {

            });
          }
      );
    }

    InputDecoration formDecorationBirthDate() => InputDecoration(
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
      suffixIcon: IconButton(
        icon: Icon(Icons.date_range),
        onPressed: () {
          if (!_readOnly) {
            _getDatePicker();
          }
        },
        color: appDarkRedColor,
      ),
    );

    birthDateController.text = new DateFormat('dd-MM-yyyy').format(new DateTime.fromMillisecondsSinceEpoch(contentData.getBirthDate()));
    TextFormField _getBirthDateInput() => TextFormField(
      controller: birthDateController,
      onChanged: (text) {
        contentData.setBirthDate(new DateFormat('dd-MM-yyyy').parse(text).millisecondsSinceEpoch);
      },
      keyboardType: TextInputType.text,
      maxLines: 1,
      readOnly: _readOnly,
      decoration: formDecorationBirthDate(),
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
      readOnly: true,
      decoration: formDecoration(),
    );

    DropdownButton _getActiveClassDrop(ClassesModel _classes) => DropdownButton<String>(
      items: _dropMenuList(_classes),
      onChanged: _readOnly ? null : (value) => setState(() => setActiveClass(value)),
      value: contentData.getActiveClassId(),
      isExpanded: true,
      hint: Text(contentData.getActiveClass()),
    );

    ListView _classDataContent() => ListView(
      children: <Widget>[
        SizedBox(height: bigRadius),
        _titleText("Active Class:"),
        SizedBox(height: smallHeight),
        //_getActiveClassInput(),
        _getActiveClassDrop(_classesModel),
        SizedBox(height: bigRadius),
        _getClassesHistory(),
      ],
    );

    Card _getClassData() => Card(
      child: new FutureBuilder(
          future: _future,
          builder: (context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                print("StudentDetailPage: none");
                return loadingCircle();
              case ConnectionState.waiting:
                print("StudentDetailPage: waiting");
                return loadingCircle();
              case ConnectionState.active:
                return Text("active");
              case ConnectionState.done:
                print("StudentDetailPage: yap1");
                return _classDataContent();
              default:
                if (snapshot.hasError) {
                  print("StudentDetailPage: error: ${snapshot.error}");
                  return Text("Error");
                }
                print("StudentDetailPage: nop");
                return loadingCircle();
            }
          },
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

  _getDate(int date) {
    if (date == null) {
      return DateTime.now();
    } else {
      //new DateFormat('dd-MM-yyyy').format()
      return new DateTime.fromMillisecondsSinceEpoch(_student.getBirthDate());
    }
  }

  List<DropdownMenuItem<String>> _dropMenuList(ClassesModel _classes) {

    List<DropdownMenuItem<String>> _list = new List();

    if (_classes.classes.length > 0) {
      _classes.classes.forEach((_class) {
        _list.add(
            DropdownMenuItem(
              value: _class.id,
              child: Text(_class.name),
            )
        );
      });
    } else {
      _list.add(
          DropdownMenuItem(
            value: "none",
            child: Text("No data"),
          )
      );
    }

    return _list;
  }



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

              loadingCircle();

              _apiUpdateStudent(widget.profile.getToken(), widget.profile.getStudent().getId(), contentData);

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
              contentData.setBirthDate(_student.getBirthDate());
              contentData.setDescription(_student.getDescription());
              contentData.setActiveClass(_student.getActiveClass().getName());
              contentData.setActiveClassId(_student.getActiveClass().getId());
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



  ClassesModel _classesModel;

  Future<ClassesModel> _apiGetClasses(String token) async {

    await getClasses(token).then((response) {
      if (response.statusCode == 200) {

        _classesModel = clasModel.getFromJson(response.body);

        return _classesModel;

      } else if (response.statusCode == 401) {
        print("StudentDetailPage: cod 401");
        _navigationService.navigateToAndRemove(routes.loginPageTag);
        return null;
      } else {
        print("StudentDetailPage: " + response.statusCode.toString());
        return null;
      }
    }).catchError((error) {
      print("StudentDetailPage: " + error);
      return null;
    });
  }

  Future _apiUpdateStudent(String token, String id, ContentData contentData) async {

    StudentUpdateModel put = new StudentUpdateModel(
      firstName: contentData.getFirstName(),
      lastName: contentData.getLastName(),
      birthDate: contentData.getBirthDate(),
      description: contentData.getDescription(),
      activeClass: new StudentActiveClassUpdateModel(id: contentData.getActiveClassId())
    );

    putStudent(token, id, put).then((response) {
      if (response.statusCode == 200) {

        print("student updated");

      } else if (response.statusCode == 401) {
        print("StudentDetailPage: cod 401");
        _navigationService.navigateToAndRemove(routes.loginPageTag);
        return null;
      } else {
        print("StudentDetailPage: " + response.statusCode.toString());
        return null;
      }
    }).catchError((error) {
      print("StudentDetailPage: " + error);
      return null;
    });
  }

  setActiveClass(String id) {

    _classesModel.classes.forEach((_class) {

      if (_class.id == id) {

        contentData.setActiveClass(_class.name);
        contentData.setActiveClassId(id);
      }
    });

  }
}

class ContentData {

  String _firstName;
  String _lastName;
  int _birthDate;
  String _description;
  String _activeClass;
  String _activeClassId;

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

  getActiveClassId() {
    return _activeClassId;
  }

  setActiveClassId(String _activeClassId) {
    this._activeClassId = _activeClassId;
  }
}