import 'dart:convert';

String postToJson(PresenceAddModel data) => json.encode(data.toJson());

class PresenceAddModel {

  final String sessionId;
  final String studentId;
  final String classId;
  final String coachId;
  final int date;

  PresenceAddModel({
    this.sessionId,
    this.studentId,
    this.classId,
    this.coachId,
    this.date,
  });

  Map<String, dynamic> toJson() => {
    "sessionId": sessionId,
    "studentId": studentId,
    "classId": classId,
    "coachId": coachId,
    "date": date,
  };
}