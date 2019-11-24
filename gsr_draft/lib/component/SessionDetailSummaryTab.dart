import 'package:flutter/material.dart';

import '../common/Constants.dart';
import '../common/Profile.dart';
import 'LoadingCircle.dart';
import '../model/SessionModel.dart';
import '../service/SessionService.dart';

class SessionDetailSummaryTab extends StatefulWidget {

  final String summary;
  final Profile profile;

  //SessionDetailSummaryTab(this._summary);

  SessionDetailSummaryTab({Key key, this.summary, this.profile}) : super(key: key);

  _SessionDetailSummaryTab createState() => _SessionDetailSummaryTab();
}

SummaryData summaryData = new SummaryData();

class _SessionDetailSummaryTab extends State<SessionDetailSummaryTab> {

  bool _readOnly = true;

  @override
  void initState() {
    summaryData.set(widget.summary);
    print("init SessionDetailSummaryTab");
    print(widget.profile.getCoachFirstName());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final _summaryController = TextEditingController();
    _summaryController.text = summaryData.get();

    setEdit(bool _notRead, int _show) {
      _readOnly = _notRead;
      _index = _show;

      setState(() {

      });
      print("setEdit");
    }

    TextField _getTextField() => TextField(
      keyboardType: TextInputType.multiline,
      maxLines: 20,
      controller: _summaryController,
      readOnly: _readOnly,
      onChanged: (text) {
        print(_summaryController.text);
        summaryData.set(_summaryController.text);
      },
      decoration: InputDecoration(
        hintText: "Summary",
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
      ),
    );

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
                print(_summaryController.text);
                summaryData.set(_summaryController.text);
                _callApi(widget.profile.getToken(), widget.profile.getSession().getId(), summaryData.get(), context);
                setEdit(true, 0);
              },
            ),
            FloatingActionButton(
              child: Icon(Icons.clear),
              backgroundColor: Colors.red,
              onPressed: () {
                summaryData.set(widget.summary);
                setEdit(true, 0);
              },
            ),
          ],
        ),
      ],
    );


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

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _getTextField(),
          _getButtons(),
        ],
      ),
    );
  }

  int _index = 0;

  Future _callApi(String token, String id, String summary, BuildContext context) async {

    onLoading(context);

    SessionUpdateSummaryModel put = SessionUpdateSummaryModel(summary: summary);
    putSession(token, id, put).then((response) {

      if (response.statusCode == 200) {
        Navigator.pop(context);
      } else {
        print(response.statusCode);
        Navigator.pop(context);
      }
    }).catchError((error) {
      print(error.toString());
      Navigator.pop(context);
    });
  }

}

class SummaryData {
  String _summary;

  get() {
    return _summary;
  }

  set(String _summary) {
    this._summary = _summary;
  }
}