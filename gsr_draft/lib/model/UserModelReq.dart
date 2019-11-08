import 'dart:convert';

//UserModelReq postFromJson(String str) => UserModelReq.fromJson(json.decode(str));

String postToJson(UserModelReq data) => json.encode(data.toJson());

class UserModelReq {

  //AuthModelReq({});

  //factory UserModelReq.fromJson(Map<String, dynamic> json) => new UserModelReq();

  Map<String, dynamic> toJson() => {};
}