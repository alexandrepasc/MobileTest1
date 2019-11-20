import 'package:flutter/material.dart';

import '../common/AdminDrawerListEnum.dart';
import '../common/Constants.dart';
import '../common/Profile.dart';
import '../component/AdminDrawer.dart';
import '../component/AppBar.dart';

class SessionDetailPage extends StatefulWidget {
  final Profile profile;

  SessionDetailPage({Key key, this.profile}) : super(key: key);

  _SessionDetailPage createState() => _SessionDetailPage();
}

class _SessionDetailPage extends State<SessionDetailPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: appWhiteColor,
      appBar: applicationBar(),
      drawer: adminDrawer(widget.profile, AdminDrawerListEnum.dashboard, context),
      body: Center(
        child: Container(
          child: Row(
            children: <Widget>[
              _setClassName(widget.profile.getSession().getClassName()),
              SizedBox(width: bigRadius,),
              _setClassName(widget.profile.getSession().getClassName()),
            ],
          ),
        ),
      ),
    );
  }

  Text _setClassName(String _text) => Text(
    _text,
    style: TextStyle(
      color: appDarkRedColor,
      fontWeight: FontWeight.bold,
      fontSize: 40.0),
    textAlign: TextAlign.center,
  );
}