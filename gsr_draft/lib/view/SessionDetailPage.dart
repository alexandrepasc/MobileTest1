import 'package:flutter/material.dart';

import '../common/AdminDrawerListEnum.dart';
import '../common/Constants.dart';
import '../common/Profile.dart';
import '../common/Session.dart';
import '../component/AdminDrawer.dart';
import '../component/AppBar.dart';

class SessionDetailPage extends StatefulWidget {
  //final Profile profile;
  //final Session session;
  final List<Object> args;

  SessionDetailPage({Key key, this.args}) : super(key: key);

  _SessionDetailPage createState() => _SessionDetailPage();
}

class _SessionDetailPage extends State<SessionDetailPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: appWhiteColor,
      appBar: applicationBar(),
      drawer: adminDrawer(widget.args[0], AdminDrawerListEnum.dashboard, context),
      body: Center(
        child: ListView(
          children: <Widget>[
            //Text(
              //widget.args[1].getName()
            //),
          ],
        ),
      ),
    );
  }

}