import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkHandler {
  String baseUrl = 'http://10.0.3.2:9000';
  final log = Logger();
  FlutterSecureStorage _storage = FlutterSecureStorage();

  Future get(String url) async {
    url = formatter(url);
    String token = await _storage.read(key: "token");
    print(token);

    final res = await http.get(url, headers: {
      "Content-type": "application/json",
      "Cookie": "w_auth=$token"
    });

    print(res.body);
    log.i(res);
    log.d(res.body);

    return json.decode(res.body);
  }

  Future<http.Response> post(String url, body) async {
    String token = await _storage.read(key: "token");
    url = formatter(url);

    final res = await http.post(url,
        headers: {
          "Content-type": "application/json",
          "Cookie": "w_auth=$token"
        },
        body: body);

    //print(res.body);
    log.i(res);
    log.d(res.body);

    return res;
  }

  Future<http.StreamedResponse> patchImage(String url, String filePath) async {
    url = formatter(url);
    String token = await _storage.read(key: "token");

    var uri = Uri.parse(url);
    final request = http.MultipartRequest("POST", uri);
    request.files.add(await http.MultipartFile.fromPath("file", filePath));
    request.headers.addAll(
        {"Content-type": "multipart/form-data", "Cookie": "w_auth=$token"});

    final res = await request.send();
    //.then((result) async {
    //   http.Response.fromStream(result).then((response) {
    //     if (response.statusCode == 200) {
    //       print("response body " + response.body);
    //       final res = json.decode(response.body);
    //       print(res['filePath']);
    //     }
    //     return response.body;
    //   });
    // }).catchError((err) => {print("error: " + err.toString())});

    //final fileInfo =  await res.stream.transform(utf8.decoder).join();

    log.d(request);
    log.i(res);
    //print('toatl res '+res);

    return res;
  }

  NetworkImage getImage(String thumbnailPath) {
    String url = formatter(thumbnailPath);
    return NetworkImage(url);
  }

  String formatter(String url) {
    return baseUrl + url;
  }
}
