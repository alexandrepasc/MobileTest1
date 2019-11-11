import 'dart:core';
import 'package:flutter/material.dart';

import '../../common/AdminDrawerListEnum.dart';
import '../../common/Constants.dart';
import '../../common/Profile.dart';
import '../../component/AdminDrawer.dart';
import '../../component/AppBar.dart';
import '../../Locator.dart';
import '../../service/NavigationService.dart';

class AdminCoachesListPage extends StatelessWidget {

  final NavigationService _navigationService = locator<NavigationService>();

  final Profile profile;

  AdminCoachesListPage({Key key, this.profile}) : super(key: key);

  void _onLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new Container(
          decoration: new BoxDecoration(
              color: Colors.transparent,
              borderRadius: new BorderRadius.circular(10.0)
          ),
          width: 150.0,
          height: 200.0,
          alignment: AlignmentDirectional.center,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Center(
                child: new SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: new CircularProgressIndicator(
                    value: null,
                    strokeWidth: 7.0,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  final table = DataTable(columns: null, rows: null);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: appWhiteColor,
      appBar: applicationBar(),
      drawer: adminDrawer(profile, AdminDrawerListEnum.coaches, context),
      body: Center(),
    );
  }
}