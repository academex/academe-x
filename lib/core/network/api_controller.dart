import 'dart:async';
import 'dart:convert';

import 'package:academe_x/core/error/exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../config/app_config.dart';
import '../utils/logger.dart';

class ApiController {
  static ApiController instance = ApiController._internal();

  ApiController._internal();
  factory ApiController() {
    return instance;
  }

  Future<http.Response> get(
    Uri url, {
    Map<String, String>? headers,
    int timeToLive = 0,
  }) async {
    try {
      http.Response response = await http
          .get(url, headers: headers ?? {"Content-Type": "application/json"})
          .timeout(AppConfig.connectionTimeout, onTimeout: () {
        // This block executes if the request times out
        throw TimeOutExeption(
            errorMessage: 'Request took longer than ${AppConfig.connectionTimeout.inSeconds} seconds.'
        );   });
      if (AppConfig.enableDebugMode) {
        AppLogger.success('GET Response: ${response.statusCode}');
        AppLogger.success('Response body: ${response.body}');
      }
      return response;
    } catch (e) {
      Logger().e(e);
      rethrow;
    }
  }

  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
     int? timeAlive,
  }) async {
    try {
      if (AppConfig.enableDebugMode) {
        AppLogger.success(body.toString());
      }

      final Map<String, String> finalHeaders = {
        'Content-Type': 'application/json',
        ...?headers,
      };

      final dynamic finalBody = body is String ? body : jsonEncode(body);
      if (AppConfig.enableDebugMode) {
        AppLogger.success('Request URL: $url');
        AppLogger.success('Request Headers: $finalHeaders');
        AppLogger.success('Final request body: $finalBody');
      }

      http.Response response = await http
          .post(
        url,
        headers: finalHeaders,
        body: jsonEncode(body),
      )
          .timeout( Duration(seconds: timeAlive ?? AppConfig.connectionTimeout.inSeconds), onTimeout: () {
        // This block executes if the request times out
        throw TimeOutExeption(
            errorMessage: 'Request took longer than ${timeAlive ?? AppConfig.connectionTimeout.inSeconds} seconds.'
        );   });

      if (AppConfig.enableDebugMode) {
        AppLogger.success(response.body.toString());
        AppLogger.success(response.statusCode.toString());
      }
        AppLogger.success('hello world');
      return response;
    } on TimeOutExeption catch (e) {
      // Handle timeout exception
      rethrow;
    } catch (e) {
      // Handle other errors (such as parsing or HTTP errors)
      throw Exception('Request failed: $e');
    }
  }

  Future<Map<String, dynamic>> patch(
      Uri url, {
        Map<String, String>? headers,
        Object? body,
        Encoding? encoding,
        required BuildContext context,
      }) async {
    try {
      http.Response response = await http.patch(
        url,
        headers: headers ?? {"Content-Type": "application/json"},
        body: body,
        encoding: encoding,
      ).timeout(AppConfig.connectionTimeout);

      final Map<String, dynamic> data = jsonDecode(response.body);

      if (AppConfig.enableDebugMode) {
        AppLogger.success('PATCH Response: ${response.statusCode}');
        AppLogger.success('Response data: $data');
      }

      return data;
    } catch (e) {
      if (AppConfig.enableDebugMode) {
        Logger().e(e);
      }
      rethrow;
    }
  }

  Future<Map<String, dynamic>> delete(
      Uri url, {
        Map<String, String>? headers,
        Object? body,
        Encoding? encoding,
        required BuildContext context,
      }) async {
    try {
      http.Response response = await http.delete(
        url,
        headers: headers ?? {"Content-Type": "application/json"},
        body: body,
        encoding: encoding,
      ).timeout(AppConfig.connectionTimeout);

      final Map<String, dynamic> data = jsonDecode(response.body);

      if (AppConfig.enableDebugMode) {
        AppLogger.success('DELETE Response: ${response.statusCode}');
        AppLogger.success('Response data: $data');
      }

      return data;
    } catch (e) {
      if (AppConfig.enableDebugMode) {
        Logger().e(e);
      }
      rethrow;
    }
  }
}
