import 'package:flutter/material.dart';

import '../../common/Constants.dart';
import '../../common/Profile.dart';
import '../LoadingCircle.dart';

class CoachDetailProfileTab extends StatefulWidget {

  final Profile profile;

  CoachDetailProfileTab({Key key, this.profile}) : super(key: key);

  _CoachDetailProfileTab createState() => _CoachDetailProfileTab();
}

class _CoachDetailProfileTab extends State<CoachDetailProfileTab> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Card _getPersonalData() => Card(
        child: ListView(
            children: <Widget>[]
        )
    );

    OrientationBuilder _orientationBuilder() => OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
            crossAxisCount: orientation == Orientation.portrait ? 1 : 2,
            children: <Widget>[
            ],
          );
        }
    );

    return Container(
        child: Center(
          child: _orientationBuilder(),
        )
    );
  }
}