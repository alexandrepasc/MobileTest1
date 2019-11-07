import 'dart:convert';

TokenModel postFromJson(String str) => TokenModel.fromJson(json.decode(str));

class TokenModel {
  String token;
  String id;

  TokenModel({
    this.token,
    this.id,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) => new TokenModel(
    token: json["token"],
    id: json["id"],
  );
}
