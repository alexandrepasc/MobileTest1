import 'dart:io';

Map<String, String> getHeaderWithToken(String token) {

  Map<String, String> header = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader : 'Bearer $token'
  };

  return header;
}

Map<String, String> getHeaderNoToken() {

  Map<String, String> header = {
    HttpHeaders.contentTypeHeader: 'application/json'
  };

  return header;
}