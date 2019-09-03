import 'package:flutter/material.dart';

import 'common/Constants.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final inputController = TextEditingController();

    final logo = CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: bigRadius,
      child: appLogo,
    );

    final userName = TextFormField(
      controller: inputController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.continueAction,
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
    );

    final password = TextFormField(
      controller: inputController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.send,
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
        onPressed: () {},
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
            userName,
            SizedBox(height: buttonHeight),
            password,
            SizedBox(height: buttonHeight),
            loginButton,
          ],
        ),
      ),
    );
  }
}
