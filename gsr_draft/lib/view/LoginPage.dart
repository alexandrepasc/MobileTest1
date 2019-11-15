import 'dart:core';

import 'package:flutter/material.dart';

import 'package:gsr_draft/model/AuthModelRes.dart' as prefix0;
import 'package:gsr_draft/model/CoachModel.dart' as coachModel;
import 'package:gsr_draft/model/UserModelRes.dart' as userRes;

import '../common/Constants.dart';
import '../common/Profile.dart';
import '../common/RolesEnum.dart';
import '../common/RoutePaths.dart' as routes;
import '../Locator.dart';
import '../model/AuthModelReq.dart';
import '../model/AuthModelRes.dart';
import '../model/CoachModel.dart';
import '../service/CoachService.dart' as coachServ;
import '../model/UserModelRes.dart';
import '../service/AuthService.dart';
import '../service/FileService.dart';
import '../service/NavigationService.dart';

var feedbackController = TextEditingController();
//var isEnabled = true;

class LoginPage extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();

  Future callAPI(final username, final password, BuildContext context) async{
    //isEnabled = false;
    _onLoading(context);
    AuthModelReq post = AuthModelReq(username: username, password: password);
    createPost(post).then((response) {
      if (response.statusCode == 200) {
        //print(response.body);
        AuthModelRes token = prefix0.postFromJson(response.body);
        Profile _profile = new Profile(token: token.token, id: token.id);
        final _id = token.id;
        final _token = token.token;
        getPost(_id, _token).then((userResponse) {
          if (userResponse.statusCode == 200) {
            //print(userResponse.body);
            UserModelRes userModel = userRes.postFromJson(userResponse.body);
            //print(userRes.postFromJson(userResponse.body).username);
            _profile.setUsername(userModel.username);
            _profile.setName(userModel.name);
            _profile.setRoles(userModel.roles);
            //print(_profile.getRoles());

            if (isUser(_profile.getRoles())) {
              coachServ.getAuthId(_profile.getToken(), _profile.getId()).then((coachResp) {

                if (coachResp.statusCode == 200) {

                  CoachModelRes coachModelRes = coachModel.postFromJson(coachResp.body);

                  _profile.setCoachId(coachModelRes.id);
                  _profile.setCoachFirstName(coachModelRes.firstName);
                  _profile.setCoachLastName(coachModelRes.lastName);
                  _profile.setCoachDescription(coachModelRes.description);

                  saveFile(_profile.getToken());

                  Navigator.pop(context);
                  _navigationService.navigateToAndRemove(routes.dashboardPageTag, arguments: _profile);

                } else {
                  String aux = response.statusCode.toString();
                  feedbackController.text = "Status code: $aux";
                  Navigator.pop(context);
                }
              }).catchError((error) {
                feedbackController.text = 'error : $error';
                Navigator.pop(context);
              });
            } else {

              saveFile(_profile.getToken());

              Navigator.pop(context);
              _navigationService.navigateToAndRemove(routes.dashboardPageTag, arguments: _profile);
            }

          }
          else {
            String aux = response.statusCode.toString();
            feedbackController.text = "Status code: $aux";
            Navigator.pop(context);
          }
        }).catchError((error) {
          feedbackController.text = 'error : $error';
          Navigator.pop(context);
        });
        //UserModelRes user = userRes.postFromJson(str)
        //print(token.token);
        //print(_profile.getUsername());
        //Navigator.pop(context);
        //Navigator.of(context).pushReplacementNamed('Dashboard Page');
        //Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardPage(_profile),),);
        //_navigationService.navigateTo(routes.dashboardPageTag, arguments: _profile  );
      }
      else {
        print(response.statusCode.toString());
        String aux = response.statusCode.toString();
        feedbackController.text = "Status code: $aux";
        Navigator.pop(context);
      }
    }).catchError((error) {
      //print('error : $error');
      feedbackController.text = 'error : $error';
      Navigator.pop(context);
    });
  }

  void _onLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new Container(
          decoration: new BoxDecoration(
              color: Colors.transparent,
              borderRadius: new BorderRadius.circular(10.0)
          ),
          width: 150.0,
          height: 200.0,
          alignment: AlignmentDirectional.center,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Center(
                child: new SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: new CircularProgressIndicator(
                    value: null,
                    strokeWidth: 7.0,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    /*new Future.delayed(new Duration(seconds: 3), () {
      Navigator.pop(context); //pop dialog
      //_login();
      callAPI(username, password, context);
    });*/
  }

  @override
  Widget build(BuildContext context) {
    final userNameController = TextEditingController();
    final passwordController = TextEditingController();

    //feedbackController.text = "";
    userNameController.text = "admin";
    passwordController.text = "sup3r5dm1n";

    final logo = CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: bigRadius,
      child: appLogo,
    );

    final userName = TextFormField(
      controller: userNameController,
      //enabled: isEnabled,
      keyboardType: TextInputType.text,
//      textInputAction: TextInputAction.next,
//      focusNode: _userName,
      maxLines: 1,
      autofocus: true,
      decoration: InputDecoration(
        hintText: userNameHintText,
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
      style: TextStyle(
        color: Colors.black,
      ),
//      onFieldSubmitted: (term) {
//        _fieldFocusChange(context, _userName, _password);
//      },
    );

    final password = TextFormField(
      controller: passwordController,
      //enabled: isEnabled,
      keyboardType: TextInputType.text,
//      focusNode: _password,
      maxLines: 1,
      obscureText: true,
      decoration: InputDecoration(
        hintText: passwordHintText,
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
      style: TextStyle(
        color: Colors.black,
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          //isEnabled = false;
          //Navigator.of(context).pushReplacementNamed('Dashboard Page');
          FocusScope.of(context).requestFocus(new FocusNode());
          feedbackController.text = "";
          callAPI(userNameController.text, passwordController.text, context);
          //_onLoading(userNameController.text, passwordController.text, context);
        },
//          onPressed: callAPI(userNameController.text, passwordController.text),
        padding: EdgeInsets.all(12),
        color: appDarkRedColor,
        child: Text(loginButtonText, style: TextStyle(color: Colors.white)),
      ),
    );

    final feedback = TextField(
      controller: feedbackController,
      enabled: false,
      maxLines: null,
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.0),
        ),
      ),
      style: TextStyle(
        color: Colors.redAccent,
      ),
      textAlign: TextAlign.center,
    );

    return Scaffold(
      backgroundColor: appWhiteColor,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: bigRadius),
            Center(
              child: Container(
                width: 350.0,
                child: userName,
              ),
            ),
            SizedBox(height: buttonHeight),
            Center(
              child: Container(
                width: 350.0,
                child: password,
              ),
            ),
            SizedBox(height: buttonHeight),
            Center(
              child: Container(
                width: 250.0,
                child: loginButton,
              ),
            ),
            SizedBox(height: buttonHeight),
            Center(
              child: Container(
                child: feedback,
              ),
            )
          ],
        ),
      ),
    );
  }
}
