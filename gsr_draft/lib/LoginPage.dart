import 'dart:core';

import 'package:flutter/material.dart';

import 'common/Constants.dart';
import 'model/AuthModel.dart';
import 'service/AuthService.dart';

class LoginPage extends StatelessWidget {
  callAPI(final username, final password) {
    AuthModel post = AuthModel(username: username, password: password);
    createPost(post).then((response) {
      if (response.statusCode == 200)
        print(response.body);
      else
        print(response.statusCode);
    }).catchError((error) {
      print('error : $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    final userNameController = TextEditingController();
    final passwordController = TextEditingController();

    final FocusNode _userName = FocusNode();
    final FocusNode _password = FocusNode();

    final logo = CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: bigRadius,
      child: appLogo,
    );

    final userName = TextFormField(
      controller: userNameController,
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
          callAPI(userNameController.text, passwordController.text);
        },
//          onPressed: callAPI(userNameController.text, passwordController.text),
        padding: EdgeInsets.all(12),
        color: appDarkRedColor,
        child: Text(loginButtonText, style: TextStyle(color: Colors.white)),
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
          ],
        ),
      ),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
