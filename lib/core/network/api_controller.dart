import 'dart:async';
import 'dart:convert';

import 'package:academe_x/core/config/app_config.dart';
import 'package:academe_x/core/error/exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../utils/logger.dart';

class ApiController {
  static ApiController instance = ApiController._internal();

  ApiController._internal();
  factory ApiController() {
    return instance;
  }

  static Map<String, dynamic> cacheData = {};

  Future<http.Response> get(Uri url,
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
      http.Response response = await http
          .get(url, headers: headers ?? {"Content-Type": "application/json"},)
          .timeout(AppConfig.connectionTimeout, onTimeout: () {
        // This block executes if the request times out
        throw TimeOutExeption(
            errorMessage: 'Request took longer than ${AppConfig.connectionTimeout.inSeconds} seconds.');
      });
      return response;
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

  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
        int timeAlive = 120,
  }) async {
    try {
      AppLogger.success(body.toString());

      final Map<String, String> finalHeaders = {
        'Content-Type': 'application/json',
        ...?headers,
      };

      final dynamic finalBody = body is String ? body : jsonEncode(body);
      AppLogger.success('Request URL: $url');
      AppLogger.success('Request Headers: $finalHeaders');
      AppLogger.success('Final request body: $finalBody');

      http.Response response = await http
          .post(
        url,
        headers: finalHeaders,
        body: jsonEncode(body),
      )
          .timeout(Duration(seconds: timeAlive), onTimeout: () {
        // This block executes if the request times out
        throw TimeOutExeption(
            errorMessage: 'Request took longer than $timeAlive seconds.');
      });

      AppLogger.success(response.body.toString());
      AppLogger.success(response.statusCode.toString());
      return response;
    } on TimeOutExeption catch (e) {
      // Handle timeout exception
      rethrow;
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
