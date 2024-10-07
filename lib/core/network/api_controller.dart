import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ApiController {
  static ApiController instance = ApiController._internal();

  ApiController._internal();
  factory ApiController() {
    return instance;
  }

  static Map<String, dynamic> cacheData = {};

  Future<Map> get(Uri url,
      {Map<String, String>? headers,
      int timeToLive = 0,
      bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        cacheData.remove(url.toString());
      }
      if (cacheData.keys.contains(url.toString())) {
        if (timeIsNotExpires(url)) {
          return cacheData[url.toString()];
        }
      }
      http.Response response = await http.get(url,
          headers: headers ?? {"Content-Type": "application/json"});

      Map<String, dynamic> data = await jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Logger().i( );
        if (timeToLive > 0) {
          cacheData[url.toString()] = data;
          cacheData['mainCategory'] = data['data']['mainCategories'];
          cacheData['${url}cacheTime'] = timeToLive;
          cacheData['${url}saveTime'] = DateTime.now();
        }
        return data;
      } else {
        Logger().i(data);
        return data;
      }

    } catch (e) {
      Logger().e(e);
      rethrow;
    }
  }

  bool timeIsNotExpires(Uri url) {
    DateTime now = DateTime.now();
    DateTime timeExpires = cacheData['${url}saveTime'];
    return now.difference(timeExpires).inSeconds > 0;
  }

  Future<Map> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    // Logger().i(body);
    // Logger().i(url);
    http.Response response = await http.post(url,
        headers: headers ?? {'Content-Type': 'application/json'}, body: body);
    // Logger().i(body);
    // Logger().i(response.body);
    // Logger().i(response.statusCode);
    Map<String, dynamic> data = await jsonDecode(response.body);
    return data;
  }

  Future<Map> patch(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    required BuildContext context,
  }) async {
    http.Response response = await http.patch(url,
        headers: headers ?? {"Content-Type": "application/json"},
        body: body,
        encoding: encoding);
    Map<String, dynamic> data = await jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    } else {
      return data;
    }
  }

  Future<Map> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    required BuildContext context,
  }) async {
    http.Response response = await http.delete(url,
        headers: headers ?? {"Content-Type": "application/json"},
        body: body,
        encoding: encoding);
    Map<String, dynamic> data = await jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    } else {
      return data;
    }
  }
}
