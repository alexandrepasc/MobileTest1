import 'package:http/http.dart' as http;
import 'dart:async';

import '../common/ApiConstants.dart';
import '../common/ApiUtils.dart';

Future<http.Response> getClass(String token, String id) async {
  final response = await http.get(new Uri.http("$apiUrl", "$classesEndPoint/$id"),
    headers: getHeaderWithToken(token),
  );

  return response;
}