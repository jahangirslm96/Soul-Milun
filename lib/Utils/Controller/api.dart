// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Screens/Maintenance/MaintenanceScreen.dart';
import 'package:soul_milan/Utils/Common/varaible.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';

class api {
  static Future get(String url) async {
    var response = await http.get(Uri.parse(apiRoute().apiLink + url));
    return jsonDecode(response.body);
  }

  static Future getWithToken(String url, String token) async {
    var response = await http.get(Uri.parse(apiRoute().apiLink + url),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    return jsonDecode(response.body);
  }

  static Future post(String url, Map<String, dynamic> body) async {
    var response =
        await http.post(Uri.parse(apiRoute().apiLink + url), body: body);
    return jsonDecode(response.body);
  }

  static Future postWithToker(String url, body, String token) async {
    var response = await http
        .post(Uri.parse(apiRoute().apiLink + url), body: body, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      // Get.snackbar("Error", response.body);
      return jsonDecode(response.body);
    }
  }

  static Future getPost(String url, Map<String, String> body) async {
    try {
      var response =
          await http.post(Uri.parse(apiRoute().apiLink + url), body: body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    }
  }
}

class Connector {
  late final apiRoute api;
  late final Map<String, String> headers;

  Connector(token) {
    api = apiRoute();
    headers = {"Accept": "application/json", "Authorization": "Bearer $token"};
  }

  Future get(String url) async {
    var response =
        await http.get(Uri.parse(api.apiLink + url), headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      Get.to(() => const MaintenanceScreen());
    }else{
      storge.erase();
    }
  }

  Future post(String url, body) async {
    var response = await http.post(Uri.parse(api.apiLink + url),
        body: body, headers: headers);
    return jsonDecode(response.body);
  }

    Future put(String url, body) async {
    var response = await http.put(Uri.parse(api.apiLink + url),
        body: body, headers: headers);
    return jsonDecode(response.body);
  }

  Future uploadImage_Data(path, images, data, name, apiType) async {
    // string to uri
    var uri = Uri.parse(api.apiLink + path);
    // create multipart request
    var request = http.MultipartRequest(apiType, uri);

    //add headers
    request.headers.addAll(headers);
    final completer = Completer<dynamic>();
    for (var image in images) {
      var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
      // get file length
      var length = await image.length();
      // multipart that takes file
      var multipartFileSign =
          http.MultipartFile(name, stream, length, filename: image.path);
      request.files.add(multipartFileSign);
    }

    request.fields.addAll(data);

    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) async {
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(value);
        completer.complete(jsonData);
      }
    });

    return completer.future;
  }

  Future uploadPdf(path, file, data) async {
    // string to uri
    var uri = Uri.parse(api.apiLink + path);
    // create multipart request
    var request = http.MultipartRequest("POST", uri);

    //add headers
    request.headers.addAll(headers);
    final completer = Completer<dynamic>();

    request.files.add(http.MultipartFile(
      'cv',
      file.readAsBytes().asStream(),
      file.lengthSync(),
      filename: file.path.split('/').last,
    ));

    request.fields.addAll(data);

    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) async {
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(value);
        completer.complete(jsonData);
      }
    });

    return completer.future;
  }
}
