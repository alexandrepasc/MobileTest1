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
            userName
          ],
        ),
      ),
    );
  }
}
