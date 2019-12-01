import 'dart:convert';

ClassModel postFromJson(String str) => ClassModel.fromJson(json.decode(str));

class ClassModel {

  final String id;
  final String name;
  final String description;
  final String coachId;
  final List<String> students;

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
    students: new List<String>.from(json["students"]),
  );
}


ClassesModel getFromJson(String str) => ClassesModel.fromJson(json.decode(str));

class ClassesModel {

  final List<ClassModel> classes;

  ClassesModel({
    this.classes
  });

  factory ClassesModel.fromJson(List<dynamic> json) {
    List<ClassModel> _classes = new List<ClassModel>();

    _classes = json.map((i) => ClassModel.fromJson(i)).toList();

    return new ClassesModel(
      classes: _classes,
    );
  }
}