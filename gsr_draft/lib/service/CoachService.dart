import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

import '../common/Constants.dart';

Future<http.Response> getAuthId(String token, String id) async {
  final response = await http.get(new Uri.http("$apiUrl", "$coachesEndPoint/auth/$id"),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : 'Bearer $token'
    },
  );
  return response;
}