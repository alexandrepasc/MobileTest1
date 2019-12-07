import 'dart:convert';

StudentModel getFromJson(String str) => StudentModel.fromJson(json.decode(str));

class StudentModel {

  final String id;
  final String firstName;
  final String lastName;
  final int birthDate;
  final String description;
  final StudentActiveClassModel activeClass;
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
    activeClass: StudentActiveClassModel.fromJson(json["activeClass"]),
    classes: new List<String>.from(json["classes"])
  );
}

//GET: STUDENTS
StudentsModel getStudentsFromJson(String str) => StudentsModel.fromJson(json.decode(str));

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

//PUT: STUDENT
String putToJson(StudentUpdateModel data) => json.encode(data.toJson());

class StudentUpdateModel {

  final String firstName;
  final String lastName;
  final int birthDate;
  final String description;

  StudentUpdateModel({
    this.firstName,
    this.lastName,
    this.birthDate,
    this.description
  });

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "birthDate": birthDate,
    "description": description,
  };
}

//GET: STUDENT ACTIVE CLASS
StudentActiveClassModel getStudentActiveClassFromJson(String str) => StudentActiveClassModel.fromJson(json.decode(str));

class StudentActiveClassModel {

  final String classId;
  final String className;

  StudentActiveClassModel({
    this.classId,
    this.className
  });

  factory StudentActiveClassModel.fromJson(Map<String, dynamic> json) => StudentActiveClassModel(
    classId: json["classId"],
    className: json["className"]
  );
}