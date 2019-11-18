import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

import '../common/ApiConstants.dart';
import '../common/ApiUtils.dart';

Future<http.Response> getPost(String token) async {
  final response = await http.get(new Uri.http("$apiUrl", "$coachesEndPoint/"),
    headers: getHeaderWithToken(token),
  );
  return response;
}