import 'dart:convert';

ClassModel postFromJson(String str) => ClassModel.fromJson(json.decode(str));

class ClassModel {

  final String id;
  final String name;
  final String description;
  final String coachId;
  final String students;

  ClassModel({
    this.id,
    this.name,
    this.description,
    this.coachId,
    this.students,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) => new ClassModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    coachId: json["coachId"],
    students: json["students"],
  );
}