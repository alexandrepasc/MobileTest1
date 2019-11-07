import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

import 'package:gsr_draft/model/AuthModel.dart';

String url = '172.17.0.3:8080';
String endPoint = "/users/authenticate";

Future<AuthModel> getPost() async{
  final response = await http.get(new Uri.http("$url", "$endPoint"));
  return postFromJson(response.body);
}

Future<http.Response> createPost(AuthModel post) async{
  final response = await http.post(new Uri.http("$url", "$endPoint"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : ''
      },
      body: postToJson(post)
  );
  return response;
}