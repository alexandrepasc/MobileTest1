import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

import 'package:gsr_draft/model/AuthModel.dart';

String url = 'http://192.168.1.6:8080/users/authenticate';

Future<AuthModel> getPost() async{
  final response = await http.get('$url');
  return postFromJson(response.body);
}

Future<http.Response> createPost(AuthModel post) async{
  final response = await http.post('$url',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : ''
      },
      body: postToJson(post)
  );
  return response;
}