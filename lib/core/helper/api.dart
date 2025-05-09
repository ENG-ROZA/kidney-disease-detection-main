import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiMethod {
    //Get request

  Future<dynamic> get({
    required String url,
    required String token,
  }) async {
    http.Response response = await http.get(Uri.parse(url), headers: {
      'token':
          "TOKEN__$token",
    });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          "there is problem with status code ${response.statusCode}");
    }
  }

  // Post request
 Future<dynamic> post({
  required String url,
  dynamic body,
  String? token,
}) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json',  
  };
  if (token != null) {
    headers.addAll({
      'token': token,
    });
  }

  http.Response response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: jsonEncode(body),  
  );

  if (response.statusCode == 201) {
    return jsonDecode(response.body);
  } else {
    throw Exception(jsonDecode(response.body)["message"] ??
        "there is problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}");
  }
}

  //Put request
  Future<dynamic> put(
      {required String url, dynamic body, String? tokin}) async {
    Map<String, String> headers = {};
    if (tokin != null) {
      headers.addAll({
        "Authorization": "Bearer $tokin",
        "Content-Type": "application/x-www-form-urlencoded"
      });
    }

    http.Response response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: body,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(jsonDecode(response.body)["message"] ??
          "there is problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}");
    }
  }
}
