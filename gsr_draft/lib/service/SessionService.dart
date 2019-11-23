import 'package:http/http.dart' as http;
import 'dart:async';

import '../common/ApiConstants.dart';
import '../common/ApiUtils.dart';
import '../model/SessionModel.dart';

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

Future<http.Response> putSession(String token, String id, SessionUpdateSummaryModel put) async {
  final response = await http.put(new Uri.http("$apiUrl", "$sessionsEndPoint/$id"),
    headers: getHeaderWithToken(token),
    body: putToJson(put),
  );
  return response;
}