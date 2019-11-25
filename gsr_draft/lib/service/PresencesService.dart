import 'package:http/http.dart' as http;
import 'dart:async';

import '../common/ApiConstants.dart';
import '../common/ApiUtils.dart';
import '../model/PresenceModel.dart';

Future<http.Response> postPresence(String token, PresenceAddModel post) async {
  final response = await http.post(new Uri.http("$apiUrl", "$presencesEndPoint/add"),
    headers: getHeaderWithToken(token),
    body: postToJson(post),
  );
  return response;
}