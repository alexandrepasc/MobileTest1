import 'dart:convert';

import 'SessionModel.dart';

SessionsModel postFromJson(String str) => SessionsModel.fromJson(json.decode(str));

class SessionsModel {
  final List<SessionModel> sessions;

  SessionsModel({
    this.sessions,
  });

  factory SessionsModel.fromJson(List<dynamic> json) {

    List<SessionModel> _sessions = json.map((i)=>SessionModel.fromJson(i)).toList();

    return new SessionsModel(
      sessions: _sessions,
    );
  }
}
