import 'package:flutter/material.dart';

import '../../common/Constants.dart';
import '../../common/Profile.dart';
import '../../common/RolesEnum.dart';
import '../../component/LoadingCircle.dart';
import '../../Locator.dart';
import '../../service/NavigationService.dart';

class ClassDetailHeader extends StatefulWidget {

  final Profile profile;

  ClassDetailHeader({Key key, this.profile}) : super(key: key);

  _ClassDetailHeader createState() => _ClassDetailHeader();
}

//ContentData contentData = new ContentData();

class _ClassDetailHeader extends State<ClassDetailHeader> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Card();
  }

  int _index = 0;
  bool _readOnly = true;

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

              //_apiUpdateCoach(widget.profile.getToken(), widget.profile.getCoach().getId(), contentData);

              setEdit(true, 0);
            },
            heroTag: "save",
          ),
          FloatingActionButton(
            child: Icon(Icons.clear),
            backgroundColor: Colors.red,
            /*onPressed: () {
              contentData.setFirstName(_coach.getFirstName());
              contentData.setLastName(_coach.getLastName());
              contentData.setDescription(_coach.getDescription());
              setEdit(true, 0);
            },*/
            heroTag: "cancel",
          ),
        ],
      ),
    ],
  );
}