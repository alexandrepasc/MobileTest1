import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

import '../common/Constants.dart';

Future<http.Response> getPost(String token) async {
  final response = await http.get(new Uri.http("$apiUrl", "$coachesEndPoint"),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : 'Bearer $token'
    },
  );
  return response;
}