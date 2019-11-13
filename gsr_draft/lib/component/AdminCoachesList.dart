import 'package:flutter/material.dart';

import 'package:gsr_draft/model/CoachesModel.dart' as coachesModel;

import '../common/Profile.dart';
import '../model/CoachesModel.dart';
import '../model/CoachModel.dart';
import '../service/CoachesService.dart';

/*Widget coachesTable(Profile _profile) => DataTable(
      columns: [
        DataColumn(label: Text("User Name")),
        DataColumn(label: Text("First Name")),
        DataColumn(label: Text("Last Name")),
        DataColumn(label: Text("Description")),
        DataColumn(label: Text("Notes")),
      ],
      rows: [..._buildRows(_profile)],
    );*/

Widget _noData(String text) => ListTile(
      title: Text(text),
    );

/*Future<List<coachesModel.CoachesModelRes>> loadData(Profile _profile) async {
  await getPost(_profile.getToken()).then((response) async {
    if (response.statusCode == 200) {
      CoachesModelRes coaches = coachesModel.postFromJson(response.body);

      if (coaches.count > 0) {
        print(coaches.count);
        print(coaches.coaches[0].description);
        return coaches;
      } else {
        return null;
      }
    } else {
      String code = response.statusCode.toString();
      return null;
    }
  }).catchError((error) {
    print(error.toString());
    return null;
  });
}*/

/*List<CoachModelRes> _setList(Profile _profile) {

 _loadData(_profile).then((_data) async {
    print(_data[0].description);
    return _data;
  }).catchError((error) {
    print(error);
  });
}*/

/*List<DataRow> _buildRows(Profile _profile) {
  loadData(_profile).then((coaches) {
    //print(coaches[0].description);

    //List<CoachModelRes> coaches = _loadData(_profile);
    //List<CoachModelRes> coaches = _setList(_profile);
    List<DataRow> rows = new List();

    //print(coaches);

    coaches.forEach((coach) {
      //print(coach.description);
      rows.add(DataRow(cells: [
        DataCell(Text(coach.username)),
        DataCell(Text(coach.firstName)),
        DataCell(Text(coach.lastName)),
        DataCell(Text(coach.description)),
        DataCell(Text(coach.notes)),
      ]));
    });

    return rows;
  });
}*/
