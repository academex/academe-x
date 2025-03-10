import 'dart:convert';
import 'package:academe_x/core/config/app_config.dart';
import 'package:academe_x/features/auth/auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../logger.dart';
import '../base/base_storage_manager.dart';
import '../config/storage_config.dart';

class HiveCacheManager implements BaseStorageManager {
  static final HiveCacheManager _instance = HiveCacheManager._internal();
  factory HiveCacheManager() => _instance;
  HiveCacheManager._internal();
  // static const Duration defaultCacheDuration = Duration(hours: 1);

  late Box<String> _cacheBox;
  late Box<String> _userBox;
  late Box<String> _settingsBox;
  int _currentCacheSize = 0;
  final bool _isInitialized = false;
  late String? cachedString;


  @override
  Future<void> init() async {

    if (_isInitialized) {
      AppLogger.i('HiveCacheManager already initialized');
      return;
    }
    try {
      await Hive.initFlutter();
      _cacheBox = await Hive.openBox<String>(StorageConfig.cacheBoxName);
      _userBox = await Hive.openBox<String>(StorageConfig.userBoxName);
      _settingsBox = await Hive.openBox<String>(StorageConfig.settingsBoxName);

      await _initializeCacheSize();
      await _cleanExpiredCache();
    } catch (e) {
      AppLogger.e('Failed to initialize cache: $e');
      rethrow;
    }
  }

  Future<void> saveSetting<T>(String key, T value) async {
    try {
      await _settingsBox.put(key, jsonEncode(value));
    } catch (e) {
      AppLogger.e('Failed to save setting: $e');
      rethrow;
    }
  }

  Future<T?> getSetting<T>(String key, T Function(dynamic) fromJson) async {
    try {
      final data = _settingsBox.get(key);
      if (data == null) return null;
      return fromJson(jsonDecode(data));
    } catch (e) {
      AppLogger.e('Failed to get setting: $e');
      return null;
    }
  }

  Future<int> getCurrentCacheSize() async {
    int totalSize = 0;

    for (var key in _cacheBox.keys) {
      final value = _cacheBox.get(key);
      if (value != null) {
        totalSize += value.length;
      }
    }

    return totalSize;
  }

  // Get size of user data box
  Future<int> getUserDataSize() async {
    int totalSize = 0;

    for (var key in _userBox.keys) {
      final value = _userBox.get(key);
      if (value != null) {
        totalSize += value.length;
      }
    }

    return totalSize;
  }

  // Get size of settings box
  Future<int> getSettingsSize() async {
    int totalSize = 0;

    for (var key in _settingsBox.keys) {
      final value = _settingsBox.get(key);
      if (value != null) {
        totalSize += value.length;
      }
    }

    return totalSize;
  }

  Future<Map<String, double>> getAllStorageSizes() async {
    return {
      'cache': (await getCurrentCacheSize())*0.001,
      'userData': (await getUserDataSize())*0.001,
      'settings': (await getSettingsSize())*0.001,
      'total': (await getCurrentCacheSize()+ await getUserDataSize()+ await getSettingsSize())*0.001
    };
  }


  // Check if total storage is approaching limit
  Future<bool> isStorageNearingLimit() async {
    final sizes = await getAllStorageSizes();
    final totalSize = sizes.values.reduce((a, b) => a + b);

    // Alert if using more than 80% of max size
    return totalSize > (StorageConfig.maxCacheSize * 0.8);
  }

  // Add this method to monitor storage size during cache operations
  Future<void> _checkStorageSize() async {
    if (await isStorageNearingLimit()) {
      AppLogger.w('Storage is nearing size limit. Consider clearing old data.');

      // Optionally trigger cleanup of old data
      await _cleanExpiredCache();
    }
  }


  Future<void> handleCacheCorruption() async {
    try {
      AppLogger.w('Attempting to handle cache corruption...');

      // Delete corrupted boxes
      await Future.wait([
        Hive.deleteBoxFromDisk(StorageConfig.cacheBoxName),
        Hive.deleteBoxFromDisk(StorageConfig.userBoxName),
        Hive.deleteBoxFromDisk(StorageConfig.settingsBoxName),
      ]);

      // Reopen boxes
      _cacheBox = await Hive.openBox<String>(StorageConfig.cacheBoxName);
      _userBox = await Hive.openBox<String>(StorageConfig.userBoxName);
      _settingsBox = await Hive.openBox<String>(StorageConfig.settingsBoxName);

    } catch (e) {
      AppLogger.e('Failed to recover from cache corruption: $e');
      rethrow;
    }
  }

