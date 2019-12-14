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

//GET: USERS
UsersModel getUsersFromJson(String str) => UsersModel.fromJson(json.decode(str));

class UsersModel {

  final List<UserModelRes> users;

  UsersModel({
    this.users,
  });

  factory UsersModel.fromJson(List<dynamic> json) {

    List<UserModelRes> _users = new List<UserModelRes>();

    _users = json.map((i) => UserModelRes.fromJson(i)).toList();

    return new UsersModel(
      users: _users,
    );
  }
}

//PUT: USER
String putUserToJson(UserUpdateModel data) => json.encode(data);

class UserUpdateModel {

  final String username;
  final String name;
  final String notes;

  UserUpdateModel({
    this.username,
    this.name,
    this.notes
  });

  Map<String, dynamic> toJson() => {
    "username": username,
    "name": name,
    "notes": notes
  };
}
