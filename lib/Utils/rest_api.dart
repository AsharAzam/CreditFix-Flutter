import 'dart:convert';
import 'dart:io';
import 'package:core/Models/User.dart';
import 'package:core/Utils/utils.dart';
import 'package:core/Views/views.dart';
import 'package:core/UI/login.dart';
import 'package:core/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

import 'package:core/Models/BaseModel.dart';
import 'package:core/Utils/Const.dart';
import 'package:core/Utils/Encryption.dart';
import 'package:core/Utils/Prefs.dart';

String baseUrl = Const.BASE_URL;

Future<BaseModel> POST_JSON(String endPoint, jsonBody,
    {String? authToken}) async {
  // set up POST request arguments
//  String url = 'https://jsonplaceholder.typicode.com/posts';
  Map<String, String> headers = {
    "Content-Type": "application/json",
    "token": Encryption.appToken,
    "user-token": authToken ??
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjUsImlhdCI6MTU3MDc3NDE0NX0.KpeFmLLKXmqmDFhP4Jr_6i-fbhQFLwiIPuSlB6Izfvw",
  };
//  String json = '{"title": "Hello", "body": "body text", "userId": 1}';
  // make POST request
  String url = baseUrl + endPoint;
  http.Response response = await http.post(Uri.parse(url),
      headers: headers, body: jsonBody != null ? jsonEncode(jsonBody) : null);

  // check the status code for the result
  int statusCode = response.statusCode;
  // this API passes back the id of the new item added to the body
  if (statusCode == 200 || statusCode == 400) {
    String body = response.body;
    body = utf8.decode(body.runes.toList());
    var jsonBody = json.decode(body);
    print(body);
    return BaseModel.fromJson(jsonBody);
  } else {
    throw Exception(response.reasonPhrase);
  }
}

Future<BaseModel> DELETE(String endPoint,
    {String? authToken, required String id}) async {
  Map<String, String> headers = {
    "token": Encryption.appToken,
    "user-token": authToken ??
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjUsImlhdCI6MTU3MDc3NDE0NX0.KpeFmLLKXmqmDFhP4Jr_6i-fbhQFLwiIPuSlB6Izfvw",
  };
  String bUrl = baseUrl + endPoint;
  final url = Uri.encodeFull(bUrl + id);
  http.Response response = await http.delete(
    Uri.parse(url),
    headers: headers,
  );
  // check the status code for the result
  int statusCode = response.statusCode;
  // this API passes back the id of the new item added to the body
  if (statusCode == 200) {
    String body = response.body;
    var jsonBody = json.decode(body);
    print(body);
    return BaseModel.fromJson(jsonBody);
  } else {
    throw Exception(response.reasonPhrase);
  }
}

Future<BaseModel> POST_FORM_DATA(String endPoint, Map<String, dynamic> body,
    {String? authToken}) async {
//  String url = 'https://360cubes.com/urantia_staging/public/api/user/login';

  Map<String, String> headers = {
//    "Content-Type": "application/x-www-form-urlencoded",
    "token": Encryption.appToken,
    "user-token": authToken ??
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjUsImlhdCI6MTU3MDc3NDE0NX0.KpeFmLLKXmqmDFhP4Jr_6i-fbhQFLwiIPuSlB6Izfvw",
  };
//  Map<String, String> body = {
//    'email': 'android@reader.com',
//    'password': '123456',
//  };
  // make POST request
  http.Response response = await http.post(Uri.parse(baseUrl + endPoint),
      headers: headers, body: body);
  // check the status code for the result
  int statusCode = response.statusCode;
  // this API passes back the id of the new item added to the body
  if (statusCode == 200) {
    String body = response.body;
    var jsonBody = json.decode(body);
    print(body);
    return BaseModel.fromJson(jsonBody);
  } else {
    throw Exception(response.reasonPhrase);
  }
}

Future<BaseModel> MultiPart(String endPoint, Map<String, dynamic> body,
    List<String>? files, String? image,
    {String? authToken, String? path}) async {
  var uri = Uri.parse(baseUrl + endPoint + "${path ?? ""}");
  var request = http.MultipartRequest('POST', uri);
  // if (authToken!=null) {
  request
    ..headers.addAll({
      "token": Encryption.appToken,
      if (authToken != null) "user-token": authToken,
    });
  // }

  body.forEach((key, val) {
    if (key == "tags") {
      var tags = (val as List<String>);
      for (var i = 0; i < tags.length; i++) {
        var tag = tags[i];
        request.fields["$key[$i]"] = tag.toString();
      }
      //request.fields[key] = jsonEncode(val);
    } else {
      request.fields[key] = val.toString();
    }
  });
  if (files != null && files.isNotEmpty) {
    for (int i = 0; i < files.length; i++) {
      var file = files[i];
      request.files.add(await http.MultipartFile.fromPath(
        'image_url[$i]',
        file,
        contentType: MediaType('image', 'jpeg'),
      ));
    }
  }

  if (image != null) {
    request.files.add(await http.MultipartFile.fromPath(
      'image_url',
      image,
      contentType: MediaType('image', 'jpeg'),
    ));
  }

  var response = await request.send();
  int statusCode = response.statusCode;
  if (statusCode == 200 || statusCode == 400) {
    String bodyString = await response.stream.bytesToString();
    // body = utf8.decode(body.runes.toList());
    var jsonBody = json.decode(bodyString);
    print(bodyString);
    return BaseModel.fromJson(jsonBody);
  } else {
    throw Exception(response.reasonPhrase);
  }
}

