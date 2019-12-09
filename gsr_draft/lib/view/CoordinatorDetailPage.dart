import 'package:flutter/material.dart';
import 'package:gsr_draft/common/Coordinator.dart';

import '../common/AdminDrawerListEnum.dart';
import '../common/Constants.dart';
import '../common/Profile.dart';
import '../common/RolesEnum.dart';
import '../common/RoutePaths.dart' as routes;
import '../component/AdminDrawer.dart';
import '../component/AppBar.dart';
import '../component/LoadingCircle.dart';
import '../Locator.dart';
import '../model/UserModelRes.dart';
import '../service/AuthService.dart';
import '../service/NavigationService.dart';

class CoordinatorDetailPage extends StatefulWidget {
  final Profile profile;

  CoordinatorDetailPage({Key key, this.profile}) : super(key: key);

  _CoordinatorDetailPage createState() => _CoordinatorDetailPage();
}

ContentData contentData = new ContentData();

class _CoordinatorDetailPage extends State<CoordinatorDetailPage> {
  final NavigationService _navigationService = locator<NavigationService>();

  Coordinator _coordinator;

  bool _readOnly = true;

  @override
  void initState() {
    super.initState();

    _coordinator = widget.profile.getCoordinator();

    contentData.setUsername(_coordinator.getUsername());
    contentData.setName(_coordinator.getName());
    contentData.setNotes(_coordinator.getNotes());
  }

  @override
  Widget build(BuildContext context) {

    var usernameController = TextEditingController();
    usernameController.text = contentData.getUsername();
    TextFormField _getUsernameInput() => TextFormField(
      controller: usernameController,
      onChanged: (text) {
        contentData.setUsername(text);
      },
      keyboardType: TextInputType.text,
      maxLines: 1,
      readOnly: _readOnly,
      decoration: formDecoration(),
    );

    var nameController = TextEditingController();
    nameController.text = contentData.getName();
    TextFormField _getNameInput() => TextFormField(
      controller: nameController,
      onChanged: (text) {
        contentData.setName(text);
      },
      keyboardType: TextInputType.text,
      maxLines: 1,
      readOnly: _readOnly,
      decoration: formDecoration(),
    );

    var notesController = TextEditingController();
    notesController.text = contentData.getNotes();
    TextFormField _getNotesInput() => TextFormField(
      controller: notesController,
      onChanged: (text) {
        contentData.setNotes(text);
      },
      keyboardType: TextInputType.text,
      maxLines: 1,
      readOnly: _readOnly,
      decoration: formDecoration(),
    );

    var roleController = TextEditingController();
    roleController.text = "Coordinator";
    TextFormField _getRoleInput() => TextFormField(
      controller: roleController,
      keyboardType: TextInputType.text,
      maxLines: 1,
      readOnly: true,
      decoration: formDecoration(),
    );

    return Scaffold(
        backgroundColor: appWhiteColor,
        appBar: applicationBar(),
        drawer: adminDrawer(widget.profile, AdminDrawerListEnum.none, context),
        body: Center(
            child: ListView(
              children: <Widget>[
                Center(
                  child: Container(
                    width: 350.0,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          logo,
                          SizedBox(height: mediumHeight),
                          _infoText("Username:"),
                          SizedBox(height: smallHeight),
                          _getUsernameInput(),
                          SizedBox(height: buttonHeight),
                          _infoText("Name:"),
                          SizedBox(height: smallHeight),
                          _getNameInput(),
                          SizedBox(height: buttonHeight),
                          _infoText("Notes:"),
                          SizedBox(height: smallHeight),
                          _getNotesInput(),
                          SizedBox(height: buttonHeight),
                          _infoText("Role:"),
                          SizedBox(height: smallHeight),
                          _getRoleInput(),
                          SizedBox(height: buttonHeight),
                        ]
                    ),
                  ),
                ),
                _checkPermissions()
              ],
            )
        )
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


  int _index = 0;

  setEdit(bool _notRead, int _show) {
    _readOnly = _notRead;
    _index = _show;

    setState(() {

    });
    print("setEdit");
  }

  _checkPermissions() {
    if (isAdmin(widget.profile.getRoles())) {
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

              _apiUpdateCoordinator(widget.profile.getToken(), widget.profile.getCoordinator().getId(), contentData);

              setEdit(true, 0);
            },
            heroTag: "save",
          ),
          FloatingActionButton(
            child: Icon(Icons.clear),
            backgroundColor: Colors.red,
            onPressed: () {
              contentData.setUsername(_coordinator.getUsername());
              contentData.setName(_coordinator.getName());
              contentData.setNotes(_coordinator.getNotes());
              setEdit(true, 0);
            },
            heroTag: "cancel",
          ),
        ],
      ),
    ],
  );


  Future _apiUpdateCoordinator(String token, String id, ContentData contentData) async {

    UserUpdateModel put = UserUpdateModel(
      username: contentData.getUsername(),
      name: contentData.getName(),
      notes: contentData.getNotes()
    );

    await putUser(token, id, put).then((response) {

      if (response.statusCode == 200) {

        print("coordinator updated");

      } else if (response.statusCode == 401) {
        print("StudentDetailPage: cod 401");
        _navigationService.navigateToAndRemove(routes.loginPageTag);
        return null;
      } else {
        print("CoordinatorDetailPage: " + response.statusCode.toString());
        return null;
      }
    }).catchError((error) {
      print("CoordinatorDetailPage: " + error);
      return null;
    });
  }


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

  String _username;
  String _name;
  String _notes;

  getUsername() {
    return _username;
  }

  setUsername(String _username) {
    this._username = _username;
  }

  getName() {
    return _name;
  }

  setName(String _name) {
    this._name = _name;
  }

  getNotes() {
    return  _notes;
  }

  setNotes(String _notes) {
    this._notes = _notes;
  }
}