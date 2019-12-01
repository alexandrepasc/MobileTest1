import 'dart:convert';

import 'SessionModel.dart';

SessionsModel postFromJson(String str) => SessionsModel.fromJson(json.decode(str));

class SessionsModel {
  final List<SessionModel> sessions;

  SessionsModel({
    this.sessions,
  });

  factory SessionsModel.fromJson(List<dynamic> json) {
    List<SessionModel> _sessions = new List<SessionModel>();

    _sessions = json.map((i)=>SessionModel.fromJson(i)).toList();

    return new SessionsModel(
      sessions: _sessions,
    );
  }
}

//GET: SESSION PRESENCES
SessionPresencesModel getFromJson(String str) => SessionPresencesModel.fromJson(json.decode(str));

class SessionPresencesModel {
  final List<SessionPresenceModel> presences;

  SessionPresencesModel({
    this.presences,
  });

  factory SessionPresencesModel.fromJson(List<dynamic> json) {
    List<SessionPresenceModel> _presences = new List<SessionPresenceModel>();

    _presences = json.map((i) => SessionPresenceModel.fromJson(i)).toList();

    return new SessionPresencesModel(
      presences: _presences,
    );
  }
}