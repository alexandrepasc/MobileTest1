import 'dart:convert';

CoachModelRes postFromJson(String str) => CoachModelRes.fromJson(json.decode(str));

class CoachModelRes {

  String id;
  String firstName;
  String lastName;
  String description;
  String username;
  String notes;
  List<String> roles;

  CoachModelRes({
    this.id,
    this.firstName,
    this.lastName,
    this.description,
    this.username,
    this.notes,
    this.roles,
  });

  factory CoachModelRes.fromJson(Map<String, dynamic> json) => new CoachModelRes(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    description: json["description"],
    username: json["username"],
    notes: json["notes"],
    roles: new List<String>.from(json["roles"]),
  );
}