import 'package:flutter/material.dart';

import '../common/Constants.dart';

DataColumn topRowCell(String txt, double size) => DataColumn(
  label: Text(
    txt,
    style: TextStyle(
        color: appDarkRedColor,
        fontWeight: FontWeight.bold,
        fontSize: size
    ),
    textAlign: TextAlign.center,
  ),
);

List<DataRow> buildRowsStudentsDetailClassHistory(List<String> _classHistory) {

  List<DataRow> rows = new List();

  _classHistory.forEach((_class) {
    rows.add(
        DataRow(
          cells: [
            _buildCellStudentsDetailClassHistory(_class),
          ],
        )
    );
  });

  return rows;
}

DataCell _buildCellStudentsDetailClassHistory(String txt) => DataCell(
    Text(
      txt,
      style: TextStyle(
        fontSize: 16.0,
      ),
    ),
);