Future<BaseModel> GET(String endPoint,
    {String? authToken, Map<String, dynamic>? params, String? path}) async {
//  String url = 'https://360cubes.com/urantia_staging/public/api/user/login';

  Map<String, String> headers = {
    // "Content-Type": "application/json",
    "token": Encryption.appToken,
    "user-token": authToken ??
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjUsImlhdCI6MTU3MDc3NDE0NX0.KpeFmLLKXmqmDFhP4Jr_6i-fbhQFLwiIPuSlB6Izfvw",
  };
  String url = baseUrl + endPoint + "${path ?? ""}";
  Uri parsedUri = Uri.parse(url);
  var uri = parsedUri.replace(queryParameters: params);
  http.Response response = await http.get(
    params != null ? uri : parsedUri,
    headers: headers,
  );
  // check the status code for the result
  int statusCode = response.statusCode;
  // this API passes back the id of the new item added to the body
  if (statusCode == 200 || statusCode == 400) {
    String body = response.body;
    body = utf8.decode(body.runes.toList());
    var jsonBody = json.decode(body);
    print(body);
    return BaseModel.fromJson(jsonBody);
  } else {
    throw Exception(response.reasonPhrase);
  }
}

enum Method { Get, Post, Multipart, Delete }

Future<void> invokeAsync(
    {required String endPoint,
    required Method method,
    Map<String, dynamic>? body,
    String? image,
    List<String>? files,
    String? pathVariable,
    required Function(BaseModel baseModel) onSuccess,
    required Function(String error) onError}) async {
  if (await isConnected()) {
    print("API EndPoint: $endPoint \nMethod: ${describeEnum(method)}");
    try {
      User? user = (await Prefs.getUserSync());
      String? authToken =
          user != null && user.api_token != null && user.api_token!.isNotEmpty
              ? Encryption.encryptData(user.api_token!)
              : null;
      BaseModel baseModel;
//      = (method == Method.Get)
//          ? await GET(endPoint,authToken: authToken)
//          : await POST_FORM_DATA(endPoint, body, authToken: authToken);
      if (body != null) print("Request Body: " + body.toString());
      if (files != null && files.isNotEmpty)
        for (var file in files) {
          print("Request Body File: " + file);
        }
      switch (method) {
        case Method.Get:
          baseModel = await GET(endPoint, authToken: authToken, path: pathVariable, params: body);
          break;

        case Method.Post:
          baseModel = await POST_JSON(
            endPoint,
            body,
            authToken: authToken,
          );
          break;

        case Method.Delete:
          baseModel =
              await DELETE(endPoint, authToken: authToken, id: body!["id"]);
          break;

        case Method.Multipart:
        default:
          baseModel = await MultiPart(
            endPoint,
            body!,
            files,
            image,
            path: pathVariable,
            authToken: authToken,
          );
      }

      if (baseModel.code == 200)
        onSuccess(baseModel);
      else if (baseModel.code == 400) {
        var dataJson = baseModel.data as Map<String, dynamic>;
        onError(dataJson.values.first);
      } else {
        onError(baseModel.message);
        if (baseModel.message == "User is blocked or deleted by admin") {
          // toast("Logging Out");
          Prefs.removeUser();
          navigatorKey.currentState?.pushReplacementNamed(Login.route);
        }
      }
    } catch (error) {
      print(error.toString());
      onError(error.toString());
    }
  } else {
    onError(Const.CHECK_INTERNET);
  }
}

Future<BaseModel> invoke(
    {required String endPoint,
    required Method method,
    Map<String, dynamic>? body,
    String? authToken}) async {
//  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  if (await isConnected()) {
    print(baseUrl + endPoint);
    BaseModel baseModel = (method == Method.Get)
        ? await GET(endPoint, authToken: authToken)
        : await POST_FORM_DATA(endPoint, body!, authToken: authToken);
    if (baseModel.code == 200)
      return baseModel;
    else
      throw baseModel.message;
  } else {
    throw Const.CHECK_INTERNET;
  }
}
