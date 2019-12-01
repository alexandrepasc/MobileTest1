import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

import '../common/ApiConstants.dart';
import '../common/ApiUtils.dart';

Future<http.Response> getAuthId(String token, String id) async {
  final response = await http.get(new Uri.http("$apiUrl", "$coachesEndPoint/auth/$id"),
    headers: getHeaderWithToken(token),
  );
  return response;
}