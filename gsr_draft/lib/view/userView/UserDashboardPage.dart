import 'package:flutter/material.dart';
import 'package:gsr_draft/model/SessionsModel.dart' as sessModel;

import '../../common/AdminDrawerListEnum.dart';
import '../../common/Constants.dart';
import '../../common/Profile.dart';
import '../../common/RoutePaths.dart' as routes;
import '../../common/Session.dart';
import '../../component/AdminDrawer.dart';
import '../../component/AppBar.dart';
import '../../Locator.dart';
import '../../model/SessionModel.dart';
import '../../model/SessionsModel.dart';
import '../../service/NavigationService.dart';
import '../../service/SessionService.dart';

var now = new DateTime.now();

class UserDashboard extends StatefulWidget {
  final Profile profile;

  UserDashboard({Key key, this.profile}) : super(key: key);

  _UserDashboard createState() => _UserDashboard();
}

class _UserDashboard extends State<UserDashboard> {
  final NavigationService _navigationService = locator<NavigationService>();

  SessionsModel sessions;

  Future<SessionsModel> _getSessions(Profile _profile) async {
    //_onLoading(context);
    await getCoachSessions(_profile.getToken(), _profile.getCoachId()).then((apiResponse) async {
      if (apiResponse.statusCode == 200) {
        SessionsModel sessionsModel = sessModel.postFromJson(apiResponse.body);

        if (sessionsModel.sessions.length > 0) {
          sessions = sessionsModel;

          //print(sessions.sessions.length.toString());
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

  @override
  initState() {
    super.initState();
    //_getSessions(widget.profile);
  }

  @override
  Widget build(BuildContext context) {
    //WidgetsBinding.instance.addPostFrameCallback((_) => _getSessions(widget.profile));

    return Scaffold(
        backgroundColor: appWhiteColor,
        appBar: applicationBar(),
        drawer: adminDrawer(widget.profile, AdminDrawerListEnum.dashboard, context),
        body: new FutureBuilder<SessionsModel>(
            future: _getSessions(widget.profile),
            builder: (context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  //print("none");
                  return Text("none");
                case ConnectionState.waiting:
                  //print("waiting");
                  return new CircularProgressIndicator();
                default:
                  if (snapshot.hasError) {
                    print("error: ${snapshot.error}");
                    return Text("Error");
                  } else {
                    //print("yap");
                    return _orientationBuilder();
                  }
              }
            }));
  }

  OrientationBuilder _orientationBuilder() =>
      OrientationBuilder(builder: (context, orientation) {
        return GridView.count(
          crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
          children: _addCards(orientation),
        );
      });

  List<Widget> _addCards(Orientation orientation) {
    List<Card> cards = new List();
    //print(orientation);
    //print(sessions.sessions.length.toString());
    List<SessionModel> listSessions = sessions.sessions;

    listSessions.forEach((_session) {
      //print(_session.name);
      cards.add(_setCard(_session));
    });

    return cards;
  }

  Card _setCard(SessionModel sessionModel) => Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: appDarkRedColor,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: InkWell(
          child: ListView(
            children: <Widget>[
              SizedBox(height: bigRadius),
              Text(
                sessionModel.className,
                style: TextStyle(
                    color: appDarkRedColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: buttonHeight,
              ),
              Text(
                sessionModel.name,
                style: TextStyle(
                    color: appDarkRedColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: buttonHeight,
              ),
              Text(
                "Date: " +
                    new DateTime.fromMillisecondsSinceEpoch(sessionModel.date)
                        .toString(),
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          onTap: () {
            _openSessionDetail(sessionModel);
          },
        ),
      );

  _openSessionDetail(SessionModel sessionModel) {
    if (sessionModel != null) {
      //print("session: " + sessionModel.name);
      Session session = new Session(
          sessionModel.id,
          sessionModel.classId,
          sessionModel.coachId,
          sessionModel.name,
          sessionModel.summary,
          sessionModel.date,
          sessionModel.className);

      Profile _profile = widget.profile;
      _profile.setSession(session);
      //print(_profile.getSession().getName());

      _navigationService.navigateTo(routes.sessionDetailPageTag, arguments: _profile);
    }
  }
}
