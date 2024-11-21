import 'dart:convert';

import 'package:academe_x/lib.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  static late Box _box;

  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox('academeX_box');
  }
   Future<void> saveUser(AuthTokenModel user) async {
    if (kDebugMode) {
      print(user.toJson());
    }
    await _box.put('user', jsonEncode(user.toJson()));
  }
   AuthTokenModel? getUser() {
    final userData = _box.get('user');
    AppLogger.d(userData.toString());
    if (userData == null) return null;
    return AuthTokenModel.fromJson(jsonDecode(userData));
  }

  static Future<void> clearUser() async {
    await _box.delete('user');
  }



  // static Future<void> saveTheme(bool isDark) async {
  //   await _box.put('isDark', isDark);
  // }
  //
  // static bool getTheme() {
  //   return _box.get('isDark', defaultValue: false);
  // }
}