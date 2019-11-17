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