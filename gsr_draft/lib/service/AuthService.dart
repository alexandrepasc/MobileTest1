import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

import 'package:gsr_draft/model/AuthModel.dart';

String url = 'http://192.168.2.108:8080/users/authenticate';

Future<AuthModel> getPost() async{
  final response = await http.get(new Uri.http("192.168.2.108:8080", "/users/authenticate"));
  return postFromJson(response.body);
}

Future<http.Response> createPost(AuthModel post) async{
  final response = await http.post(new Uri.http("192.168.2.108:8080", "/users/authenticate"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : ''
      },
      body: postToJson(post)
  );
  return response;
}