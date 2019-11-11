import 'dart:convert';

import 'CoachModel.dart';

CoachesModelRes postFromJson(String str) => CoachesModelRes.fromJson(json.decode(str));

class CoachesModelRes {

  int count;
  List<CoachModelRes> coaches;

  CoachesModelRes({
    this.count,
    this.coaches,
  });

  factory CoachesModelRes.fromJson(Map<String, dynamic> json) => new CoachesModelRes(
    count: json["count"],
    coaches: new List<CoachModelRes>.from(json["coaches"]),
  );
}