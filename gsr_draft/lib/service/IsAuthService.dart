import 'package:gsr_draft/common/ApiUtils.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

import '../common/ApiConstants.dart';

String isAuthEndPoint = userEndPoint + "/isAuth";

Future<http.Response> getPost(String token) async{
  final response = await http.get(new Uri.http("$apiUrl", "$isAuthEndPoint"),
    headers: getHeaderWithToken(token),
  );
  return response;
}