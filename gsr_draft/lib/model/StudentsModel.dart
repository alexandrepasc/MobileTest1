import 'dart:convert';

StudentModel getFromJson(String str) => StudentModel.fromJson(json.decode(str));

class StudentModel {

  final String id;
  final String firstName;
  final String lastName;
  final int birthDate;
  final String description;
  final String activeClass;
  final List<String> classes;

  StudentModel({
    this.id,
    this.firstName,
    this.lastName,
    this.birthDate,
    this.description,
    this.activeClass,
    this.classes
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    birthDate: json["birthDate"],
    description: json["description"],
    activeClass: json["activeClass"],
    classes: new List<String>.from(json["classes"])
  );
}

class StudentsModel {

  final List<StudentModel> students;

  StudentsModel({
    this.students
  });

  factory StudentsModel.fromJson(List<dynamic> json) {

    List<StudentModel> _students = new List<StudentModel>();

    _students = json.map((i) => StudentModel.fromJson(i)).toList();

    return new StudentsModel(
      students: _students,
    );
  }
}