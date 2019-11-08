import 'dart:convert';

AuthModelReq postFromJson(String str) => AuthModelReq.fromJson(json.decode(str));

String postToJson(AuthModelReq data) => json.encode(data.toJson());

class AuthModelReq {
  String username;
  String password;

  AuthModelReq({
    this.username,
    this.password,
  });

  factory AuthModelReq.fromJson(Map<String, dynamic> json) => new AuthModelReq(
    username: json["username"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
  };
}
