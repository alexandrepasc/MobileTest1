import 'package:flutter/material.dart';

void onLoading(BuildContext context) {
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
}

Widget loadingCircle() => Center(
  child: SizedBox(
    height: 50.0,
    width: 50.0,
    child: CircularProgressIndicator(
      strokeWidth: 7.0,
    ),
  ),
);