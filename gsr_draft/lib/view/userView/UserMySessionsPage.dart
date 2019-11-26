import 'package:flutter/material.dart';
import 'package:gsr_draft/model/SessionsModel.dart' as sessModel;

import '../../common/AdminDrawerListEnum.dart';
import '../../common/Constants.dart';
import '../../common/Profile.dart';
import '../../common/RoutePaths.dart' as routes;
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
      body: new FutureBuilder<SessionsModel>(
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
                return testing(snapshot.data.sessions.length.toString());
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
    );
  }

  SessionsModel sessions;

  Future<SessionsModel> _getSessions(Profile _profile) async {
    //_onLoading(context);
    await getCoachSessions(_profile.getToken(), _profile.getCoachId()).then((apiResponse) async {
      if (apiResponse.statusCode == 200) {
        SessionsModel sessionsModel = sessModel.postFromJson(apiResponse.body);
        print(apiResponse.statusCode);

        if (sessionsModel.sessions.length > 0) {
          sessions = sessionsModel;

          print(sessions.sessions.length.toString());
          //Navigator.pop(context);
          return sessionsModel;
        } else {
          return null;
        }
      } else {
        return null;
      }
    }).catchError((error) {
      return null;
    });

    return null;
  }
  
  Text testing(String _sessions) => Text(
    _sessions
  );
}