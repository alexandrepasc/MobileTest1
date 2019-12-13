import 'package:gsr_draft/model/UserModelRes.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

import '../common/ApiConstants.dart';
import '../common/ApiUtils.dart';
import '../model/AuthModelReq.dart';
import '../model/AuthModelRes.dart';

//String url = '172.17.0.3:8080';
String authEndPoint = userEndPoint + "/authenticate";

//Future<AuthModelReq> getPost(String id, String token) async{
//  final response = await http.get(new Uri.http("$apiUrl", "$userEndPoint$id"),
//    headers: {
//      HttpHeaders.contentTypeHeader: 'application/json',
//      HttpHeaders.authorizationHeader : 'Bearer $token'
//    },
//  );
//  return postFromJson(response.body);
//}
Future<http.Response> getPost(String id, String token) async{
  print(apiUrl + userEndPoint + "/" + id);
  final response = await http.get(new Uri.http("$apiUrl", "$userEndPoint/$id"),
    headers: getHeaderWithToken(token),
  );
  return response;
}

Future<http.Response> createPost(AuthModelReq post) async{
  final response = await http.post(new Uri.http("$apiUrl", "$authEndPoint"),
      headers: getHeaderNoToken(),
      body: postToJson(post)
  );
  return response;
}

Future<http.Response> getCoordinators(String token) async{
  final response = await http.get(new Uri.http("$apiUrl", "$userEndPoint/coordinators"),
    headers: getHeaderWithToken(token),
  );
  return response;
}

Future<http.Response> putUser(String token, String id, UserUpdateModel user) async{
  final response = await http.put(new Uri.http("$apiUrl", "$userEndPoint/$id"),
    headers: getHeaderWithToken(token),
    body: putUserToJson(user),
  );
  return response;
}