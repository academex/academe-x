// // cache/hive_cache_manager.dart
// import 'dart:convert';
// import 'package:academe_x/core/core.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/adapters.dart';
//
// class HiveCacheManager {
//   static final HiveCacheManager _instance = HiveCacheManager._internal();
//   factory HiveCacheManager() => _instance;
//   HiveCacheManager._internal();
//
//   static const Duration defaultCacheDuration = Duration(hours: 1);
//   late Box<dynamic> _cacheBox;
//
//   Future<void> init() async {
//     await Hive.initFlutter();
//     _cacheBox = await Hive.openBox('network_cache');
//   }
//
//   Future<void> cacheResponse<T>(
//       String key,
//       T data, {
//         Duration duration = defaultCacheDuration,
//       }) async {
//     AppLogger.success('from cache response ${data}');
//     final expiryTime = DateTime.now().add(duration);
//     final cacheData = {
//       'data': data is Map ? data : jsonEncode(data),
//       'expiry': expiryTime.millisecondsSinceEpoch,
//       'type': T.toString(),
//     };
//     await _cacheBox.put(key, jsonEncode(cacheData));
//   }
//
//
//   Future<T?> getCachedResponse<T>(
//       String key,
//       T Function(dynamic) fromJson,
//       ) async {
//     final cachedString = await _cacheBox.get(key);
//     // AppLogger.e('cachedString' + cachedString);
//     if (cachedString == null) return null;
//
//     final cachedData = jsonDecode(cachedString as String);
//     final expiryTime = DateTime.fromMillisecondsSinceEpoch(cachedData['expiry']);
//
//     if (DateTime.now().isAfter(expiryTime)) {
//       await _cacheBox.delete(key);
//       return null;
//     }
//
//
//     try {
//       return fromJson(cachedData['data']);
//     } catch (e) {
//       await _cacheBox.delete(key);
//       return null;
//     }
//   }
//   // Future<T?> getCachedResponse<T>(String key) async{
//   //   AppLogger.success("from Cached ${key}");
//   //   final cachedData = await _cacheBox.get(key);
//   //   AppLogger.success("from Cached data${cachedData.toString()}");
//   //   if (cachedData == null) return null;
//   //
//   //   final expiryTime = DateTime.fromMillisecondsSinceEpoch(cachedData['expiry']);
//   //   if (DateTime.now().isAfter(expiryTime)) {
//   //     _cacheBox.delete(key);
//   //     return null;
//   //   }
//   //
//   //   // final data = cachedData['data'];
//   //   // if (data == null) return null;
//   //
//   //
//   //   // AppLogger.success(((jsonDecode(data) as List<dynamic>).cast<T>() as T).toString());
//   //   try {
//   //     if (T is List) {
//   //       return (jsonDecode(cachedData));
//   //     } else if (T == Map) {
//   //       return jsonDecode(cachedData) as T;
//   //     }
//   //
//   //   // AppLogger.success("after all data${data.toString()}");
//   //     return cachedData as T;
//   //   } catch (e) {
//   //     _cacheBox.delete(key);
//   //     return null;
//   //   }
//   // }
//
//   Future<void> clearCache() async {
//     await _cacheBox.clear();
//   }
//
//   Future<void> removeCacheItem(String key) async {
//     await _cacheBox.delete(key);
//   }
//
//   bool hasCacheExpired(String key) {
//     final cachedData = _cacheBox.get(key);
//     if (cachedData == null) return true;
//
//     final expiryTime = DateTime.fromMillisecondsSinceEpoch(cachedData['expiry']);
//     return DateTime.now().isAfter(expiryTime);
//   }
// }

import 'dart:convert';

import 'package:hive_flutter/adapters.dart';

import '../utils/logger.dart';

class HiveCacheManager {
  static final HiveCacheManager _instance = HiveCacheManager._internal();
  factory HiveCacheManager() => _instance;
  HiveCacheManager._internal();

  static const Duration defaultCacheDuration = Duration(hours: 1);
  late Box<dynamic> _cacheBox;

  Future<void> init() async {
    await Hive.initFlutter();
    _cacheBox = await Hive.openBox('network_cache');
  }

  Future<void> cacheResponse<T>(
      String key,
      T data, {
        Duration duration = defaultCacheDuration,
      }) async {
    AppLogger.e('Caching data for key: $key');
    final expiryTime = DateTime.now().add(duration);

    // final dynamic serializedData;
    // if (data is List) {
    //   try {
    //     serializedData = data.map((e) => e.toJson()).toList();
    //     AppLogger.e('Serialized list data: $serializedData');
    //   } catch (e) {
    //     AppLogger.e('Error serializing list: $e');
    //     rethrow;
    //   }
    // } else {
    //   try {
    //     serializedData = (data as dynamic).toJson();
    //     AppLogger.e('Serialized single item: $serializedData');
    //   } catch (e) {
    //     AppLogger.e('Error serializing item: $e');
    //     rethrow;
    //   }
    // }

    final cacheData = {
      'data': data,
      'expiry': expiryTime.millisecondsSinceEpoch,
      'type': T.toString(),
    };

    await _cacheBox.put(key, jsonEncode(cacheData));
  }

  Future<T?> getCachedResponse<T>(
      String key,
      T Function(dynamic) fromJson,
      ) async {
    final cachedString = await _cacheBox.get(key);
    if (cachedString == null) return null;

    final cachedData = jsonDecode(cachedString as String);
    final expiryTime = DateTime.fromMillisecondsSinceEpoch(cachedData['expiry']);

    if (DateTime.now().isAfter(expiryTime)) {
      await _cacheBox.delete(key);
      return null;
    }

    try {
      return fromJson(cachedData['data']);
    } catch (e) {
      await _cacheBox.delete(key);
      return null;
    }
  }

  Future<void> clearCache() => _cacheBox.clear();
  Future<void> removeCacheItem(String key) => _cacheBox.delete(key);
}