import 'dart:core';
import 'package:flutter/material.dart';

import 'package:gsr_draft/model/CoachesModel.dart' as coachesModel;

import '../../common/AdminDrawerListEnum.dart';
import '../../common/Coach.dart';
import '../../common/Constants.dart';
import '../../common/Profile.dart';
import '../../common/RoutePaths.dart' as routes;
import '../../component/AdminCoachesList.dart';
import '../../component/AdminDrawer.dart';
import '../../component/AppBar.dart';
import '../../model/CoachesModel.dart';
import '../../model/CoachModel.dart';
import '../../Locator.dart';
import '../../service/CoachesService.dart';
import '../../service/NavigationService.dart';

class AdminCoachesListPage extends StatefulWidget {
  final Profile profile;

  AdminCoachesListPage({Key key, this.profile}) : super(key: key);

  _AdminCoachesListPage createState() => _AdminCoachesListPage();
}

class _AdminCoachesListPage extends State<AdminCoachesListPage> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
    super.initState();
    //print(widget.profile.getToken());
    //data = loadData(widget.profile);
  }

  //Future<CoachesModelRes> data;

  List<DataRow> _buildRow(List<CoachModelRes> info) {

    List<DataRow> rows = new List();

    data2.coaches.forEach((coach) {
      rows.add(DataRow(cells: [
        dataRowCell(coach.username, coach),
        dataRowCell(coach.firstName, coach),
        dataRowCell(coach.lastName, coach),
        dataRowCell(coach.description, coach),
        dataRowCell(coach.notes, coach),
      ]));
    });

    return rows;
  }
  
  DataCell dataRowCell(String txt, CoachModelRes coach) => DataCell(
    Text(
      txt,
      style: TextStyle(
        fontSize: 17.0,
      ),
    ),
    onTap: () {
      _openCoachDetail(coach, widget.profile);
    }
  );

  _openCoachDetail(CoachModelRes coach, Profile profile) {

    Coach _coach = new Coach(
      coach.id,
      coach.firstName,
      coach.lastName,
      coach.description,
      coach.authId
    );

    Profile _profile = profile;
    _profile.setCoach(_coach);

    _navigationService.navigateTo(routes.coachDetailPageTag, arguments: _profile);
  }

  Widget coachesTable(CoachesModelRes info) => DataTable(
    columns: [
      topRowCell("User Name"),
      topRowCell("First Name"),
      topRowCell("Last Name"),
      topRowCell("Description"),
      topRowCell("Notes"),
    ],
    rows: [..._buildRow(info.coaches)],
  );

  DataColumn topRowCell(String txt) => DataColumn(
    label: Text(
      txt,
      style: TextStyle(
          color: Colors.redAccent,
          fontWeight: FontWeight.bold,
          fontSize: 16.0
      ),
    ),
  );

  Future<CoachesModelRes> loadData(Profile _profile) async {
    await getPost(_profile.getToken()).then((response) {
      if (response.statusCode == 200) {
        CoachesModelRes coaches = coachesModel.postFromJson(response.body);

        if (coaches.count > 0) {
          //print(coaches.count);
          //print(coaches.coaches[0].description);
          data2 = coaches;
          //data2 = null;
          return coaches;
        } else {
          data2 = null;
          return null;
        }
      } else {
        String code = response.statusCode.toString();
        data2 = null;
        return null;
      }
    }).catchError((error) {
      print(error.toString());
      data2 = null;
      return null;
    });
  }

  CoachesModelRes data2;

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: appWhiteColor,
      appBar: applicationBar(),
      drawer: adminDrawer(widget.profile, AdminDrawerListEnum.coaches, context),
      body: Center(
        child: Column(
          children: <Widget>[
            FutureBuilder<CoachesModelRes>(
              future: loadData(widget.profile),
              builder: (context, snapshot) {
                if (data2 != null) {
                  return coachesTable(data2);
                } else {
                  return ListTile(title: Text("No data"));
                }
              },
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,
        ),
      ),
    );
  }
}
