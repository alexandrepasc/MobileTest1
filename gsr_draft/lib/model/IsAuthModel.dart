import 'dart:convert';

String postToJson(IsAuthModelReq data) => json.encode(data.toJson());

class IsAuthModelReq {
  Map<String, dynamic> toJson() => {};
}

IsAuthModelRes postFromJson(String str) => IsAuthModelRes.fromJson(json.decode(str));

class IsAuthModelRes {
  String id;

  IsAuthModelRes({
    this.id,
  });

  factory IsAuthModelRes.fromJson(Map<String, dynamic> json) => new IsAuthModelRes(
    id: json["id"],
  );

  getId() {
    return id;
  }
}
