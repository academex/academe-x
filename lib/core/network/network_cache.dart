// import 'package:hive/hive.dart';
//
// class NetworkCache {
//   static const Duration defaultCacheDuration = Duration(hours: 1);
//   static late Box<dynamic> _cacheBox;
//
//   static Future<void> init() async {
//     _cacheBox = await Hive.openBox('network_cache');
//   }
//
//   static Future<void> cacheResponse(
//       String key,
//       dynamic data, {
//         Duration duration = defaultCacheDuration,
//       }) async {
//     final expiryTime = DateTime.now().add(duration);
//     await _cacheBox.put(key, {
//       'data': data,
//       'expiry': expiryTime.millisecondsSinceEpoch,
//     });
//   }
//
//   static dynamic getCachedResponse(String key) {
//     final cachedData = _cacheBox.get(key);
//     if (cachedData == null) return null;
//
//     final expiryTime = DateTime.fromMillisecondsSinceEpoch(cachedData['expiry']);
//     if (DateTime.now().isAfter(expiryTime)) {
//       _cacheBox.delete(key);
//       return null;
//     }
//
//     return cachedData['data'];
//   }
// }