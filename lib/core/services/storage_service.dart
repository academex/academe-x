// import 'package:hive_flutter/hive_flutter.dart';
//
// class StorageService {
//   static late Box _box;
//
//   static Future<void> init() async {
//     await Hive.initFlutter();
//     _box = await Hive.openBox('app_box');
//   }
//
//   static Future<void> saveUser(UserEntity user) async {
//     await _box.put('user', user.toJson());
//   }
//
//   static UserEntity? getUser() {
//     final userData = _box.get('user');
//     if (userData == null) return null;
//     return UserEntity.fromJson(userData);
//   }
//
//   static Future<void> clearUser() async {
//     await _box.delete('user');
//   }
//
//   static Future<void> saveTheme(bool isDark) async {
//     await _box.put('isDark', isDark);
//   }
//
//   static bool getTheme() {
//     return _box.get('isDark', defaultValue: false);
//   }
// }