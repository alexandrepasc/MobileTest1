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

  int _currentIndex = 0;

  final List<Widget> _children = [
    PlaceholderWidget(Colors.white),
    PlaceholderWidget(Colors.deepOrange),
    PlaceholderWidget(Colors.green)
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: appWhiteColor,
      appBar: applicationBar(),
      drawer: adminDrawer(widget.profile, AdminDrawerListEnum.dashboard, context),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              decoration: _getDecoration(),
              //color: Color.fromRGBO(255, 0, 0, 80.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,  
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(width: bigRadius),
                      _setClassName(widget.profile.getSession().getClassName()),
                      SizedBox(width: bigRadius),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(height: bigRadius, width: bigRadius,),
                      _setLessonName(widget.profile.getSession().getName()),
                      SizedBox(width: bigRadius + bigRadius),
                      _setCoachName(widget.profile.getSession().getCoachId()),
                      SizedBox(width: bigRadius + bigRadius),
                      _setCoachName(new DateTime.fromMillisecondsSinceEpoch(widget.profile.getSession().getDate()).toString()),
                    ],
                  ),
                ],
              ),
            ),
            _children[_currentIndex]
          ],
        )
      ),
      bottomNavigationBar: _getBottomNavBar(),
    );
  }

  BoxDecoration _getDecoration() => BoxDecoration(
    border: Border.all(
      color: appDarkRedColor
    )
  );

  Text _setClassName(String _text) => Text(
    _text,
    style: TextStyle(
      color: appDarkRedColor,
      fontWeight: FontWeight.bold,
      fontSize: 40.0),
    textAlign: TextAlign.center,
  );

  Text _setLessonName(String _text) => Text(
    _text,
    style: TextStyle(
      color: appDarkRedColor,
      fontWeight: FontWeight.bold,
      fontSize: 30.0),
    textAlign: TextAlign.center,
  );

  Text _setCoachName(String _text) => Text(
    _text,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20.0
    ),
    textAlign: TextAlign.center,
  );

  BottomNavigationBar _setBottomNavBar() => BottomNavigationBar(
    currentIndex: _currentIndex,
    onTap: onTabTapped,
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.group),
        title: Text("Attendance"),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.chat),
        title: Text("Summary"),
      ),
    ],
  );

  Theme _getBottomNavBar() => Theme(
    data: Theme.of(context).copyWith(
      canvasColor: appDarkRedColor,
      primaryColor: appDarkGreyColor,
      textTheme: Theme.of(context).textTheme.copyWith(
        caption: TextStyle(color: appWhiteColor),
      ),
    ),
    child: _setBottomNavBar(),
  );

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Text("asdasdasd"),
    );
  }
}
