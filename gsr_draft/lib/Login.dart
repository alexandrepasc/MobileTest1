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
      maxLines: 1,
      autofocus: true,
      decoration: InputDecoration(
          hintText: userNameHintText,
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: BorderSide(color: Colors.greenAccent, width: 3.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: BorderSide(color: Colors.redAccent, width: 3.0),
          ),
          hintStyle: TextStyle(color: Colors.red)),
      style: TextStyle(
        color: Colors.red,
      ),
    );

    return Scaffold(
      backgroundColor: appWhiteColor,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[logo, SizedBox(height: bigRadius), userName],
        ),
      ),
    );
  }
}
