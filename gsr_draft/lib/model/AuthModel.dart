import 'dart:convert';

AuthModel postFromJson(String str) => AuthModel.fromJson(json.decode(str));

String postToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  String username;
  String password;

  AuthModel({
    this.username,
    this.password,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => new AuthModel(
    username: json["username"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
  };
}
