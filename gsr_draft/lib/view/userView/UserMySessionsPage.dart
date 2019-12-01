import 'package:flutter/material.dart';
import 'package:gsr_draft/model/SessionsModel.dart' as sessModel;

import '../../common/AdminDrawerListEnum.dart';
import '../../common/Constants.dart';
import '../../common/Profile.dart';
import '../../common/RoutePaths.dart' as routes;
import '../../common/Session.dart';
import '../../component/AdminDrawer.dart';
import '../../component/AppBar.dart';
import '../../component/LoadingCircle.dart';
import '../../Locator.dart';
import '../../model/SessionModel.dart';
import '../../model/SessionsModel.dart';
import '../../service/NavigationService.dart';
import '../../service/SessionService.dart';

class UserMySessionsPage extends StatefulWidget {
  final Profile profile;

  UserMySessionsPage({Key key, this.profile}) : super(key: key);

  _UserMySessionsPage createState() => _UserMySessionsPage();
}

class _UserMySessionsPage extends State<UserMySessionsPage> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: appWhiteColor,
      appBar: applicationBar(),
      drawer: adminDrawer(widget.profile, AdminDrawerListEnum.mysessions, context),
      body: Center(
        child: Column(
          children: <Widget>[
            new FutureBuilder<SessionsModel>(
                future: _getSessions(widget.profile),
                initialData: new SessionsModel(),
                builder: (context, AsyncSnapshot<SessionsModel> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      print("none");
                      //return Text("none");
                      return loadingCircle();
                    case ConnectionState.waiting:
                      print("waiting");
                      return loadingCircle();
                    case ConnectionState.active:
                      return Text("active");
                    case ConnectionState.done:
                      print("yap1");
                      //String a = snapshot.data;
                      print(sessions.sessions[0].name);
                      //sessions = snapshot.data;
                      //return Text(snapshot.data.toString());
                      return _getSessionsTable();
                    default:
                      if (snapshot.hasError) {
                        print("error: ${snapshot.error}");
                        return Text("Error");
                      }
                      print("nop");
                      return loadingCircle();
                  }
                }
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,
        ),
      ),
    );
  }

  SessionsModel sessions;

  Future<SessionsModel> _getSessions(Profile _profile) async {
    //_onLoading(context);
    await getCoachSessions(_profile.getToken(), _profile.getCoachId()).then((response) async {
      if (response.statusCode == 200) {
        SessionsModel sessionsModel = sessModel.postFromJson(response.body);
        print(response.statusCode);

        if (sessionsModel.sessions.length > 0) {
          sessions = sessionsModel;

          print(sessions.sessions.length.toString());
          //Navigator.pop(context);
          return sessionsModel;
        } else {
          return null;
        }
      } else if (response.statusCode == 401) {
        print("cod 401");
        _navigationService.navigateToAndRemove(routes.loginPageTag);
        return null;
      } else {
        print(response.statusCode);
        return null;
      }
    }).catchError((error) {
      print(error);
      return null;
    });

    return null;
  }

  Widget _getSessionsTable() => DataTable(
    columns: [
      topRowCell("Name"),
      topRowCell("Class"),
      topRowCell("Date"),
      topRowCell("Summary"),
    ],
    rows: [..._buildRow()],
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

  List<DataRow> _buildRow() {

    List<DataRow> rows = new List();

    sessions.sessions.forEach((session) {
      rows.add(
        DataRow(
          cells: [
            dataRowCell(session.name, session),
            dataRowCell(session.className, session),
            dataRowCell(new DateTime.fromMillisecondsSinceEpoch(session.date).toString(), session),
            dataRowCell(session.summary, session),
          ],
        )
      );
    });

    return rows;
  }

  DataCell dataRowCell(String txt, SessionModel sessionModel) => DataCell(
    Text(
      txt,
      style: TextStyle(
        fontSize: 17.0,
      ),
    ),
    onTap: () {
      _openSessionDetail(sessionModel);
    }
  );
  
  _openSessionDetail(SessionModel sessionModel) {
    if (sessionModel != null) {
      Session session = new Session(
          sessionModel.id,
          sessionModel.classId,
          sessionModel.coachId,
          sessionModel.name,
          sessionModel.summary,
          sessionModel.date,
          sessionModel.className
      );

      Profile profile = widget.profile;
      profile.setSession(session);

      _navigationService.navigateTo(routes.sessionDetailPageTag, arguments: profile);
    }
  }
}