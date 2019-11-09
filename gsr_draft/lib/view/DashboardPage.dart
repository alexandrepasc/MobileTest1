import 'dart:core';
import 'package:flutter/material.dart';
import 'package:gsr_draft/component/AdminDrawer.dart';

import '../common/Constants.dart';
import '../common/Profile.dart';
import '../Locator.dart';
import '../service/NavigationService.dart';

class DashboardPage extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();

  final Profile profile;

  DashboardPage({Key key, this.profile}) : super(key: key);

  final logo = CircleAvatar(
    backgroundColor: Colors.transparent,
    radius: bigRadius,
    child: appLogo,
  );

  Widget drawerHead() {
    if (profile.getRoles().contains("ROLE_ADMIN")) {
      return adminAccountDrawerHead(profile);
    } else {

    }
  }

  @override
  Widget build(BuildContext context) {
    final tokenController = TextEditingController();
    final idController = TextEditingController();
    final usernameController = TextEditingController();
    final nameController = TextEditingController();
    tokenController.text = profile.getToken();
    idController.text = profile.getId();
    usernameController.text = profile.getUsername();
    nameController.text = profile.getName();

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

    final id = TextFormField(
      controller: idController,
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

    final username = TextFormField(
      controller: usernameController,
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

    final name = TextFormField(
      controller: nameController,
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

    final drawer = Drawer(
      child: ListView(
        children: <Widget>[
          drawerHead(),
        ],
      ),
    );

    return Scaffold(
        backgroundColor: appWhiteColor,
        appBar: AppBar(
          title: Text(
            appTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: appWhiteColor,
            ),
          ),
          centerTitle: true,
          backgroundColor: appDarkRedColor,
        ),
        drawer: drawer,
        body: WillPopScope(
          //Wrap out body with a `WillPopScope` widget that handles when a user is cosing current route
          onWillPop: () async {
            print("nop");
            return Future.value(false); //return a `Future` with false value so this route cant be popped or closed.
          },
          child: Center(
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
                    Center(
                      child: Container(
                        width: 350.0,
                        child: id,
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 350.0,
                        child: username,
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 350.0,
                        child: name,
                      ),
                    ),
                  ]
              )
          )
        ),
    );
  }
}
