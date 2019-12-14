import 'package:http/http.dart' as http;
import 'dart:async';

import '../common/ApiConstants.dart';
import '../common/ApiUtils.dart';

Future<http.Response> getClass(String token, String id) async {
  print(apiUrl + classesEndPoint + "/" + id);
  final response = await http.get(new Uri.http("$apiUrl", "$classesEndPoint/$id"),
    headers: getHeaderWithToken(token),
  );

  return response;
}

Future<http.Response> getClassByCoach(String token, String id) async {
  print(apiUrl + classesEndPoint + "/coach/" + id);
  final response = await http.get(new Uri.http("$apiUrl", "$classesEndPoint/coach/$id"),
    headers: getHeaderWithToken(token),
  );

  return response;
}

Future<http.Response> getClasses(String token) async {
  print(apiUrl + classesEndPoint);
  final response = await http.get(new Uri.http("$apiUrl", "$classesEndPoint"),
    headers: getHeaderWithToken(token),
  );

  return response;
}