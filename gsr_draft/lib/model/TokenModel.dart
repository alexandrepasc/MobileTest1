import 'dart:convert';

TokenModel postFromJson(String str) => TokenModel.fromJson(json.decode(str));

class TokenModel {
  String token;

  TokenModel({
    this.token,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) => new TokenModel(
    token: json["token"],
  );
}
