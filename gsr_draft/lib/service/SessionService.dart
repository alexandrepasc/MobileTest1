import 'package:http/http.dart' as http;
import 'dart:async';

import '../common/ApiConstants.dart';
import '../common/ApiUtils.dart';

Future<http.Response> getAllSessions(String token) async {
  final response = await http.get(new Uri.http("$apiUrl", "$sessionsEndPoint/"),
    headers: getHeaderWithToken(token),
  );
  return response;
}

Future<http.Response> getCoachSessions(String token, String id) async {
  final response = await http.get(new Uri.http("$apiUrl", "$sessionsEndPoint/coach/$id"),
    headers: getHeaderWithToken(token),
  );
  return response;
}

Future<http.Response> getSession(String token, String id) async {
  final response = await http.get(new Uri.http("$apiUrl", "$sessionsEndPoint/$id"),
    headers: getHeaderWithToken(token),
  );
  return response;
}