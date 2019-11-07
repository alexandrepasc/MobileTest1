import 'dart:core';
import 'package:flutter/material.dart';

import 'common/Constants.dart';
import 'common/Profile.dart';
import 'Locator.dart';
import 'service/NavigationService.dart';

class DashboardPage extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();

  final Profile profile;

  DashboardPage({Key key, this.profile}) : super(key: key);

  final logo = CircleAvatar(
    backgroundColor: Colors.transparent,
    radius: bigRadius,
    child: appLogo,
  );

  @override
  Widget build(BuildContext context) {
    final tokenController = TextEditingController();
    tokenController.text = profile.getToken();

    final token = TextFormField(
      controller: tokenController,
      keyboardType: TextInputType.text,
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
                      child: token,
                    ),
                  ),
                ]
            )
        )
    );
  }
}
