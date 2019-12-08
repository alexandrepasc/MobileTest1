import 'package:http/http.dart' as http;
import 'dart:async';

import '../common/ApiConstants.dart';
import '../common/ApiUtils.dart';
import '../model/StudentsModel.dart';

Future<http.Response> getStudent(String token, String id) async {
  final response = await http.get(new Uri.http("$apiUrl", "$studentsEndPoint/$id"),
    headers: getHeaderWithToken(token),
  );
  return response;
}

Future<http.Response> getStudents(String token) async {
  final response = await http.get(new Uri.http("$apiUrl", "$studentsEndPoint"),
    headers: getHeaderWithToken(token),
  );
  return response;
}

Future<http.Response> putStudent(String token, String id, StudentUpdateModel put) async {
  final response = await http.put(new Uri.http("$apiUrl", "$studentsEndPoint/$id"),
    headers: getHeaderWithToken(token),
    body: putToJson(put),
  );
  return response;
}