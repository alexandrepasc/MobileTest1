import 'package:flutter/material.dart';
import 'package:gsr_draft/model/ClassModel.dart' as clasModel;
import 'package:gsr_draft/model/SessionsModel.dart' as sessModel;

import '../../common/Coach.dart';
import '../../common/Constants.dart';
import '../../common/Profile.dart';
import '../../common/RolesEnum.dart';
import '../../common/RoutePaths.dart' as routes;
import '../../component/LoadingCircle.dart';
import '../../Locator.dart';
import '../../model/ClassModel.dart';
import '../../model/SessionsModel.dart';
import '../../service/ClassService.dart';
import '../../service/NavigationService.dart';
import '../../service/SessionService.dart';

class CoachDetailProfileTab extends StatefulWidget {

  final Profile profile;

  CoachDetailProfileTab({Key key, this.profile}) : super(key: key);

  _CoachDetailProfileTab createState() => _CoachDetailProfileTab();
}

ContentData contentData = new ContentData();

class _CoachDetailProfileTab extends State<CoachDetailProfileTab> {
  final NavigationService _navigationService = locator<NavigationService>();

  Coach _coach;

  bool _readOnly = true;

  @override
  void initState() {
    super.initState();

    _coach = widget.profile.getCoach();

    contentData.setFirstName(_coach.getFirstName());
    contentData.setLastName(_coach.getLastName());
    contentData.setDescription(_coach.getDescription());
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

    var descriptionController = TextEditingController();
    descriptionController.text = contentData.getDescription();
    TextFormField _getDescriptionInput() => TextFormField(
      controller: descriptionController,
      onChanged: (text) {
        contentData.setDescription(text);
      },
      keyboardType: TextInputType.text,
      maxLines: 1,
      readOnly: _readOnly,
      decoration: formDecoration(),
    );

    Card _getPersonalData() => Card(
        child: ListView(
            //shrinkWrap: true,
            children: <Widget>[
              _getFirstNameInput(),
              _getLastNameInput(),
              _getDescriptionInput(),
              _checkPermissions()
            ]
        )
    );

    OrientationBuilder _orientationBuilder() => OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
            shrinkWrap: true,
            crossAxisCount: orientation == Orientation.portrait ? 1 : 2,
            children: <Widget>[
              _getPersonalData(),
            ],
          );
        }
    );

    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _orientationBuilder()
          ],
        )
    );
  }

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

              //_apiUpdateCoordinator(widget.profile.getToken(), widget.profile.getCoordinator().getId(), contentData);

              setEdit(true, 0);
            },
            heroTag: "save",
          ),
          FloatingActionButton(
            child: Icon(Icons.clear),
            backgroundColor: Colors.red,
            onPressed: () {
              contentData.setFirstName(_coach.getFirstName());
              contentData.setLastName(_coach.getLastName());
              contentData.setDescription(_coach.getDescription());
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

  Future _apiGetClasses(String token, String id) async {

    await getClassByCoach(token, id).then((response) {

      if (response.statusCode == 200) {

        _classesModel = clasModel.getFromJson(response.body);

        return _classesModel;

      } else if (response.statusCode == 401) {
        print("CoachDetailProfileTab: cod 401");
        _navigationService.navigateToAndRemove(routes.loginPageTag);
        return null;
      } else {
        print("CoachDetailProfileTab: " + response.statusCode.toString());
        return null;
      }

    }).catchError((error) {
      print("CoachDetailProfileTab: " + error);
      return null;
    });
  }

  SessionsModel _sessionsModel;

  Future _apiGetSessions(String token, String id) async {

    await getCoachSessions(token, id).then((response) {

      if (response.statusCode == 200) {

        _sessionsModel = sessModel.postFromJson(response.body);

        return _sessionsModel;

      } else if (response.statusCode == 401) {
        print("CoachDetailProfileTab: cod 401");
        _navigationService.navigateToAndRemove(routes.loginPageTag);
        return null;
      } else {
        print("CoachDetailProfileTab: " + response.statusCode.toString());
        return null;
      }

    }).catchError((error) {
      print("CoachDetailProfileTab: " + error);
      return null;
    });
  }
}

class ContentData {
  String _firstName;
  String _lastName;
  String _description;

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

  getDescription() {
    return _description;
  }

  setDescription(String _description) {
    this._description = _description;
  }
}