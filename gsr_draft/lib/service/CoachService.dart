import 'package:http/http.dart' as http;
import 'dart:async';

import '../common/ApiConstants.dart';
import '../common/ApiUtils.dart';
import '../model/CoachModel.dart';

Future<http.Response> getAuthId(String token, String id) async {
  final response = await http.get(new Uri.http("$apiUrl", "$coachesEndPoint/auth/$id"),
    headers: getHeaderWithToken(token),
  );
  return response;
}

Future<http.Response> putCoach(String token, String id, CoachUpdateModel put) async {
  final response = await http.put(new Uri.http("$apiUrl", "$coachesEndPoint/$id"),
    headers: getHeaderWithToken(token),
    body: putToJson(put),
  );
  return response;
}