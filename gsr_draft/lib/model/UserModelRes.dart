import 'dart:convert';

UserModelRes postFromJson(String str) => UserModelRes.fromJson(json.decode(str));

class UserModelRes {
  String id;
  String username;
  String name;
  String notes;
  List<String> roles;

  UserModelRes({
    this.id,
    this.username,
    this.name,
    this.notes,
    this.roles,
  });

  factory UserModelRes.fromJson(Map<String, dynamic> json) => new UserModelRes(
    id: json["id"],
    username: json["username"],
    name: json["name"],
    notes: json["notes"],
    roles: new List<String>.from(json["roles"]),
  );
}
