import 'dart:core';

import 'package:flutter/material.dart';
import 'package:gsr_draft/common/Profile.dart';
import 'package:gsr_draft/model/TokenModel.dart' as prefix0;

import 'common/Constants.dart';
import 'model/AuthModel.dart';
import 'model/TokenModel.dart';
import 'service/AuthService.dart';

var feedbackController = TextEditingController();
var isEnabled = true;

class LoginPage extends StatelessWidget {
  callAPI(final username, final password, BuildContext context) {
    isEnabled = false;
    AuthModel post = AuthModel(username: username, password: password);
    createPost(post).then((response) {
      if (response.statusCode == 200) {
        print(response.body);
        TokenModel token = prefix0.postFromJson(response.body);
        Profile(token: token.token);
        print(token.token);
        Navigator.of(context).pushReplacementNamed('Dashboard Page');
      }
      else
        print(response.statusCode.toString());
        String aux = response.statusCode.toString();
        feedbackController.text = "Status code: $aux";
    }).catchError((error) {
      print('error : $error');
      feedbackController.text = 'error : $error';
    });
  }

  @override
  Widget build(BuildContext context) {
    final userNameController = TextEditingController();
    final passwordController = TextEditingController();

    feedbackController.text = "";
    userNameController.text = "admin";
    passwordController.text = "sup3r5dm1n";

    final FocusNode _userName = FocusNode();
    final FocusNode _password = FocusNode();

    final logo = CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: bigRadius,
      child: appLogo,
    );

    final userName = TextFormField(
      controller: userNameController,
      enabled: isEnabled,
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
      enabled: isEnabled,
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
          FocusScope.of(context).requestFocus(new FocusNode());
          callAPI(userNameController.text, passwordController.text, context);
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

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    //FocusScope.of(context).requestFocus(nextFocus);
  }
}
