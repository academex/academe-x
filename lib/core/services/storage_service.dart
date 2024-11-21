import 'package:academe_x/lib.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  static late Box _box;

  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox('academeX_box');
  }
  static Future<void> saveUser(AuthTokenModel user) async {
    if (kDebugMode) {
      print(user.toJson());
    }
    await _box.put('user', user.toJson());
  }
   AuthTokenModel? getUser() {
    final userData = _box.get('user');
    if (userData == null) return null;
    return AuthTokenModel.fromJson(userData);
  }

  static Future<void> clearUser() async {
    await _box.delete('user');
  }


  // Future<void> checkAuthStatus() async {
  //   try {
  //     // Get the stored user data using your existing method
  //     final AuthTokenModel? userData = getUser();
  //
  //     if (userData != null&& userData.accessToken.isNotEmpty) {
  //       emit(AuthStatus.authenticated);
  //     } else {
  //       emit(AuthStatus.unauthenticated);
  //     }
  //   } catch (e) {
  //     emit(AuthStatus.unauthenticated);
  //   }
  // }

}