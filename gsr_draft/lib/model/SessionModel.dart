import 'dart:convert';

SessionModel postFromJson(String str) => SessionModel.fromJson(json.decode(str));

class SessionModel {

  final String id;
  final String classId;
  final String coachId;
  final String name;
  final String summary;
  final int date;
  final String className;

  SessionModel({
    this.id,
    this.classId,
    this.coachId,
    this.name,
    this.summary,
    this.date,
    this.className,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) => SessionModel(
    id: json["id"],
    classId: json["classId"],
    coachId: json["coachId"],
    name: json["name"],
    summary: json["summary"],
    date: json["date"],
    className: json["className"],
  );
}


// PUT: UPDATE SUMMARY
String putToJson(SessionUpdateSummaryModel data) => json.encode(data.toJson());

class SessionUpdateSummaryModel {

  final String summary;

  SessionUpdateSummaryModel({
    this.summary,
  });

  Map<String, dynamic> toJson() => {
    "summary": summary,
  };
}

//GET: SESSION PRESENCE
SessionPresenceModel getFromJson(String str) => SessionPresenceModel.fromJson(json.decode(str));

class SessionPresenceModel {

  String studentId;
  String studentName;
  String presenceId;
  bool presence;

  SessionPresenceModel({
    this.studentId,
    this.studentName,
    this.presenceId,
    this.presence,
  });

  factory SessionPresenceModel.fromJson(Map<String, dynamic> json) => SessionPresenceModel(
      studentId: json["studentId"],
      studentName: json["studentName"],
      presenceId: json["presenceId"],
      presence: json["presence"],
  );
}