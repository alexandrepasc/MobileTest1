import 'package:flutter/material.dart';

import 'package:gsr_draft/model/IsAuthModel.dart' as responseModel;
import 'package:gsr_draft/model/UserModelRes.dart' as userRes;

import '../common/Constants.dart';
import '../common/Profile.dart';
import '../common/RolesEnum.dart';
import '../common/RoutePaths.dart' as routes;
import '../Locator.dart';
import '../model/IsAuthModel.dart';
import '../model/UserModelRes.dart';
import '../service/AuthService.dart' as authServ;
import '../service/FileService.dart';
import '../service/IsAuthService.dart';
import '../service/NavigationService.dart';

class SplashPage extends StatefulWidget {

  SplashPage({Key key}) : super(key: key);

  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashPage> {

  final NavigationService _navigationService = locator<NavigationService>();

  final logo = CircleAvatar(
    backgroundColor: Colors.transparent,
    radius: bigRadius,
    child: appLogo,
  );

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _getThingsOnStartup());
    return Scaffold(
      backgroundColor: appWhiteColor,
      body: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(height: bigRadius),
            SizedBox(height: bigRadius),
            SizedBox(height: bigRadius),
            logo,
            SizedBox(height: bigRadius),
            Text("Galitos Summary Register",
              style: TextStyle(
                color: appDarkRedColor,
                fontSize: 30.0,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Future _getThingsOnStartup() async {

    Profile _profile;

    readFile().then((token) {
      if (token != null) {

        getPost(token).then((resp) {

          if (resp.statusCode == 200) {

            IsAuthModelRes model = responseModel.postFromJson(resp.body);

            _profile = new Profile(token: token, id: model.getId());

            authServ.getPost(_profile.getId(), _profile.getToken()).then((userResp) {

              if (userResp.statusCode == 200) {

                UserModelRes userModel = userRes.postFromJson(userResp.body);

                _profile.setUsername(userModel.username);
                _profile.setName(userModel.name);
                _profile.setRoles(userModel.roles);

                if (_profile.getRoles().contains(RolesName[Roles.ROLE_USER])) {

                }

                _navigationService.navigateToAndRemove(routes.dashboardPageTag, arguments: _profile);

              } else {
                _navigationService.navigateToAndRemove(routes.loginPageTag);
              }
            });

          } else {
            _navigationService.navigateToAndRemove(routes.loginPageTag);
          }
        }).catchError((error) {
          _navigationService.navigateToAndRemove(routes.loginPageTag);
        });
      } else {
        _navigationService.navigateToAndRemove(routes.loginPageTag);
      }
    }).catchError((error) {
      _navigationService.navigateToAndRemove(routes.loginPageTag);
    });

    //print("funca");
  }
}