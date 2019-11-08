import 'dart:convert';

AuthModelRes postFromJson(String str) => AuthModelRes.fromJson(json.decode(str));

class AuthModelRes {
  String token;
  String id;

  AuthModelRes({
    this.token,
    this.id,
  });

  factory AuthModelRes.fromJson(Map<String, dynamic> json) => new AuthModelRes(
    token: json["token"],
    id: json["id"],
  );
}