  Future<void> _initializeCacheSize() async {
    _currentCacheSize = 0;
    for (var key in _cacheBox.keys) {
      final value = _cacheBox.get(key);
      if (value != null) {
        _currentCacheSize += value.length;
      }
    }
  }

  Future<void> _cleanExpiredCache() async {
    final expiredKeys = <String>[];
    for (var key in _cacheBox.keys) {
      final value = _cacheBox.get(key);
      if (value != null) {
        final data = jsonDecode(value);
        final expiryTime = DateTime.fromMillisecondsSinceEpoch(data['expiry']);
        if (DateTime.now().isAfter(expiryTime)) {
          expiredKeys.add(key.toString());
        }
      }
    }

    for (var key in expiredKeys) {
      await removeCacheItem(key);
    }
  }

  Future<void> cacheResponse<T>(
      String key,
      T data, {
        Duration duration = AppConfig.cacheMaxAge,
        bool isUser=false
      }) async {
    final expiryTime = DateTime.now().add(duration);
    final cacheData = {
      'data': data,
      'expiry': expiryTime.millisecondsSinceEpoch,
      'type': T.toString(),
    };
    final encodedData = jsonEncode(cacheData);
    final dataSize = encodedData.length;
    if (_currentCacheSize + dataSize > StorageConfig.maxCacheSize) {
      await _evictOldestEntries(requiredSpace: dataSize);
    }

    if (isUser){
    await _userBox.put(key, encodedData);
    }else{
    await _cacheBox.put(key, encodedData);
    }
    _currentCacheSize += dataSize;
    await _checkStorageSize();

  }

  Future<Map<String, dynamic>> getDiagnostics() async {
    final sizes = await getAllStorageSizes();
    return {
      'totalSize': sizes.values.reduce((a, b) => a + b),
      'boxSizes': sizes,
      'cacheEntryCount': _cacheBox.length,
      'userDataEntryCount': _userBox.length,
      'settingsEntryCount': _settingsBox.length,
      'isNearLimit': await isStorageNearingLimit(),
      'maxSize': StorageConfig.maxCacheSize,
    };
  }
  void logStorageStats() async {
    final stats = await getDiagnostics();
    stats.forEach((key, value) {
    });
  }

  Future<T?> getCachedResponse<T>(
      String key,
      T Function(dynamic) fromJson,
  {bool isUser=false}
      ) async {

    if (isUser){
      cachedString = _userBox.get(key);
    }else{
      cachedString = _cacheBox.get(key);
    }
    if (cachedString == null) return null;
    final cachedData = jsonDecode(cachedString!);
    final expiryTime = DateTime.fromMillisecondsSinceEpoch(cachedData['expiry']);

    if (DateTime.now().isAfter(expiryTime)) {
      await _cacheBox.delete(key);
      return null;
    }

    try {
      // AppLogger.success('inside getCachedResponse ${cachedData['data'] as T}');
      return fromJson(cachedData['data']);
    } catch (e,stackTrace) {

      // await _cacheBox.delete(key);
      return null;
    }
  }


  Future<void> _evictOldestEntries({required int requiredSpace}) async {
    final entries = <String, DateTime>{};

    for (var key in _cacheBox.keys) {
      final value = _cacheBox.get(key);
      if (value != null) {
        final data = jsonDecode(value);
        entries[key] = DateTime.fromMillisecondsSinceEpoch(data['expiry']);
      }
    }

    final sortedKeys = entries.keys.toList()
      ..sort((a, b) => entries[a]!.compareTo(entries[b]!));

    int freedSpace = 0;
    for (var key in sortedKeys) {
      if (freedSpace >= requiredSpace) break;
      final value = _cacheBox.get(key);
      if (value != null) {
        freedSpace += value.length;
        await removeCacheItem(key);
      }
    }
  }

  @override
  Future<void> clear() async {
    await _cacheBox.clear();
    await _userBox.clear();
    await _settingsBox.clear();
    _currentCacheSize = 0;
  }

  Future<void> removeCacheItem(String key,{bool isUser=false}) async {
    if(isUser){
      final value = _userBox.get(key);
      if (value != null) {
        _currentCacheSize -= value.length;
      }
      await _userBox.delete(key);
    }else{
      final value = _cacheBox.get(key);
      if (value != null) {
        _currentCacheSize -= value.length;
      }
      await _cacheBox.delete(key);

    }


  }

  // Future<void> updateCacheItem<T>(String key, T value) async {
  //   await _userBox.put(
  //     key,
  //     value
  //   );
  // }

  @override
  Future<void> dispose() async {
    await _cacheBox.close();
  }
}