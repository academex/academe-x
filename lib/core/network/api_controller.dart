import 'dart:async';
import 'dart:convert';

import 'package:academe_x/core/error/exception.dart';
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
          // cacheData['mainCategory'] = data['data']['mainCategories'];
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


  Future<Map<String, dynamic>> post(
      Uri url, {
        Map<String, String>? headers,
        Object? body,
        Encoding? encoding,
        required int timeAlive,
      }) async {
    try {
      Logger().w(url);
      Logger().w(body.toString());
      // Use Future.timeout to set a time limit for the request
      http.Response response = await http
          .post(
        url,
        // headers: headers ?? {'Content-Type': 'application/json'},
        body: body,
      ).timeout(Duration(seconds: timeAlive), onTimeout: () {
        // This block executes if the request times out
        throw TimeOutExeption(errorMessage: 'Request took longer than $timeAlive seconds.');
      });

      Logger().w(response.body);
      if(response.statusCode == 401){
        throw WrongDataException(errorMessage: 'wrong username or password');
      }
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;

    } on WrongDataException catch (e) {
      // Handle timeout exception
      throw WrongDataException(errorMessage: e.errorMessage);
    } on TimeOutExeption catch (e) {
      // Handle timeout exception
      throw TimeOutExeption(errorMessage: e.errorMessage);
    } catch (e) {
      // Handle other errors (such as parsing or HTTP errors)
      throw Exception('Request failed: $e');
    }
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
